import Foundation

// MARK: - PresentsFiltersProtocol

protocol PresentsFiltersProtocol {
    func presentScreenData()
}

// MARK: - FiltersPresenter

final class FiltersPresenter {
    
    // MARK: - Properties
    
    weak var viewController: DisplayFilters?
    private var contex: FiltersView.ViewModel
    
    // MARK: - Init
    
    init(viewController: DisplayFilters? = nil, contex: FiltersView.ViewModel) {
        self.viewController = viewController
        self.contex = contex
    }
}

// MARK: - PresentsAuthentificationInfo

extension FiltersPresenter: PresentsFiltersProtocol {
    func presentScreenData() {
        viewController?.displayInitionalData(viewModel:
                .init(
                    edditingImage: contex.edditingImage,
                    closeAction: viewController?.dissmissSelf
                )
        )
    }
}
