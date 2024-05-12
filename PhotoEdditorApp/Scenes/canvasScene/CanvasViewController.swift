import UIKit

// MARK: - DisplayCanvasViewController

protocol DisplayCanvasViewController: AnyObject {
    func displayInitialData(with viewModel: CanvasView.ViewModel)
    func dissmissSelf()
}

// MARK: - CanvasViewController

final class CanvasViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = CanvasView()
    private let interactor: CanvasBusinessLogic
    
    // MARK: - Init
    
    init(interactor: CanvasBusinessLogic) {
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
        interactor.showInitialData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.prepareImage()
    }
}

// MARK: - Confirming to DisplayCanvasViewController

extension CanvasViewController: DisplayCanvasViewController {
    func displayInitialData(with viewModel: CanvasView.ViewModel) {
        contentView.configure(with: viewModel)
    }
    
    func dissmissSelf() {
        self.dismiss(animated: true)
    }
}
