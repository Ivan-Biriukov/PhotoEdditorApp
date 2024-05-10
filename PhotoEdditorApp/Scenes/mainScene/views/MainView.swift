// MARK: - Imports

import UIKit
import SnapKit

// MARK: - MainView

final class MainView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let titleLabelTopInsets: CGFloat = 100
        static let buttonsTopOffset: CGFloat = 40
        static let buttonsSidesInsets: CGFloat = 25
        static let photoImageViewTopOffset: CGFloat = 25
        static let bottomButtonStackTopOffset: CGFloat = 15
        static let bottomButtonStackSpacing: CGFloat = 15
    }
    
    // MARK: - Properties
    
    private lazy var titleLabel = ViewWithText()
    private lazy var selectLibraryPhotoButton = MainButton()
    private lazy var takeCameraPhotoButton = MainButton()
    private lazy var photoImageView = UIImageView()
    private lazy var editButton = MainButton()
    private lazy var removeButton = MainButton()
    private lazy var saveButton = MainButton()
    
    private lazy var bottomButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [removeButton, saveButton, editButton])
        stack.spacing = Constants.bottomButtonStackSpacing
        return stack
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        initialConfigure()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func updateImagePhoto(with photo: UIImage) {
        photoImageView.image = photo
    }
    
    func removeSelectedPhoto() {
        photoImageView.image = AppImages.photoPlaceholder
    }
}

// MARK: - Configure

private extension MainView {
    
    func initialConfigure() {
        backgroundColor = AppPallete.mainBG
    }
        
    func addSubviews() {
        [titleLabel,
         selectLibraryPhotoButton,
         takeCameraPhotoButton,
         photoImageView,
         bottomButtonStack].forEach {
            self.addSubview($0)
        }
    }
        
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.titleLabelTopInsets)
            make.centerX.equalToSuperview()
        }
        
        selectLibraryPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.buttonsTopOffset)
            make.leading.equalToSuperview().inset(Constants.buttonsSidesInsets)
        }
        
        takeCameraPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.buttonsTopOffset)
            make.trailing.equalToSuperview().inset(Constants.buttonsSidesInsets)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(selectLibraryPhotoButton.snp.bottom).offset(Constants.photoImageViewTopOffset)
        }
        
        bottomButtonStack.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(Constants.bottomButtonStackTopOffset)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - ViewModelConfigurable

extension MainView: ViewModelConfigurable {
    struct ViewModel {
        let titleLabel: ViewWithText.ViewModel
        let libraryPhotoButton: MainButton.ViewModel
        let cameraPhotoButton: MainButton.ViewModel
        let photoImage: PhotoImageViewModel
        let editButton: MainButton.ViewModel
        let removeButton: MainButton.ViewModel
        let saveButton: MainButton.ViewModel
    }
    
    struct PhotoImageViewModel {
        let image: UIImage
        let borderColor: CGColor
        let borderWidth: CGFloat
        let height: CGFloat
        let width: CGFloat
    }
    
    func configure(with viewModel: ViewModel) {
        titleLabel.configure(with: viewModel.titleLabel)
        selectLibraryPhotoButton.configure(with: viewModel.libraryPhotoButton)
        takeCameraPhotoButton.configure(with: viewModel.cameraPhotoButton)
        
        selectLibraryPhotoButton.snp.makeConstraints { make in
            make.height.equalTo(viewModel.libraryPhotoButton.height)
            make.width.equalTo(viewModel.libraryPhotoButton.title.width(withFont: viewModel.libraryPhotoButton.font!))
        }
        
        takeCameraPhotoButton.snp.makeConstraints { make in
            make.height.equalTo(viewModel.cameraPhotoButton.height)
            make.width.equalTo(viewModel.cameraPhotoButton.title.width(withFont: viewModel.cameraPhotoButton.font!))
        }
        
        photoImageView.image = viewModel.photoImage.image
        photoImageView.layer.borderWidth = viewModel.photoImage.borderWidth
        photoImageView.layer.borderColor = viewModel.photoImage.borderColor
        photoImageView.snp.makeConstraints { make in
            make.height.equalTo(viewModel.photoImage.height)
            make.width.equalTo(viewModel.photoImage.width)
        }
        
        editButton.configure(with: viewModel.editButton)
        editButton.snp.makeConstraints { make in
            make.height.equalTo(viewModel.editButton.height)
            make.width.equalTo(viewModel.editButton.title.width(withFont: viewModel.editButton.font!))
        }
        
        saveButton.configure(with: viewModel.saveButton)
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(viewModel.saveButton.height)
            make.width.equalTo(viewModel.saveButton.title.width(withFont: viewModel.saveButton.font!))
        }
        
        removeButton.configure(with: viewModel.removeButton)
        removeButton.snp.makeConstraints { make in
            make.height.equalTo(viewModel.removeButton.height)
            make.width.equalTo(viewModel.removeButton.title.width(withFont: viewModel.removeButton.font!))
        }
    }
}
