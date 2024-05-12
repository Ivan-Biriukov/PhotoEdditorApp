import UIKit
import SnapKit

// MARK: - TextView

final class TextView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let toolBarHeight: CGFloat = 40
        static let currentImageHeight: CGFloat = SizeCalculator.deviceHeight - 300
        static let currentImageWidth: CGFloat = SizeCalculator.deviceWidth - 50
        static let currentImageTopOffset: CGFloat = 25
    }
    
    // MARK: - Properties
    
    private let toolBar = UIToolbar()
    private lazy var currentImageView: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 1
        image.layer.borderColor = AppPallete.titleTextColor.cgColor
        return image
    }()
    
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
    }
}

// MARK: - ViewModelConfigurable

extension TextView: ViewModelConfigurable {
    
    struct ViewModel {
        let currentImage: UIImage
    }
    
    func configure(with viewModel: ViewModel) {
        currentImageView.image = viewModel.currentImage
    }
}
