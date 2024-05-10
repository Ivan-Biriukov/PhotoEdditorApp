// MARK: - Imports

import UIKit
import SnapKit

// MARK: - TextView

/// Class used for all Labels
 final class ViewWithText: UIView {
    
    // MARK: - Style
    
    enum Style {
        case regular(size: CGFloat), italic(size: CGFloat), bold(size: CGFloat)
        
        var font: UIFont {
            switch self {
            case .regular(size: let size):
                return UIFont.systemFont(ofSize: size)
            case .italic(size: let size):
                return UIFont.italicSystemFont(ofSize: size)
            case.bold(size: let size):
                return UIFont.boldSystemFont(ofSize: size)
            }
        }
    }
    
    // MARK: - Properties
    
    private let label = UILabel()
    
    private var style: Style = .regular(size: 14) {
        didSet {
            updateStyle()
        }
    }
    
    private var isShadowed: Bool = true {
        didSet {
            updateShadow()
        }
    }
    
    private var isMultiline: Bool = true {
        didSet {
            updateLines()
        }
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        placeLabel(with: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -  Methods
    
     func updateText(text: String) {
        self.label.text = text
    }
}

// MARK: - ViewModelConfigurable

extension ViewWithText: ViewModelConfigurable {
    
    func configure(with viewModel: ViewModel) {
       self.label.text = viewModel.text
       self.style = viewModel.style
       self.label.textColor = viewModel.textColor
       self.label.backgroundColor = viewModel.backgroundColor
       self.isShadowed = viewModel.isShadowed
       self.isMultiline = viewModel.isMultiline
       self.label.textAlignment = viewModel.aligment
       placeLabel(with: viewModel.insets)
   }
}

// MARK: - Private methods

private extension ViewWithText {
    
    // MARK: Constants
    
    enum Constants {
        enum Size {
            static let fontSize12: CGFloat = 12
            static let fontSize14: CGFloat = 14
            static let fontSize16: CGFloat = 16
            static let fontSize32: CGFloat = 32
        }
        
        enum Shadow {
            static let shadowOpacity: Float = 0.8
            static let shadowOffset: CGSize = CGSize(width: 2, height: 2)
            static let shadowRadius: CGFloat = 3
            static let noShadowColor: CGColor? = nil
            static let noShadowOpacity: Float = 0.0
            static let noShadowOffset: CGSize = CGSize.zero
            static let noShadowRadius: CGFloat = 0.0
        }
    }
    
    // MARK: Methods
    
    func updateStyle() {
        switch style {
        case .regular(let size):
            self.label.font = UIFont.systemFont(ofSize: size)
        case .italic(let size):
            self.label.font = UIFont.italicSystemFont(ofSize: size)
        case .bold(let size):
            self.label.font = UIFont.boldSystemFont(ofSize: size)
        }
    }

    func updateLines() {
        if isMultiline {
            self.label.numberOfLines = 0
        } else {
            self.label.numberOfLines = 1
        }
    }
    
    func updateShadow() {
        if isShadowed {
            addShadow()
        } else {
            removeShadow()
        }
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = Constants.Shadow.shadowOpacity
        self.layer.shadowOffset = Constants.Shadow.shadowOffset
        self.layer.shadowRadius = Constants.Shadow.shadowRadius
    }
    
    func removeShadow() {
        self.layer.shadowColor = Constants.Shadow.noShadowColor
        self.layer.shadowOpacity = Constants.Shadow.noShadowOpacity
        self.layer.shadowOffset = Constants.Shadow.noShadowOffset
        self.layer.shadowRadius = Constants.Shadow.noShadowRadius
    }

    func placeLabel(with insets: UIEdgeInsets) {
        self.addSubview(label)
        label.snp.makeConstraints() {
            $0.edges.equalToSuperview().inset(insets)
        }
    }
}
