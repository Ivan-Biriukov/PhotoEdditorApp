// MARK: - Imports

import Foundation

// MARK: - FiltersFabric

final class FiltersFabric: Factory {
    
    typealias Context = FiltersView.ViewModel
    typealias ViewController = FiltersViewController
    
    func build(from context: Context) -> ViewController {
        
        let presenter = FiltersPresenter(contex: context)
        let interactor = FiltersInteractor(presenter: presenter)
        let viewController = FiltersViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
