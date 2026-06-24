#!/usr/bin/env node
/**
 * Fetches and extracts clean content from Twilio Help Center articles (help.twilio.com).
 * Uses Puppeteer to render JavaScript-heavy pages before extracting text.
 *
 * Usage: node scripts/fetch_help_article.js "https://help.twilio.com/articles/ARTICLE_ID"
 * Returns: JSON with title, clean content, and URL
 */

const puppeteer = require('puppeteer');

async function fetchHelpArticle(url) {
  const browser = await puppeteer.launch({
    headless: 'new',
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });

  try {
    const page = await browser.newPage();
    // Set a real browser user agent
    await page.setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');

    await page.goto(url, { waitUntil: 'networkidle2', timeout: 20000 });

    // Dismiss cookie consent if present
    const consentSelectors = [
      '#onetrust-accept-btn-handler',
      '.truste_cursor_pointer',
      'button[aria-label="Accept all cookies"]',
      'button[id*="accept"]',
      'iframe[id*="consent"]'
    ];
    for (const sel of consentSelectors) {
      try {
        const el = await page.$(sel);
        if (el) { await el.click(); break; }
      } catch (_) {}
    }

    // If there's a consent iframe, click accept inside it
    const frames = page.frames();
    for (const frame of frames) {
      try {
        const btn = await frame.$('a.call, button.call, #accept, .acceptAllBtn');
        if (btn) { await btn.click(); break; }
      } catch (_) {}
    }

    // Wait for cookie overlay to clear and content to load
    await new Promise(r => setTimeout(r, 2000));

    // Wait for article content to render
    await page.waitForSelector('article, .article-body, [data-test="article-content"], .hc-article-body', { timeout: 10000 })
      .catch(() => {});

    const result = await page.evaluate(() => {
      // Try multiple selectors for the article body
      const bodySelectors = [
        'article',
        '.article-body',
        '[data-test="article-content"]',
        '.hc-article-body',
        'main'
      ];

      let bodyEl = null;
      for (const sel of bodySelectors) {
        bodyEl = document.querySelector(sel);
        if (bodyEl) break;
      }

      // Title
      const titleEl = document.querySelector('h1, .article-title, [data-test="article-title"]');
      const title = titleEl ? titleEl.textContent.trim() : document.title;

      // Clean content - remove nav, header, footer, scripts, styles
      if (bodyEl) {
        ['nav', 'header', 'footer', 'script', 'style', '.breadcrumbs', '.article-votes'].forEach(sel => {
          bodyEl.querySelectorAll(sel).forEach(el => el.remove());
        });
      }

      const content = bodyEl ? bodyEl.innerText.trim() : document.body.innerText.trim();

      return { title, content, url: window.location.href };
    });

    return result;

  } finally {
    await browser.close();
  }
}

const url = process.argv[2];

if (!url) {
  console.error('Usage: node scripts/fetch_help_article.js "https://help.twilio.com/articles/ARTICLE_ID"');
  process.exit(1);
}

fetchHelpArticle(url)
  .then((result) => {
    console.log(JSON.stringify(result, null, 2));
  })
  .catch((error) => {
    console.error('Error:', error.message);
    process.exit(1);
  });
