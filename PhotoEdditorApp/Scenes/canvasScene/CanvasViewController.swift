// MARK: - Imports

import UIKit

// MARK: - DisplayCanvasViewController

protocol DisplayCanvasViewController: AnyObject {
    func displayInitialData(with viewModel: CanvasView.ViewModel)
}

// MARK: - ViewControllerClassNameCanvasViewController

final class CanvasViewController: UIViewController {
    
    // MARK: - Private Properties
    
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
}

// MARK: - Confirming to DisplayCanvasViewController

extension CanvasViewController: DisplayCanvasViewController {
    func displayInitialData(with viewModel: CanvasView.ViewModel) {
        contentView.configure(with: viewModel)
    }
}
