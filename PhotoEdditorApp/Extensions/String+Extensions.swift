import UIKit

public extension String {
    static var empty: String {
        return ""
    }
    
    func width(withFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return ceil(size.width) + 20
    }
}
