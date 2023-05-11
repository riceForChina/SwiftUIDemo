#if os(macOS)
import AppKit
#else
import UIKit
#endif

private extension Int {
    func duplicate4bits() -> Int {
        return (self << 4) + self
    }
}

extension UIColor {
    
    public convenience init(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    private convenience init(hex3: Int, alpha: Float) {
        self.init(red:   CGFloat( ((hex3 & 0xF00) >> 8).duplicate4bits() ) / 255.0,
                  green: CGFloat( ((hex3 & 0x0F0) >> 4).duplicate4bits() ) / 255.0,
                  blue:  CGFloat( ((hex3 & 0x00F) >> 0).duplicate4bits() ) / 255.0,
                  alpha: CGFloat(alpha))
    }
    
    private convenience init(hex6: Int, alpha: Float) {
        self.init(red:   CGFloat( (hex6 & 0xFF0000) >> 16 ) / 255.0,
                  green: CGFloat( (hex6 & 0x00FF00) >> 8 ) / 255.0,
                  blue:  CGFloat( (hex6 & 0x0000FF) >> 0 ) / 255.0, alpha: CGFloat(alpha))
    }
    
    convenience public init(hexString: String, alpha: Float) {
        var hex = hexString
        
        // Check for hash and remove the hash
        if hex.hasPrefix("#") {
            hex = String(hex[hex.index(after: hex.startIndex)...])
        }
        
        guard let hexVal = Int(hex, radix: 16) else {
            self.init()
            fatalError("error")
        }
        
        switch hex.count {
        case 3:
            self.init(hex3: hexVal, alpha: alpha)
        case 6:
            self.init(hex6: hexVal, alpha: alpha)
        default:
            // Note:
            // The swift 1.1 compiler is currently unable to destroy partially initialized classes in all cases,
            // so it disallows formation of a situation where it would have to.  We consider this a bug to be fixed
            // in future releases, not a feature. -- Apple Forum
            self.init()
        }
    }
    
    convenience public init(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    convenience public init(hex: Int, alpha: Float) {
        if (0x000000 ... 0xFFFFFF) ~= hex {
            self.init(hex6: hex, alpha: alpha)
        } else {
            self.init()
        }
    }
}

public extension UIColor {
    
    static func interpolate(from fromColor: UIColor, to toColor: UIColor, with progress: CGFloat) -> UIColor {
        let fromComponents = fromColor.components
        let toComponents = toColor.components
        let r = (1 - progress) * fromComponents.r + progress * toComponents.r
        let g = (1 - progress) * fromComponents.g + progress * toComponents.g
        let b = (1 - progress) * fromComponents.b + progress * toComponents.b
        let a = (1 - progress) * fromComponents.a + progress * toComponents.a
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

public extension UIColor {
    
    var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let components = self.cgColor.components!
        switch components.count == 2 {
        case true : return (r: components[0], g: components[0], b: components[0], a: components[1])
        case false: return (r: components[0], g: components[1], b: components[2], a: components[3])
        }
    }
    
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    
    var hex: UInt {
        let red = UInt(coreImageColor.red * 255 + 0.5)
        let green = UInt(coreImageColor.green * 255 + 0.5)
        let blue = UInt(coreImageColor.blue * 255 + 0.5)
        return (red << 16) | (green << 8) | blue
    }
    
    var hexString: String {

        let r: CGFloat = components.r
        let g: CGFloat = components.g
        let b: CGFloat = components.b
        let a: CGFloat = components.a

        /* Alternatively, the color can be specified as a RGB hex triplet in the form #RRGGBB, where each 2-digit group expresses a color value in the range 0 (00) to 255 (FF). For example, #FF0000 is red. This is similar to web colors. Alpha is given with #AARRGGBB.
         */
        let hexString = String(format: "#%02lX%02lX%02lX%02lX", lroundf(Float(a * 255)), lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}

extension UIColor {
    
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? dark: light
        }
    }
    
}
