// MARK: - Imports

import Foundation

// MARK: - MainBusinessLogic

protocol MainBusinessLogic {
    func showInitialData()
    func showCanvas(with contex: CanvasView.ViewModel)
    func showFilters(with contex: FiltersView.ViewModel)
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
    func showFilters(with contex: FiltersView.ViewModel) {
        presenter.presentFilters(for: contex)
    }
    
    func showCanvas(with contex: CanvasView.ViewModel) {
        presenter.presentCanvas(with: contex)
    }
    
    func showInitialData() {
        presenter.presentScreenInitialData()
    }
    
}

