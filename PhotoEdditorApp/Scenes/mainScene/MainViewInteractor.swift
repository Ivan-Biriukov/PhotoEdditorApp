// MARK: - Imports

import Foundation

// MARK: - MainBusinessLogic

protocol MainBusinessLogic {
    func showInitialData()
}

// MARK: -  MainSceneInteractor

final class MainSceneInteractor {
    
    // MARK: - Properties
    
    let presenter: MainViewPresenter
    
    // MARK: - Init
    
    init(presenter: MainViewPresenter) {
        self.presenter = presenter
    }
}

// MARK: - Confirming to interactor protocol

extension MainSceneInteractor: MainBusinessLogic {
    func showInitialData() {
        presenter.presentScreenInitialData()
    }
}

