import AppKit

// Template for chrome-store-promo-screenshot skill (macOS).
// Renders titles at 2× backing resolution, then downsamples to 1280×800.
// Adapt configure block, then:
//   swift render_store_shot.swift

enum Theme: String {
    case tealBlue = "teal-blue"
    case slateNavy = "slate-navy"
    case forest = "forest"
    case charcoalTeal = "charcoal-teal"
    case oliveInk = "olive-ink"

    var colors: [NSColor] {
        switch self {
        case .tealBlue:
            return [c(0x263E8D), c(0x3152B4), c(0x117D74)]
        case .slateNavy:
            return [c(0x1B2A4A), c(0x243B6B), c(0x3A4F6A)]
        case .forest:
            return [c(0x143D38), c(0x1B5C4E), c(0x2F6B4F)]
        case .charcoalTeal:
            return [c(0x121820), c(0x1A2E38), c(0x0F4C46)]
        case .oliveInk:
            return [c(0x2A2F28), c(0x3A4540), c(0x2F5548)]
        }
    }
}

func c(_ hex: UInt32, alpha: CGFloat = 1) -> NSColor {
    NSColor(
        red: CGFloat((hex >> 16) & 255) / 255,
        green: CGFloat((hex >> 8) & 255) / 255,
        blue: CGFloat(hex & 255) / 255,
        alpha: alpha
    )
}

func rounded(_ rect: NSRect, radius: CGFloat, fill: NSColor) {
    fill.setFill()
    NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius).fill()
}

// ——— configure (placeholders — replace per job) ———
let theme = Theme.tealBlue
let brand = "Your App"
let title = "Your main headline"
let subtitle: String? = "Optional supporting line"
let sourcePath = "SOURCE.png"
let outputPath = "OUTPUT-store-1280x800.png"
// ———————————————————————————————————————————————

let outW = 1280
let outH = 800
let scale = 2

guard let source = NSImage(contentsOfFile: sourcePath) else {
    fatalError("Missing source: \(sourcePath)")
}

guard let hiRes = NSBitmapImageRep(
    bitmapDataPlanes: nil,
    pixelsWide: outW * scale,
    pixelsHigh: outH * scale,
    bitsPerSample: 8,
    samplesPerPixel: 4,
    hasAlpha: true,
    isPlanar: false,
    colorSpaceName: .deviceRGB,
    bytesPerRow: 0,
    bitsPerPixel: 0
) else {
    fatalError("Unable to create 2× bitmap")
}
// Point size stays 1280×800 so drawing code matches the template;
// pixels are 2560×1600 for sharp type.
hiRes.size = NSSize(width: outW, height: outH)

let canvasSize = NSSize(width: outW, height: outH)
let result = NSImage(size: canvasSize)
result.addRepresentation(hiRes)
result.lockFocusFlipped(true)
guard let graphics = NSGraphicsContext.current else {
    fatalError("No graphics context")
}
graphics.imageInterpolation = .high
graphics.shouldAntialias = true
graphics.cgContext.interpolationQuality = .high

let canvas = NSRect(origin: .zero, size: canvasSize)
NSGradient(colors: theme.colors)!.draw(in: canvas, angle: -12)

c(0xFFFFFF, alpha: 0.045).setFill()
NSBezierPath(ovalIn: NSRect(x: -155, y: 225, width: 640, height: 640)).fill()
c(0x8FE2D9, alpha: 0.08).setFill()
NSBezierPath(ovalIn: NSRect(x: 930, y: -175, width: 530, height: 530)).fill()

(brand as NSString).draw(
    at: NSPoint(x: 58, y: 28),
    withAttributes: [
        .font: NSFont.systemFont(ofSize: 22, weight: .semibold),
        .foregroundColor: NSColor.white
    ]
)

(title as NSString).draw(
    at: NSPoint(x: 56, y: 62),
    withAttributes: [
        .font: NSFont.systemFont(ofSize: 49, weight: .bold),
        .foregroundColor: NSColor.white,
        .kern: -0.8
    ]
)

if let subtitle {
    (subtitle as NSString).draw(
        at: NSPoint(x: 59, y: 123),
        withAttributes: [
            .font: NSFont.systemFont(ofSize: 20, weight: .medium),
            .foregroundColor: c(0xFFFFFF, alpha: 0.88)
        ]
    )
}

let browserRect = NSRect(x: 90, y: 180, width: 1100, height: 650)
let shadow = NSShadow()
shadow.shadowColor = c(0x071630, alpha: 0.42)
shadow.shadowBlurRadius = 26
shadow.shadowOffset = NSSize(width: 0, height: 12)

NSGraphicsContext.saveGraphicsState()
shadow.set()
rounded(browserRect, radius: 14, fill: .white)
NSGraphicsContext.restoreGraphicsState()

NSBezierPath(roundedRect: browserRect, xRadius: 14, yRadius: 14).addClip()
c(0x34363B).setFill()
NSRect(x: 90, y: 180, width: 1100, height: 42).fill()

for (x, color) in [(116.0, c(0xFF776D)), (137.0, c(0xFFBD55)), (158.0, c(0x69C66D))] {
    color.setFill()
    NSBezierPath(ovalIn: NSRect(x: x - 5.5, y: 194.5, width: 11, height: 11)).fill()
}

rounded(
    NSRect(x: 282, y: 191, width: 716, height: 17),
    radius: 8.5,
    fill: c(0xFFFFFF, alpha: 0.22)
)

let contentWidth: CGFloat = 1100
let contentHeight = contentWidth * source.size.height / source.size.width
source.draw(
    in: NSRect(x: 90, y: 222, width: contentWidth, height: contentHeight),
    from: NSRect(origin: .zero, size: source.size),
    operation: .sourceOver,
    fraction: 1,
    respectFlipped: true,
    hints: [.interpolation: NSImageInterpolation.high]
)

result.unlockFocus()

// Export final Chrome Store size: high-quality 2× → 1× downsample.
guard let finalRep = NSBitmapImageRep(
    bitmapDataPlanes: nil,
    pixelsWide: outW,
    pixelsHigh: outH,
    bitsPerSample: 8,
    samplesPerPixel: 4,
    hasAlpha: true,
    isPlanar: false,
    colorSpaceName: .deviceRGB,
    bytesPerRow: 0,
    bitsPerPixel: 0
) else {
    fatalError("Unable to create final bitmap")
}
finalRep.size = NSSize(width: outW, height: outH)

guard let finalContext = NSGraphicsContext(bitmapImageRep: finalRep) else {
    fatalError("Unable to create final context")
}
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = finalContext
finalContext.imageInterpolation = .high
finalContext.cgContext.interpolationQuality = .high
result.draw(
    in: NSRect(x: 0, y: 0, width: outW, height: outH),
    from: NSRect(x: 0, y: 0, width: outW, height: outH),
    operation: .copy,
    fraction: 1,
    respectFlipped: false,
    hints: [.interpolation: NSImageInterpolation.high]
)
NSGraphicsContext.restoreGraphicsState()

guard let png = finalRep.representation(using: .png, properties: [:]) else {
    fatalError("PNG encode failed")
}
try png.write(to: URL(fileURLWithPath: outputPath))
print(outputPath)
print("pixels: \(finalRep.pixelsWide)x\(finalRep.pixelsHigh) (from \(hiRes.pixelsWide)x\(hiRes.pixelsHigh) 2× master)")
