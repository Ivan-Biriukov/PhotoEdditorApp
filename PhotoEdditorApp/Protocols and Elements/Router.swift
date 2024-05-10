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
}
