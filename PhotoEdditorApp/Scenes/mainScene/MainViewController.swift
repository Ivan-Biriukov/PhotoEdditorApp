import UIKit
import SnapKit
import PencilKit

// MARK: - DisplayMainViewController

protocol DisplayMainViewController: AnyObject {
    func displayInitialData(with viewModel: MainView.ViewModel)
    func presentMediaLibraryPicker()
    func presentCameraPhoto()
    func presentCanvasView()
    func presentFiltersView()
    func cleanPhotoImage()
    func shareImage()
}

// MARK: - MainViewController

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = MainView()
    private let interactor: MainBusinessLogic
    
    private var imagePicker = UIImagePickerController()

    
    // MARK: - .init()
    
    init(interactor: MainBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        contentView.removeImageObserver()
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePicker()
        interactor.showInitialData()
    }
}

// MARK: - Configure

private extension MainViewController {
    func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
}

// MARK: - DisplayMainViewController

extension MainViewController: DisplayMainViewController {
    func displayInitialData(with viewModel: MainView.ViewModel) {
        contentView.configure(with: viewModel)
    }
    
    func presentMediaLibraryPicker() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func presentCameraPhoto() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func cleanPhotoImage() {
        contentView.removeSelectedPhoto()
    }
    
    func presentCanvasView() {
        if contentView.isEnableToEddit {
            interactor.showCanvas(with: .init(edditingImage: contentView.returnCurrentImage()))
        }
    }
    
    func presentFiltersView() {
        if contentView.isEnableToEddit {
            interactor.showFilters(with: .init(edditingImage: contentView.returnCurrentImage()!))
        }
    }
    
    func shareImage() {
        if contentView.isEnableToEddit {
            if let imageContent = contentView.returnCurrentImage() {
                let activityViewController = UIActivityViewController(activityItems: [imageContent], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                present(activityViewController, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let choosenImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        contentView.updateImagePhoto(with: choosenImage)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
