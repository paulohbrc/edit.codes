# Downloads pinned third-party bundles into vendor/ (offline, no CDN at runtime).
# Run from repo root: .\scripts\vendorize.ps1

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$Vendor = Join-Path $Root "vendor"
$Fonts = Join-Path $Vendor "fonts"

New-Item -ItemType Directory -Force -Path $Vendor, $Fonts | Out-Null

$files = [ordered]@{
  "marked.min.js"              = "https://cdn.jsdelivr.net/npm/marked@15/marked.min.js"
  "highlight.min.js"           = "https://cdn.jsdelivr.net/npm/highlight.js@11.11.1/highlight.min.js"
  "highlight-github-dark.min.css" = "https://cdn.jsdelivr.net/npm/highlight.js@11.11.1/styles/github-dark.min.css"
  "katex.min.js"               = "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js"
  "katex.min.css"              = "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css"
  "katex-auto-render.min.js"   = "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js"
  "mermaid.min.js"             = "https://cdn.jsdelivr.net/npm/mermaid@10.9.3/dist/mermaid.min.js"
}

foreach ($entry in $files.GetEnumerator()) {
  $out = Join-Path $Vendor $entry.Key
  Write-Host "Downloading $($entry.Key) ..."
  Invoke-WebRequest -Uri $entry.Value -OutFile $out -UseBasicParsing
}

$fontBase = "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/fonts/"
$fontNames = @(
  "KaTeX_AMS-Regular","KaTeX_Caligraphic-Bold","KaTeX_Caligraphic-Regular",
  "KaTeX_Fraktur-Bold","KaTeX_Fraktur-Regular","KaTeX_Main-Bold","KaTeX_Main-BoldItalic",
  "KaTeX_Main-Italic","KaTeX_Main-Regular","KaTeX_Math-BoldItalic","KaTeX_Math-Italic",
  "KaTeX_SansSerif-Bold","KaTeX_SansSerif-Italic","KaTeX_SansSerif-Regular",
  "KaTeX_Script-Regular","KaTeX_Size1-Regular","KaTeX_Size2-Regular","KaTeX_Size3-Regular",
  "KaTeX_Size4-Regular","KaTeX_Typewriter-Regular"
)
$exts = @("woff2", "woff", "ttf")
foreach ($name in $fontNames) {
  foreach ($ext in $exts) {
    $file = "$name.$ext"
    $out = Join-Path $Fonts $file
    Write-Host "Downloading fonts/$file ..."
    Invoke-WebRequest -Uri ($fontBase + $file) -OutFile $out -UseBasicParsing
  }
}

Write-Host "Done. Vendor tree ready under $Vendor"