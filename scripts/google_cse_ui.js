#!/usr/bin/env node
/**
 * Google Custom Search Engine (CSE) UI scraper
 * Uses Puppeteer to scrape Google CSE results
 *
 * Usage: node scripts/google_cse_ui.js "search query" [max_results]
 */

const puppeteer = require('puppeteer');

const CSE_ID = 'a3bf832e785924d93';
const CSE_URL = `https://cse.google.com/cse?cx=${CSE_ID}`;

async function searchGoogleCSE(query, maxResults = 10) {
  const browser = await puppeteer.launch({
    headless: 'new',
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });

  try {
    const page = await browser.newPage();
    
    // Build search URL directly
    const searchUrl = `${CSE_URL}&q=${encodeURIComponent(query)}`;
    await page.goto(searchUrl, { waitUntil: 'networkidle2', timeout: 15000 });

    // Wait for results to load
    await page.waitForSelector('.gsc-webResult, .gs-webResult', { timeout: 10000 });

    // Extract results
    const results = await page.evaluate((max) => {
      const resultElements = document.querySelectorAll('.gsc-webResult, .gs-webResult');
      const extracted = [];

      for (let i = 0; i < Math.min(resultElements.length, max); i++) {
        const result = resultElements[i];
        const titleElement = result.querySelector('.gs-title, .gsc-thumbnail-inside a');
        const snippetElement = result.querySelector('.gs-snippet, .gsc-table-result .gs-snippet');
        
        if (titleElement) {
          const linkElement = titleElement.tagName === 'A' ? titleElement : titleElement.querySelector('a');
          if (linkElement) {
            extracted.push({
              title: titleElement.textContent.trim(),
              url: linkElement.href,
              snippet: snippetElement ? snippetElement.textContent.trim() : ''
            });
          }
        }
      }

      return extracted;
    }, maxResults);

    return results;

  } finally {
    await browser.close();
  }
}

// Main execution
const query = process.argv[2];
const maxResults = parseInt(process.argv[3]) || 10;

if (!query) {
  console.error('Usage: node scripts/google_cse_ui.js "search query" [max_results]');
  process.exit(1);
}

searchGoogleCSE(query, maxResults)
  .then((results) => {
    if (results.length === 0) {
      console.log('No results found.');
      return;
    }

    console.log(`Found ${results.length} results:\n`);
    results.forEach((result, index) => {
      console.log(`${index + 1}. ${result.title}`);
      console.log(`   ${result.url}`);
      if (result.snippet) {
        console.log(`   ${result.snippet.substring(0, 200)}...`);
      }
      console.log('');
    });
  })
  .catch((error) => {
    console.error('Error:', error.message);
    process.exit(1);
  });
