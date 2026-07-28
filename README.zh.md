# chrome-store-promo-screenshot

[Cursor](https://cursor.com) Agent Skill：用**真实产品截图**合成 Chrome 网上应用店宣传图（**1280 × 800 PNG**）——渐变背景、品牌名与主副标题、macOS 风格浏览器框，支持两步操作叠图。

English: [README.md](./README.md)

## 环境要求

- 已启用 Agent Skills 的 Cursor
- 自带 Swift 出图模板需要 **macOS**（`scripts/render_store_shot.swift`）
- 其他系统：仍可按 skill 规则出图，需自备等价合成方式（如 Pillow），版式对齐即可

## 安装

```bash
git clone https://github.com/LightRoot1823/chrome-store-promo-screenshot.git \
  ~/.cursor/skills/chrome-store-promo-screenshot
```

或把本文件夹复制到：

`~/.cursor/skills/chrome-store-promo-screenshot/`

然后**新开**一个 Agent 对话。

## 用法

对 Agent 说，例如：

> 按 skill `chrome-store-promo-screenshot` 做商店图。  
> 原图：`path/to/capture.png`  
> 品牌：`你的应用名`  
> 主标题：`一句话卖点`  
> 副标题：`可选补充说明`  
> 主题：`teal-blue`

主题表：[themes.zh.md](./themes.zh.md) · [themes.md](./themes.md)  
规则说明：[SKILL.zh.md](./SKILL.zh.md) · [SKILL.md](./SKILL.md)

## 构图模式

| 模式 | 场景 |
|------|------|
| `full` | 单张原图完整放进浏览器框（默认） |
| `two-step` | 步骤 1 场景 + 步骤 2 弹窗叠一张 |
| `replace-overlay` | 已有合成图，只换浮层弹窗 |

## 许可

MIT，见 [LICENSE](./LICENSE)。
