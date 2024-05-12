import Foundation

// MARK: - PresentsCanvasProtocol

protocol PresentsCanvasProtocol {
    func presentScreenData()
}

// MARK: - CanvasPresenter

final class CanvasPresenter {
    
    // MARK: - Properties
    
    weak var viewController: DisplayCanvasViewController?
    private var contex: CanvasView.ViewModel
    
    // MARK: - Init
    
    init(viewController: DisplayCanvasViewController? = nil, contex: CanvasView.ViewModel) {
        self.viewController = viewController
        self.contex = contex
    }
}

// MARK: - PresentsAuthentificationInfo

extension CanvasPresenter: PresentsCanvasProtocol {
    func presentScreenData() {
        viewController?.displayInitialData(with:
                .init(
                    edditingImage: contex.edditingImage,
                    closeAction: viewController?.dissmissSelf
                )
        )
    }
}
