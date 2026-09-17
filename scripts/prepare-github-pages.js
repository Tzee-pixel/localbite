const fs = require('fs');
const path = require('path');

const distDir = path.resolve(__dirname, '..', 'dist');
const indexPath = path.join(distDir, 'index.html');
const notFoundPath = path.join(distDir, '404.html');
const noJekyllPath = path.join(distDir, '.nojekyll');

if (!fs.existsSync(distDir)) {
  console.error('dist directory does not exist! Run expo export first.');
  process.exit(1);
}

// 1. Ensure .nojekyll exists
fs.writeFileSync(noJekyllPath, '', 'utf8');
console.log('Created .nojekyll');

// 2. 404.html script (spa-github-pages redirector for single segment repo /localbite)
const notFoundHtml = `<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>LocalBite</title>
    <script type="text/javascript">
      // Single Page Apps for GitHub Pages
      // MIT License
      // https://github.com/rafgraph/spa-github-pages
      var pathSegmentsToKeep = 1;
      var l = window.location;
      l.replace(
        l.protocol + '//' + l.hostname + (l.port ? ':' + l.port : '') +
        l.pathname.split('/').slice(0, 1 + pathSegmentsToKeep).join('/') + '/?/' +
        l.pathname.slice(1).split('/').slice(pathSegmentsToKeep).join('/').replace(/&/g, '~and~') +
        (l.search ? '&' + l.search.slice(1).replace(/&/g, '~and~') : '') +
        l.hash
      );
    </script>
  </head>
  <body>
  </body>
</html>
`;
fs.writeFileSync(notFoundPath, notFoundHtml, 'utf8');
console.log('Created 404.html for GitHub Pages SPA routing');

// 3. Inject receiver script into dist/index.html head
if (fs.existsSync(indexPath)) {
  let indexHtml = fs.readFileSync(indexPath, 'utf8');
  const redirectReceiverScript = `
    <script type="text/javascript">
      // Single Page Apps for GitHub Pages
      // MIT License
      // https://github.com/rafgraph/spa-github-pages
      (function(l) {
        if (l.search[1] === '/' ) {
          var decoded = l.search.slice(1).split('&').map(function(s) { 
            return s.replace(/~and~/g, '&')
          }).join('?');
          window.history.replaceState(null, null,
              l.pathname.slice(0, -1) + decoded + l.hash
          );
        }
      }(window.location))
    </script>
  `;

  if (!indexHtml.includes('spa-github-pages')) {
    indexHtml = indexHtml.replace('<head>', '<head>' + redirectReceiverScript);
    fs.writeFileSync(indexPath, indexHtml, 'utf8');
    console.log('Injected SPA redirect receiver into index.html');
  }
}
