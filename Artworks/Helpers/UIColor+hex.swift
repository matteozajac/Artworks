import UIKit

extension UIColor {
    public convenience init(hex: String) {
        let red, green, blue: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
                    blue = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255

                    self.init(red: red, green: green, blue: blue, alpha: 1)
                    return
                }
            }
        }
        self.init(red: 1, green: 1, blue: 1, alpha: 1)
        return
    }

    var hex: String {
        let components = cgColor.components
        let red: CGFloat = components?[0] ?? 0.0
        let green: CGFloat = components?[1] ?? 0.0
        let blue: CGFloat = components?[2] ?? 0.0

        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(red * 255)), lroundf(Float(green * 255)), lroundf(Float(blue * 255)))
        return hexString
    }
}
