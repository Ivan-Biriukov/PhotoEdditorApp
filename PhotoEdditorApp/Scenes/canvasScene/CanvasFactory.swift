// MARK: - Imports

import UIKit

// MARK: - CanvasFabric

final class CanvasFabric: Factory {
    
    typealias Context = CanvasView.ViewModel
    typealias ViewController = CanvasViewController
    
    func build(from context: Context) -> ViewController {
        
        let presenter = CanvasPresenter(contex: context)
        let interactor = CanvasInteractor(presenter: presenter)
        let viewController = CanvasViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
