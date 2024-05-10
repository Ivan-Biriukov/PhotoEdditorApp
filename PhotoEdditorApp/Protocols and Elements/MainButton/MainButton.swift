// MARK: - Imports

import UIKit
import SnapKit
import AudioToolbox


// MARK: - MainButton

final class MainButton: UIControl {

    // MARK: - Private properties
    
    private var viewModel: ViewModel
    
    override var isEnabled: Bool {
        didSet {
            updateColor()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateColor()
        }
    }
    
    private var action: (()->Void)?
        
    //MARK: - UI
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let nameButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initialization
    
    required init(viewModel: ViewModel = ViewModel(title: .empty)) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        initialSetup()
        isEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        stackView.point(inside: point, with: event) ? self : nil
    }
    
    
    //MARK: Configure
    
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        stackView.layer.cornerRadius = viewModel.cornerRadius
        self.action = viewModel.action
        
        if let attributedTitle = viewModel.attributedTitle {
            nameButtonLabel.attributedText = attributedTitle
        } else {
            nameButtonLabel.text = viewModel.title
        }
        
        if let font = viewModel.font {
            nameButtonLabel.font = font
        }
        
        stackView.backgroundColor = viewModel.backgroundColor
        updateColor()
        setupConstraints(height: viewModel.height, width: viewModel.width)
    }
}

//MARK: - private methods

private extension MainButton {
    func initialSetup() {
        updateColor()
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func setupConstraints(height: CGFloat, width: CGFloat?) {
        addSubview(stackView)
        stackView.addArrangedSubview(nameButtonLabel)
        stackView.snp.makeConstraints { make in
            make.height.equalTo(height)
            if let safeWidth = width {
                make.width.equalTo(safeWidth)
            }
            make.edges.equalToSuperview()
        }
    }
    
    func updateColor() {
        guard isEnabled else {
            nameButtonLabel.textColor = viewModel.textColorDisable
            return
        }
        if isHighlighted {
            nameButtonLabel.textColor = viewModel.textColorHighlighted
        } else {
            nameButtonLabel.textColor = viewModel.textColorEnable
        }
        nameButtonLabel.textColor = viewModel.textColorEnable
    }
    
    // MARK: Actions
    
    @objc func buttonPressed() {
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
        action?()
    }
}
