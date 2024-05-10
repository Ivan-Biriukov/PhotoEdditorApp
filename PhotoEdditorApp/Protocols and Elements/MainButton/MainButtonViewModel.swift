// MARK: - Imports

import UIKit

// MARK: - Extension ViewModelConfigurable

extension MainButton: ViewModelConfigurable {
    public struct ViewModel {
        let title: String
        let attributedTitle: NSAttributedString?
        let backgroundColor: UIColor
        let textColorEnable: UIColor
        let textColorDisable: UIColor
        let textColorHighlighted: UIColor
        let font: UIFont?
        let insets: UIEdgeInsets
        let cornerRadius: CGFloat
        let height: CGFloat
        let width: CGFloat?
        var action: (()->Void)?
        
        public init(
            title: String = .empty,
            attributedTitle: NSAttributedString? = nil,
            backgroundColor: UIColor = .clear,
            textColorEnable: UIColor = .white,
            textColorDisable: UIColor = .systemBlue,
            textColorHighlighted: UIColor = .systemBlue,
            font: UIFont? = nil,
            insets: UIEdgeInsets = .zero,
            cornerRadius: CGFloat = 0,
            height: CGFloat = 0,
            width: CGFloat? = nil,
            action: (()->Void)? = nil
        ) {
            self.title = title
            self.attributedTitle = attributedTitle
            self.backgroundColor = backgroundColor
            self.textColorEnable = textColorEnable
            self.textColorDisable = textColorDisable
            self.textColorHighlighted = textColorHighlighted
            self.font = font
            self.insets = insets
            self.cornerRadius = cornerRadius
            self.height = height
            self.width = width
            self.action = action
        }
    }
}
