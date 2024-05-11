// MARK: - Imports

import UIKit
import SnapKit
import PencilKit
import PhotosUI

fileprivate enum Constants {
    static let actionBarHeight: CGFloat = 40
}

// MARK: - CanvasView

final class CanvasView: UIView {
    
    // MARK: - Properties
        
    private let actionBar = UIToolbar()
    private let canvasView = PKCanvasView()
    private let toolPicker = PKToolPicker()
    
    private lazy var undoBarItem: UIBarButtonItem = .init(title: "undo", style: .plain, target: self, action: #selector(undo))
    private lazy var clearBarItem: UIBarButtonItem = .init(title: "clear", style: .plain, target: self, action: #selector(clear))
    private lazy var saveBarItem: UIBarButtonItem = .init(title: "save", style: .done, target: self, action: #selector(save))
    private lazy var closeBarItem: UIBarButtonItem = .init(title: "close", style: .done, target: nil, action: nil)
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
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: newImage!)
            }
        }
    }
}

// MARK: - ViewModelConfigurable

extension CanvasView: ViewModelConfigurable {
    struct ViewModel {
        let edditingImage: UIImage?
    }
    
    func configure(with viewModel: ViewModel) {
        if let edditingImage = viewModel.edditingImage {
            let resizedImage = edditingImage.imageResized(to: CGSize(width: SizeCalculator.deviceWidth, height: SizeCalculator.deviceHeight - 200))
            canvasView.backgroundColor = UIColor(patternImage: resizedImage)
        }
    }
}

// MARK: - PKCanvasViewDelegate

extension CanvasView: PKCanvasViewDelegate {
    
}
