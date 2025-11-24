# 📊 Viewing Interactive HTML Files

GitHub doesn't render HTML files directly. Here are several ways to view the interactive coverage analysis:

---

## 🎯 Method 1: Download and Open Locally ⭐ Easiest

1. **Download the HTML file:**
   - Click on `rd03d-coverage-analysis.html`
   - Click "Raw" button (top right)
   - Right-click → Save As
   - Or use: `docs/rd03d-coverage-analysis.html`

2. **Open in browser:**
   - Double-click the downloaded file
   - Or right-click → Open With → Browser

✅ **Works perfectly!** All animations and interactivity preserved.

---

## 🌐 Method 2: GitHub Pages (Best for Sharing)

Enable GitHub Pages for your repository:

1. **Repository Settings:**
   - Go to Settings
   - Scroll to "Pages"
   - Source: Deploy from branch
   - Branch: main
   - Folder: / (root)
   - Save

2. **Access URL:**
   ```
   https://YOUR_USERNAME.github.io/rd-03d-esphome/docs/rd03d-coverage-analysis.html
   ```

3. **Update README:**
   ```markdown
   View [Interactive Coverage Map](https://YOUR_USERNAME.github.io/rd-03d-esphome/docs/rd03d-coverage-analysis.html)
   ```

✅ **Permanent link** - Share with anyone!

---

## 🔗 Method 3: rawgit.com / raw.githack.com

Use a CDN service to serve raw HTML:

### raw.githack.com (Recommended):

**For Development:**
```
https://raw.githack.com/YOUR_USERNAME/rd-03d-esphome/main/docs/rd03d-coverage-analysis.html
```

**For Production:**
```
https://rawcdn.githack.com/YOUR_USERNAME/rd-03d-esphome/COMMIT_HASH/docs/rd03d-coverage-analysis.html
```

### How to use:

1. Go to [raw.githack.com](https://raw.githack.com/)
2. Paste your GitHub HTML file URL
3. Copy the generated URL
4. Share or embed

✅ **No setup needed** - Works immediately!

---

## 📱 Method 4: HTML Preview Services

### Option A: htmlpreview.github.io

```
https://htmlpreview.github.io/?https://github.com/YOUR_USERNAME/rd-03d-esphome/blob/main/docs/rd03d-coverage-analysis.html
```

### Option B: raw.githack.com

```
https://raw.githack.com/YOUR_USERNAME/rd-03d-esphome/main/docs/rd03d-coverage-analysis.html
```

### Option C: GitHub + GitLab Pages

If you have accounts on both platforms, use GitLab Pages for HTML hosting.

---

## 💻 Method 5: Clone Repository

For developers:

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/rd-03d-esphome.git

# Navigate to docs
cd rd-03d-esphome/docs

# Open HTML file
# On Windows:
start rd03d-coverage-analysis.html

# On Mac:
open rd03d-coverage-analysis.html

# On Linux:
xdg-open rd03d-coverage-analysis.html
```

---

## 📋 Comparison Table

| Method | Setup | Speed | Sharing | Recommended |
|--------|-------|-------|---------|-------------|
| **Download & Open** | None | ⚡ Instant | ⚠️ Manual | ⭐⭐⭐ Best for personal use |
| **GitHub Pages** | One-time | ⏱️ 1 min | ✅ Easy URL | ⭐⭐⭐ Best for sharing |
| **raw.githack.com** | None | ⚡ Instant | ✅ Easy URL | ⭐⭐ Good alternative |
| **htmlpreview** | None | ⏱️ Slow | ⚠️ Long URL | ⭐ Backup option |
| **Clone Repo** | Git required | ⏱️ Varies | ❌ Not practical | ⭐ Developer only |

---

## 🎯 Recommended Workflow

### For You (Project Owner):
1. ✅ Enable GitHub Pages (one-time setup)
2. ✅ Update README with GitHub Pages URL
3. ✅ Share permanent link with community

### For Users:
1. ✅ Download HTML and open locally
2. ✅ Or use GitHub Pages URL if available

---

## 📝 Example README Update

Replace your coverage analysis link in README.md:

### Before (Broken):
```markdown
- 📐 [Coverage Analysis](docs/coverage-analysis.md)
```

### After (Working):
```markdown
- 📐 Coverage Analysis:
  - [Detailed Calculations](docs/coverage-analysis.md) - Mathematical analysis
  - [Interactive Map](https://YOUR_USERNAME.github.io/rd-03d-esphome/docs/rd03d-coverage-analysis.html) - Visual coverage map 🎨
  - Or [download HTML](docs/rd03d-coverage-analysis.html) and open locally
```

---

## 🔧 Troubleshooting

### "Page not found" on GitHub Pages
- Wait 1-2 minutes after enabling
- Check branch is set to `main`
- Verify file path is correct

### "Mixed content" warning
- HTML file uses only relative paths
- No external dependencies
- Should work everywhere

### Animations not working
- Make sure JavaScript is enabled
- Try different browser
- Check browser console for errors

---

## 💡 Pro Tips

1. **GitHub Pages URL Structure:**
   ```
   https://USERNAME.github.io/REPO_NAME/path/to/file.html
   ```

2. **Update README with both options:**
   - Markdown for calculations
   - HTML for visualization

3. **Screenshot alternative:**
   - Take screenshot of HTML
   - Add to README as image
   - Link to HTML for full experience

---

## ✅ Quick Setup Checklist

For GitHub Pages (Recommended):

```
□ Go to repository Settings
□ Click "Pages" in sidebar
□ Set Source to "main" branch
□ Save changes
□ Wait 1-2 minutes
□ Test URL: https://USERNAME.github.io/REPO/docs/rd03d-coverage-analysis.html
□ Update README with URL
□ Done! ✨
```

---

**Now your HTML files are accessible to everyone!** 🎉

[⬆ Back to Documentation](../README.md)
