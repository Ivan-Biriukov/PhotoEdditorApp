import Foundation

// MARK: - TextFabric

final class TextFabric: Factory {
    
    typealias Context = TextView.ViewModel
    typealias ViewController = TextViewController
    
    func build(from context: Context) -> ViewController {
        
        let presenter = TextPresenter(contex: context)
        let interactor = TextInteractor(presenter: presenter)
        let viewController = TextViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
