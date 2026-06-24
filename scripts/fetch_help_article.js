#!/usr/bin/env node
/**
 * Fetches and extracts clean content from Twilio Help Center articles (help.twilio.com).
 * Uses system Chrome with JS enabled and waits for content to fully render.
 *
 * Usage: node scripts/fetch_help_article.js "https://help.twilio.com/articles/ARTICLE_ID"
 * Returns: JSON with title, clean content, and URL
 */

const puppeteer = require('puppeteer');

async function fetchHelpArticle(url) {
  const browser = await puppeteer.launch({
    headless: true,
    executablePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-blink-features=AutomationControlled']
  });

  try {
    const page = await browser.newPage();
    await page.setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');

    await page.goto(url, { waitUntil: 'networkidle2', timeout: 30000 });
    await new Promise(r => setTimeout(r, 5000));

    const result = await page.evaluate(() => {
      const article = document.querySelector('article');
      const titleEl = article ? article.querySelector('h2, h3') : null;
      const pageH1 = document.querySelector('h1');
      const title = (titleEl ? titleEl.textContent.trim() : null) || (pageH1 ? pageH1.textContent.trim() : document.title);

      if (article) {
        ['nav', 'header', 'footer', 'script', 'style'].forEach(sel => {
          article.querySelectorAll(sel).forEach(el => el.remove());
        });
      }

      const content = article ? article.innerText.trim() : document.body.innerText.trim();
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
