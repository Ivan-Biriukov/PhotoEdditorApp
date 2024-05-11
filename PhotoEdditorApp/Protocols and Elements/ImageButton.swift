// MARK: - Imports

import UIKit
import SnapKit
import AudioToolbox

// MARK: - ImageButton

final class ImageButton: UIButton {
    
    // MARK: - Properties
    
    private var action: (()->Void)?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

private extension ImageButton {
    func configure() {
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        contentMode = .scaleAspectFill
    }
}

// MARK: - Actions

private extension ImageButton {
    @objc func buttonPressed() {
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
        action?()
    }
}

// MARK: - ViewModelConfigurable

extension ImageButton: ViewModelConfigurable {
    struct ViewModel {
        let image: UIImage
        let action: (()-> Void)?
        let size: CGSize
        let cornerRadius: CGFloat
        
        init(
            image: UIImage,
            action: (() -> Void)? = nil,
            size: CGSize,
            cornerRadius: CGFloat = 0
        ) {
            self.image = image
            self.action = action
            self.size = size
            self.cornerRadius = cornerRadius
        }
    }
    
    func configure(with viewModel: ViewModel) {
        setImage(viewModel.image, for: .normal)
        self.action = viewModel.action
        self.layer.cornerRadius = viewModel.cornerRadius
        
        self.snp.makeConstraints { make in
            make.height.equalTo(viewModel.size.height)
            make.width.equalTo(viewModel.size.width)
        }
    }
}
