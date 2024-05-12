import UIKit

extension ViewWithText {
    
    struct ViewModel {
       let style: Style
       let text: String
       let textColor: UIColor
       let backgroundColor: UIColor
       let isShadowed: Bool
       let isMultiline: Bool
       let insets: UIEdgeInsets
       let aligment: NSTextAlignment
       
       init(
           style: Style,
           text: String,
           textColor: UIColor,
           backgroundColor: UIColor = .clear,
           isShadowed: Bool,
           isMultiline: Bool = true,
           insets: UIEdgeInsets = .zero,
           aligment: NSTextAlignment = .center
       ) {
           self.style = style
           self.text = text
           self.textColor = textColor
           self.isShadowed = isShadowed
           self.backgroundColor = backgroundColor
           self.isMultiline = isMultiline
           self.insets = insets
           self.aligment = aligment
       }
   }
}
