import UIKit

// MARK: - DisplayFilters

protocol DisplayFilters: AnyObject {
    func displayInitionalData(viewModel: FiltersView.ViewModel)
    func dissmissSelf()
}

// MARK: - FiltersViewController

final class FiltersViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = FiltersView()
    private let interactor: FiltersBusinessLogic
    
    // MARK: - Init
    
    init(interactor: FiltersBusinessLogic) {
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
        interactor.showData()
    }
}

// MARK: - Confirming to DisplayFilters

extension FiltersViewController: DisplayFilters {
    func displayInitionalData(viewModel: FiltersView.ViewModel) {
        contentView.configure(with: viewModel)
    }
    
    func dissmissSelf() {
        self.dismiss(animated: true)
    }
}

