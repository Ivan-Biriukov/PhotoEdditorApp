import Foundation

// MARK: - TextBusinessLogic

protocol TextBusinessLogic {
    func showData()
}

// MARK: -  TextInteractor

final class TextInteractor {
    
    // MARK: - Properties
    
    let presenter: TextPresenter
    
    // MARK: - Init
    
    init(presenter: TextPresenter) {
        self.presenter = presenter
    }
}

// MARK: - Confirming to interactor protocol

extension TextInteractor: TextBusinessLogic {
    func showData() {
        presenter.presentScreenData()
    }
}

