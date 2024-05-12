import UIKit
import SnapKit
import PencilKit

// MARK: - Constants

fileprivate enum Constants {
    static let actionBarHeight: CGFloat = 40
    static let observingNotificationName: String = "edditingImageObserver"
    static let observerImageObjectName: String = "edditingImage"
}

// MARK: - CanvasView

final class CanvasView: UIView {
    
    // MARK: - Properties
    
    private var closeAction: (() -> Void)?
    private var currentImage: UIImage?
        
    private let actionBar = UIToolbar()
    private let canvasView = PKCanvasView()
    private let toolPicker = PKToolPicker()
    
    private lazy var undoBarItem: UIBarButtonItem = .init(title: "undo", style: .plain, target: self, action: #selector(undo))
    private lazy var clearBarItem: UIBarButtonItem = .init(title: "clear", style: .plain, target: self, action: #selector(clear))
    private lazy var saveBarItem: UIBarButtonItem = .init(title: "save", style: .done, target: self, action: #selector(save))
    private lazy var closeBarItem: UIBarButtonItem = .init(title: "close", style: .done, target: nil, action: #selector(close))
    private lazy var flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    // MARK: - .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        initialConfigs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func prepareImage() {
        let resizedImage = currentImage?.imageResized(to: canvasView.frame.size)
        canvasView.backgroundColor = UIColor(patternImage: resizedImage!)
    }
}

// MARK: - Configure

private extension CanvasView {
    func addSubviews() {
        [actionBar, canvasView].forEach {
            addSubview($0)
        }
    }
    
    func makeConstraints() {
        actionBar.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(Constants.actionBarHeight)
        }
        
        canvasView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(actionBar.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    func initialConfigs() {
        canvasView.delegate = self
        canvasView.drawingPolicy = .anyInput
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        actionBar.setItems([undoBarItem, clearBarItem, flexibleSpace, saveBarItem, closeBarItem], animated: true)
    }
}

// MARK: - Actions

private extension CanvasView {
    @objc func undo() {
        canvasView.undoManager?.undo()
    }
    
    @objc func clear() {
        canvasView.drawing = PKDrawing()
    }
    
    @objc func save() {
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
        
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if newImage != nil {
            NotificationCenter.default.post(
                name: NSNotification.Name(Constants.observingNotificationName),
                object: [Constants.observerImageObjectName : newImage]
            )
        }
    }
    
    @objc func close() {
       closeAction?()
    }
}

// MARK: - ViewModelConfigurable

extension CanvasView: ViewModelConfigurable {
    struct ViewModel {
        let edditingImage: UIImage?
        let closeAction: (() -> Void)?
        
        init(
            edditingImage: UIImage? = nil,
            closeAction: ( () -> Void)? = nil
        ) {
            self.edditingImage = edditingImage
            self.closeAction = closeAction
        }
    }
    
    func configure(with viewModel: ViewModel) {
        currentImage = viewModel.edditingImage
        if let edditingImage = viewModel.edditingImage {
            let resizedImage = edditingImage.imageResized(to: CGSize(width: SizeCalculator.deviceWidth, height: SizeCalculator.deviceHeight - 200))
            canvasView.backgroundColor = UIColor(patternImage: resizedImage)
        }
        closeAction = viewModel.closeAction
    }
}

// MARK: - PKCanvasViewDelegate

extension CanvasView: PKCanvasViewDelegate {}
