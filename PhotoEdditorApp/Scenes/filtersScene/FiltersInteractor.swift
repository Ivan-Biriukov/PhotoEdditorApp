import Foundation

// MARK: - FiltersBusinessLogic

protocol FiltersBusinessLogic {
    func showData()
}

// MARK: -  FiltersInteractor

final class FiltersInteractor {
    
    // MARK: - Properties
    
    let presenter: FiltersPresenter
    
    // MARK: - Init
    
    init(presenter: FiltersPresenter) {
        self.presenter = presenter
    }
}

// MARK: - Confirming to interactor protocol

extension FiltersInteractor: FiltersBusinessLogic {
    func showData() {
        presenter.presentScreenData()
    }
}
