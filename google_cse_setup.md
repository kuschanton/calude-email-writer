# Google Programmable Search Engine Setup

## Overview

This project uses Google Programmable Search Engine (CSE) for web searches to find Twilio documentation and resources. The search is performed via Puppeteer web scraping (not the deprecated JSON API).

## Current Configuration

- **CSE ID**: `a3bf832e785924d93`
- **CSE URL**: https://cse.google.com/cse?cx=a3bf832e785924d93
- **Control Panel**: https://programmablesearchengine.google.com/controlpanel/all

## Setup Instructions

### 1. Create a New Search Engine

1. Go to https://programmablesearchengine.google.com/controlpanel/all
2. Click "Add" to create a new search engine
3. Give it a name (e.g., "Twilio Docs Search")
4. Under "What to search", choose "Search specific sites or pages"

### 2. Add Domains

You need to add domains in the format: `*.domain.com/*`

**Copy this list** (already prepared in clipboard):

```
*.twilio.com/*
*.github.com/*
*.stackoverflow.com/*
*.medium.com/*
*.dev.to/*
*.hashnode.dev/*
*.substack.com/*
*.notion.site/*
*.google.com/*
*.cloudflare.com/*
*.fastly.com/*
*.akamai.com/*
*.aws.amazon.com/*
*.azure.microsoft.com/*
*.cloud.google.com/*
*.heroku.com/*
*.vercel.app/*
*.netlify.app/*
*.railway.app/*
*.render.com/*
*.fly.io/*
*.digitalocean.com/*
*.linode.com/*
*.vultr.com/*
*.docker.com/*
*.kubernetes.io/*
*.nginx.com/*
*.apache.org/*
*.redis.io/*
*.mongodb.com/*
*.postgresql.org/*
*.mysql.com/*
*.sqlite.org/*
*.elastic.co/*
*.segment.com/*
*.stripe.com/*
*.sendgrid.com/*
```

### 3. Configure Search Settings

- **Search the entire web**: OFF (only search specified sites)
- **Image search**: OFF (we only need text results)
- **Speech input**: OFF
- **Safe Search**: OFF

### 4. Get Your CSE ID

1. After creating the search engine, go to the control panel
2. Click on your search engine
3. In the "Basics" tab, you'll see "Search engine ID"
4. Copy the ID (format: `a3bf832e785924d93`)

### 5. Update .env File

Update the `.env` file in the project root:

```bash
GOOGLE_CSE_ID=your_cse_id_here
```

### 6. Test the Search

Run the test script:

```bash
./scripts/test_search.sh "Verify guidance for China"
```

This will:
1. Launch headless Chrome
2. Navigate to your CSE URL
3. Perform the search
4. Extract results (title, URL, snippet)
5. Print JSON and plain URLs

## Limitations

- **50 domain limit**: Google CSE allows max 50 domains per search engine
- **No API costs**: Using Puppeteer web scraping, so no API usage charges
- **No metrics**: Google Console metrics don't track web-based searches (only JSON API usage)

## Files

- `.env` - Contains CSE ID
- `scripts/google_cse_ui.js` - Puppeteer script for web scraping
- `scripts/test_search.sh` - Test wrapper script
- `package.json` - Node.js dependencies (puppeteer)

## Notes

- The Google Custom Search JSON API is deprecated (closes Jan 1, 2027)
- This web scraping approach is free and has no usage limits
- Some domains (e.g., *.swagger.io, *.readthedocs.io) are rejected by Google and cannot be added
