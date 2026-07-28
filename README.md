# chrome-store-promo-screenshot

A [Cursor](https://cursor.com) Agent Skill that composes **Chrome Web Store** promo screenshots (**1280 × 800 PNG**) from real product UI captures: gradient backdrop, brand + title/subtitle, macOS-style browser chrome, optional two-step overlay.

中文说明见 [README.zh.md](./README.zh.md)。

## Requirements

- [Cursor](https://cursor.com) with Agent Skills enabled
- **macOS** for the included Swift/AppKit render template (`scripts/render_store_shot.swift`)
- Other OS: the skill rules still apply; use an equivalent local compositor (e.g. Pillow) that matches the visual template

## Install

```bash
git clone https://github.com/<you>/chrome-store-promo-screenshot.git \
  ~/.cursor/skills/chrome-store-promo-screenshot
```

Or copy this folder to:

`~/.cursor/skills/chrome-store-promo-screenshot/`

Then start a **new** Agent chat.

## Usage

Ask the agent, for example:

> Use skill `chrome-store-promo-screenshot`.  
> Source: `path/to/capture.png`  
> Brand: `Your App`  
> Title: `Your main headline`  
> Subtitle: `Optional supporting line`  
> Theme: `teal-blue`

Themes: [themes.md](./themes.md) · 中文：[themes.zh.md](./themes.zh.md)

Agent instructions: [SKILL.md](./SKILL.md) · 中文：[SKILL.zh.md](./SKILL.zh.md)

## Layout modes

| Mode | Use when |
|------|----------|
| `full` | One capture, show the full UI in the browser frame (default) |
| `two-step` | Combine step-1 scene + step-2 popup card |
| `replace-overlay` | Only swap the floating popup on an existing compose |

## License

MIT — see [LICENSE](./LICENSE).
