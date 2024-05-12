import UIKit
import SnapKit

// MARK: - TextView

final class TextView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let toolBarHeight: CGFloat = 40
        static let currentImageHeight: CGFloat = SizeCalculator.deviceHeight - 200
        static let currentImageWidth: CGFloat = SizeCalculator.deviceWidth - 20
        static let currentImageTopOffset: CGFloat = 25
        static let textViewStartFont: UIFont = AppFonts.getFont(ofsize: 25, weight: .bold)
        static let observingNotificationName: String = "edditingImageObserver"
        static let observerImageObjectName: String = "edditingImage"
    }
    
    // MARK: - Properties
    
    private var textViewStartFrameSize: CGSize = .init(width: 0, height: 0)
    
    private var closeAction: (() -> Void)?
    private var showColorPickerAction: (() -> Void)?
    private var scaledFontSize: CGFloat = 0
    
    private let pinchGesture = UIPinchGestureRecognizer()
    private let panGesture = UIPanGestureRecognizer()
    
    private let toolBar = UIToolbar()
    private lazy var addText: UIBarButtonItem = .init(title: "Add text", style: .plain, target: self, action: #selector(addTextTaped))
    private let space: UIBarButtonItem = .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private lazy var chooseTextColor: UIBarButtonItem = .init(title: "Color", style: .plain, target: self, action: #selector(chooseColorTaped))
    private lazy var cancelChanges: UIBarButtonItem = .init(title: "Cancel", style: .plain, target: self, action: #selector(cancelChangesTaped))
    private lazy var saveChanges: UIBarButtonItem = .init(title: "Save", style: .done, target: self, action: #selector(saveTaped))
    private lazy var close: UIBarButtonItem = .init(image: UIImage(systemName: "xmark.circle"), style: .done, target: self, action: #selector(closeButtonTaped))
    
    private lazy var currentImageView: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 1
        image.layer.borderColor = AppPallete.titleTextColor.cgColor
        return image
    }()
    
    private var startImage = UIImage()
    private lazy var textView =  UITextView()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        initialConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func changeTextColor(with newColor: UIColor) {
        textView.textColor = newColor
    }
    
    private func calculateProportionalFontSize(baseFontSize: CGFloat, baseSize: CGSize, newSize: CGSize) -> CGFloat {
        let baseWidth = baseSize.width
        let baseHeight = baseSize.height
        let newWidth = newSize.width
        let newHeight = newSize.height
        let widthRatio = newWidth / baseWidth
        let heightRatio = newHeight / baseHeight
        let scaleFactor = min(widthRatio, heightRatio)
        return baseFontSize * scaleFactor
    }
}

// MARK: - Configure

private extension TextView {
    func addSubviews() {
        [toolBar, currentImageView].forEach {
            self.addSubview($0)
        }
    }
        
    func setupConstraints() {
        toolBar.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(Constants.toolBarHeight)
        }
        
        currentImageView.snp.makeConstraints { make in
            make.width.equalTo(Constants.currentImageWidth)
            make.height.equalTo(Constants.currentImageHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(toolBar.snp.bottom).offset(Constants.currentImageTopOffset)
        }
    }
    
    func initialConfigure() {
        backgroundColor = AppPallete.filtersBG
        toolBar.items = [addText, chooseTextColor, cancelChanges, space, saveChanges,close]
        close.tintColor = .red
        textView.backgroundColor = .clear
        textView.delegate = self
        pinchGesture.addTarget(self, action: #selector(handlePinchGesture(_:)))
        currentImageView.addGestureRecognizer(pinchGesture)
        currentImageView.isUserInteractionEnabled = true
        currentImageView.addGestureRecognizer(panGesture)
        panGesture.addTarget(self, action: #selector(handlePanGesture(_:)))
        [pinchGesture, panGesture].forEach {
            $0.delegate = self
        }
    }
}

// MARK: - Actions

private extension TextView {
    @objc func addTextTaped() {
        currentImageView.addSubview(textView)
        textView.center = currentImageView.center
        textView.font = Constants.textViewStartFont
        textView.textColor = .white
        textView.text = "Введите текст"
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 1
        
        let textWidth = textView.text.width(withFont: Constants.textViewStartFont)
        let textHeight = textView.text.height(withFont: Constants.textViewStartFont, width: textWidth)
        
        textView.frame.size = CGSize(width: textWidth, height: textHeight)
        textView.becomeFirstResponder()
        textViewStartFrameSize = CGSize(width: textWidth, height: textHeight)
    }
    
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard gesture.view != nil else { return }

        if gesture.state == .changed {
            let scale = gesture.scale
            textView.transform = textView.transform.scaledBy(x: scale, y: scale)
            scaledFontSize = calculateProportionalFontSize(baseFontSize: 25, baseSize: textViewStartFrameSize, newSize: textView.frame.size)
            gesture.scale = 1.0
        }
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        switch gesture.state {
        case .changed:
            let newX = textView.frame.origin.x + translation.x
            let newY = textView.frame.origin.y + translation.y
            textView.frame.origin = CGPoint(x: newX, y: newY)
            gesture.setTranslation(.zero, in: self)
        default:
            break
        }
    }

    @objc func saveTaped() {
        let image = currentImageView.image
        
        UIGraphicsBeginImageContextWithOptions(currentImageView.frame.size, false, 0.0)
        image?.draw(in: CGRect(x: 0, y: 0, width: currentImageView.frame.size.width, height: currentImageView.frame.size.height))
        
        let scale = currentImageView.contentScaleFactor
        let textOrigin = CGPoint(x: textView.frame.origin.x * scale, y: textView.frame.origin.y * scale)
        let textRect = CGRect(x: textOrigin.x, y: textOrigin.y, width: textView.frame.size.width * scale, height: textView.frame.size.height * scale)
        
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: textView.textColor!,
            NSAttributedString.Key.font: AppFonts.getFont(ofsize: scaledFontSize, weight: .bold)
        ]
        
        textView.text.draw(in: textRect, withAttributes: textAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if newImage != nil {
            NotificationCenter.default.post(
                name: NSNotification.Name(Constants.observingNotificationName),
                object: [Constants.observerImageObjectName : newImage!]
            )
        }
        closeAction?()
    }

    
    @objc func closeButtonTaped() {
        closeAction?()
    }
    
    @objc func cancelChangesTaped() {
        textView.removeFromSuperview()
    }
    
    @objc func chooseColorTaped() {
        showColorPickerAction?()
    }
}

// MARK: - UITextViewDelegate

extension TextView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.clear.cgColor
        textView.layer.borderWidth = 0
    }
}

// MARK: - UIGestureRecognizerDelegate

extension TextView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - ViewModelConfigurable

extension TextView: ViewModelConfigurable {
    struct ViewModel {
        let currentImage: UIImage
        let closeAction: (() -> Void)?
        let showColorPickerAction: (() -> Void)?
        
        init(
            currentImage: UIImage,
            closeAction: (() -> Void)? = nil,
            showColorPickerAction: (() -> Void)? = nil
        ) {
            self.currentImage = currentImage
            self.closeAction = closeAction
            self.showColorPickerAction = showColorPickerAction
        }
    }
    
    func configure(with viewModel: ViewModel) {
        currentImageView.image = viewModel.currentImage
        closeAction = viewModel.closeAction
        startImage = viewModel.currentImage
        showColorPickerAction = viewModel.showColorPickerAction
    }
}
