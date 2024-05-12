import UIKit

// MARK: - DisplayTextScene

protocol DisplayTextScene: AnyObject {
    func displayInitionalData(viewModel: TextView.ViewModel)
    func dissmissSelf()
    func displayColorPicker()
}

// MARK: - TextViewController

final class TextViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = TextView()
    private let interactor: TextBusinessLogic
    
    // MARK: - Init
    
    init(interactor: TextBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        interactor.showData()
    }
}

// MARK: - Confirming to DisplaTextScene

extension TextViewController: DisplayTextScene {
    func displayColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        self.present(colorPicker, animated: true)
    }
    
    func dissmissSelf() {
        self.dismiss(animated: true)
    }
    
    func displayInitionalData(viewModel: TextView.ViewModel) {
        contentView.configure(with: viewModel)
    }
}

// MARK: - UIColorPickerViewControllerDelegate

extension TextViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        contentView.changeTextColor(with: color)
    }
}
