import Foundation

// MARK: - CanvasBusinessLogic

protocol CanvasBusinessLogic {
    func showInitialData()
}

// MARK: -  CanvasInteractor

final class CanvasInteractor {
    
    // MARK: - Properties
    
    let presenter: CanvasPresenter
    
    // MARK: - Init
    
    init(presenter: CanvasPresenter) {
        self.presenter = presenter
    }
}

// MARK: - Confirming to interactor protocol

extension CanvasInteractor: CanvasBusinessLogic {
    func showInitialData() {
        presenter.presentScreenData()
    }
}

