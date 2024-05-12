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
    
    func height(withFont font: UIFont, width: CGFloat) -> CGFloat {
        let constraintSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let boundingBox = self.boundingRect(with: constraintSize,
                                            options: .usesLineFragmentOrigin,
                                            attributes: fontAttributes,
                                            context: nil)
        return ceil(boundingBox.height) + 20
    }

}
