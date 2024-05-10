// MARK: - Imports

import UIKit

protocol DisplayMainViewController: AnyObject {
    func displayInitialData(with viewModel: MainView.ViewModel)
    func presentMediaLibraryPicker()
    func presentCameraPhoto()
    func cleanPhotoImage()
}

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = MainView()
    private let interactor: MainBusinessLogic
    
    // MARK: - .init()
    
    init(interactor: MainBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.showInitialData()
    }
}

// MARK: - DisplayMainViewController

extension MainViewController: DisplayMainViewController {
    func displayInitialData(with viewModel: MainView.ViewModel) {
        contentView.configure(with: viewModel)
    }
    
    func presentMediaLibraryPicker() {
        let imagePicker = UIImagePickerController()
         imagePicker.delegate = self
         imagePicker.sourceType = .photoLibrary
         present(imagePicker, animated: true, completion: nil)
    }
    
    func presentCameraPhoto() {
        let imagePicker = UIImagePickerController()
         imagePicker.delegate = self
         imagePicker.sourceType = .camera
         present(imagePicker, animated: true, completion: nil)
    }
    
    func cleanPhotoImage() {
        contentView.removeSelectedPhoto()
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            contentView.updateImagePhoto(with: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
