import UIKit

final class Router {
    private static let navigationController = UINavigationController()
    private init() {}
}

extension Router {
    
    static func startRouting() -> UINavigationController {
        return navigationController
    }
    
    static func performRoute<F>(factory: F, context: F.Context, animated: Bool = true) where F: Factory, F.ViewController: UIViewController {
        let viewController = factory.build(from: context)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    static func performPopUpRoute<F>(factory: F, context: F.Context, animated: Bool = true) where F: Factory, F.ViewController: UIViewController {
        let vc = factory.build(from: context)
        vc.modalPresentationStyle = .popover
        
        navigationController.present(vc, animated: true)
    }
}

extension Router: MainRoutes {
    static func mainScreen() {
        performRoute(factory: MainViewFabric(), context: ())
    }
}

extension Router: CanvasRoutes {
    static func canvasScreen(with contex: CanvasView.ViewModel) {
        performPopUpRoute(factory: CanvasFabric(), context: contex)
    }
}

extension Router: FiltersRoutes {
    static func filtersScreen(with contex: FiltersView.ViewModel) {
        performPopUpRoute(factory: FiltersFabric(), context: contex)
    }
}
