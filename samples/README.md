# HTML samples (Code Online · `edit.codes/`)

Single-page HTML tutorials loaded by the root playground ([`index.html`](../index.html)).

## Files

| File | Language |
|------|----------|
| `en.html` | English |
| `pt.html` | Português |
| `es.html` | Español |

## Add a language (e.g. French)

1. Copy `en.html` → `fr.html` and translate (keep structure / CSS / JS hooks).
2. Add `"fr"` to `SAMPLE_LANGS` in root `index.html` (and the language `<select>` + `I18N.fr`).
3. Redeploy the `samples/` folder.

```powershell
node scripts/generate-html-samples.js   # validates files exist
```

## Notes

- **Source of truth:** edit `samples/*.html` directly (hand-authored).
- The app loads via `fetch('samples/{lang}.html')` and falls back to in-memory `buildSample()` if that fails (`file://`).
