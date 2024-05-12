import Foundation

// MARK: - MainViewFabric

final class MainViewFabric: Factory {
    
    typealias Context = Void
    typealias ViewController = MainViewController
    
    func build(from context: Context) -> ViewController {
        
        let presenter = MainViewPresenter()
        let interactor = MainSceneInteractor(presenter: presenter)
        let viewController = MainViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
