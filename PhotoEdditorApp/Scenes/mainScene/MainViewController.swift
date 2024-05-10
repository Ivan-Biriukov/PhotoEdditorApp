// MARK: - Imports

import UIKit

protocol DisplayMainViewController: AnyObject {
    
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
        
    }


}

extension MainViewController: DisplayMainViewController {
    
}
