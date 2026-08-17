import AppKit
import Foundation

guard CommandLine.arguments.count >= 7,
      (CommandLine.arguments.count - 3) % 2 == 0 else {
    fputs("Usage: make_xhs_contact_sheet <output.png> <title> <label> <image> [<label> <image> ...]\n", stderr)
    exit(2)
}

let outputURL = URL(fileURLWithPath: CommandLine.arguments[1])
guard !FileManager.default.fileExists(atPath: outputURL.path) else {
    fputs("Refusing to overwrite: \(outputURL.path)\n", stderr)
    exit(3)
}

let title = CommandLine.arguments[2]
let itemArgs = Array(CommandLine.arguments.dropFirst(3))
let items = stride(from: 0, to: itemArgs.count, by: 2).map {
    (label: itemArgs[$0], path: itemArgs[$0 + 1])
}

let columns = 4
let rows = Int(ceil(Double(items.count) / Double(columns)))
let thumbWidth = 246
let thumbHeight = 328
let labelHeight = 38
let gap = 16
let outer = 20
let titleBand = 72
let width = outer * 2 + columns * thumbWidth + (columns - 1) * gap
let height = outer * 2 + titleBand + rows * (thumbHeight + labelHeight) + (rows - 1) * gap

guard let canvas = NSBitmapImageRep(
    bitmapDataPlanes: nil,
    pixelsWide: width,
    pixelsHigh: height,
    bitsPerSample: 8,
    samplesPerPixel: 4,
    hasAlpha: true,
    isPlanar: false,
    colorSpaceName: .deviceRGB,
    bitmapFormat: [],
    bytesPerRow: 0,
    bitsPerPixel: 0
) else { exit(4) }

NSGraphicsContext.saveGraphicsState()
guard let context = NSGraphicsContext(bitmapImageRep: canvas) else { exit(5) }
NSGraphicsContext.current = context
context.imageInterpolation = .high

NSColor(calibratedWhite: 0.075, alpha: 1).setFill()
NSBezierPath(rect: NSRect(x: 0, y: 0, width: width, height: height)).fill()

let titleFont = NSFont(name: "PingFangSC-Semibold", size: 30)
    ?? NSFont.systemFont(ofSize: 30, weight: .semibold)
NSAttributedString(
    string: title,
    attributes: [.font: titleFont, .foregroundColor: NSColor.white]
).draw(in: NSRect(x: outer, y: height - outer - 42, width: width - outer * 2, height: 42))

let labelFont = NSFont(name: "PingFangSC-Medium", size: 18)
    ?? NSFont.systemFont(ofSize: 18, weight: .medium)
let labelStyle = NSMutableParagraphStyle()
labelStyle.alignment = .center

for (index, item) in items.enumerated() {
    let column = index % columns
    let row = index / columns
    let x = outer + column * (thumbWidth + gap)
    let blockTop = height - outer - titleBand - row * (thumbHeight + labelHeight + gap)
    let imageY = blockTop - thumbHeight
    let labelY = imageY - labelHeight

    NSColor(calibratedWhite: 0.13, alpha: 1).setFill()
    NSBezierPath(
        roundedRect: NSRect(x: x, y: labelY, width: thumbWidth, height: thumbHeight + labelHeight),
        xRadius: 10,
        yRadius: 10
    ).fill()

    guard let image = NSImage(contentsOfFile: item.path) else {
        fputs("Could not open: \(item.path)\n", stderr)
        exit(6)
    }
    image.draw(
        in: NSRect(x: x, y: imageY, width: thumbWidth, height: thumbHeight),
        from: NSRect(origin: .zero, size: image.size),
        operation: .copy,
        fraction: 1
    )

    NSAttributedString(
        string: item.label,
        attributes: [
            .font: labelFont,
            .foregroundColor: NSColor(calibratedWhite: 0.94, alpha: 1),
            .paragraphStyle: labelStyle
        ]
    ).draw(in: NSRect(x: x + 6, y: labelY + 7, width: thumbWidth - 12, height: 24))
}

context.flushGraphics()
NSGraphicsContext.restoreGraphicsState()

guard let pngData = canvas.representation(using: .png, properties: [:]) else { exit(7) }
try pngData.write(to: outputURL, options: .atomic)
