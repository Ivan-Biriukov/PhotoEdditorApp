import Foundation

// MARK: - Imports

import Foundation

// MARK: - PresentsMainScene

protocol PresentsMainViewProtocol {
    func presentScreenInitialData()
}

// MARK: - MainViewPresenter

final class MainViewPresenter {
    
    // MARK: - Properties
    
    weak var viewController: DisplayMainViewController?
    
    // MARK: - Init
    
    init(viewController: DisplayMainViewController? = nil) {
        self.viewController = viewController
    }
}

// MARK: - PresentsAuthentificationInfo

extension MainViewPresenter: PresentsMainViewProtocol {
    func presentScreenInitialData() {
        viewController?.displayInitialData(with:
                .init(
                    titleLabel: .init(
                        style: .bold(size: 30),
                        text: "Ваш фото редактор",
                        textColor: AppPallete.titleTextColor,
                        isShadowed: true
                    ),
                    libraryPhotoButton: .init(
                        title: "Выбрать из галереи",
                        backgroundColor: AppPallete.buttonBg,
                        textColorEnable: .white,
                        font: AppFonts.medium15,
                        cornerRadius: 12,
                        height: 30,
                        action: viewController?.presentMediaLibraryPicker
                    ),
                    cameraPhotoButton: .init(
                        title: "Сделать фото",
                        backgroundColor: AppPallete.buttonBg,
                        textColorEnable: .white,
                        font: AppFonts.medium15,
                        cornerRadius: 12,
                        height: 30,
                        action: viewController?.presentCameraPhoto
                    ),
                    photoImage: .init(
                        image: AppImages.photoPlaceholder!,
                        borderColor: AppPallete.titleTextColor.cgColor,
                        borderWidth: 1,
                        height: SizeCalculator.deviceHeight / 2,
                        width: SizeCalculator.deviceWidth - 60
                    ),
                    editButton: .init(
                        title: "Редактировать",
                        backgroundColor: AppPallete.buttonBg,
                        textColorEnable: .white,
                        font: AppFonts.medium15,
                        cornerRadius: 12,
                        height: 30,
                        action: {}
                    ),
                    removeButton: .init(
                        title: "Удалить",
                        backgroundColor: AppPallete.buttonBg,
                        textColorEnable: .red,
                        font: AppFonts.medium15,
                        cornerRadius: 12,
                        height: 30,
                        action: viewController?.cleanPhotoImage
                    ),
                    saveButton: .init(
                        title: "Сохранить",
                        backgroundColor: AppPallete.buttonBg,
                        textColorEnable: .white,
                        font: AppFonts.medium15,
                        cornerRadius: 12,
                        height: 30,
                        action: {}
                    )
                )
        )
    }
}
