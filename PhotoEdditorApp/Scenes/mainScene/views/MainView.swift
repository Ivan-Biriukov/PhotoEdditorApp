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
        static let stacksTopOffset: CGFloat = 15
        static let stacksHorizontalInsets: CGFloat = 25
    }
    
    // MARK: - Properties
    
    var isEnableToEddit: Bool {
        return (photoImageView.image == AppImages.photoPlaceholder) ? false : true
    }
    
    private lazy var titleLabel = ViewWithText()
    private lazy var selectLibraryPhotoButton = MainButton()
    private lazy var takeCameraPhotoButton = MainButton()
    private lazy var photoImageView = UIImageView()
    private lazy var drawButton = MainButton()
    private lazy var removeButton = MainButton()
    private lazy var saveButton = MainButton()
    private lazy var addFilterButton = MainButton()
    private lazy var addTextButton = MainButton()
    
    private lazy var edditingActionsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [drawButton, addFilterButton, addTextButton])
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var totalActionsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [removeButton, saveButton])
        stack.distribution = .equalSpacing
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
    
    func returnCurrentImage() -> UIImage? {
        return photoImageView.image
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
         edditingActionsStack,
         totalActionsStack].forEach {
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
        
        edditingActionsStack.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(Constants.stacksTopOffset)
            make.directionalHorizontalEdges.equalToSuperview().inset(Constants.stacksHorizontalInsets)
        }
        
        totalActionsStack.snp.makeConstraints { make in
            make.top.equalTo(edditingActionsStack.snp.bottom).offset(Constants.stacksTopOffset)
            make.directionalHorizontalEdges.equalToSuperview().inset(Constants.stacksHorizontalInsets)
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
        let addFilterButton: MainButton.ViewModel
        let addTextButton: MainButton.ViewModel
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
        
        drawButton.configure(with: viewModel.editButton)
        drawButton.snp.makeConstraints { make in
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
        
        addFilterButton.configure(with: viewModel.addFilterButton)
        addFilterButton.snp.makeConstraints { make in
            make.height.equalTo(viewModel.addFilterButton.height)
            make.width.equalTo(viewModel.addFilterButton.title.width(withFont: viewModel.addFilterButton.font!))
        }
        
        addTextButton.configure(with: viewModel.addTextButton)
        addTextButton.snp.makeConstraints { make in
            make.height.equalTo(viewModel.addTextButton.height)
            make.width.equalTo(viewModel.addTextButton.title.width(withFont: viewModel.addTextButton.font!))
        }
    }
}
