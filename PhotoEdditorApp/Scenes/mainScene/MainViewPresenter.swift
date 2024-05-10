//
//  MainViewPresenter.swift
//  PhotoEdditorApp
//
//  Created by иван Бирюков on 10.05.2024.
//

import Foundation

// MARK: - Imports

import Foundation

// MARK: - PresentsMainScene

protocol PresentsMainViewProtocol {
    func presentScreenData()
}

// MARK: - MainViewPresenter

final class MainViewPresenter {
    
    // MARK: - Properties
    
    weak var viewController: DisplayMainViewController?
    
    // MARK: - Init
    
    init(viewController: DisplayMainViewController? = nil) {
        self.viewController = viewController
    }
}

// MARK: - PresentsAuthentificationInfo

extension MainViewPresenter: PresentsMainViewProtocol {
    func presentScreenData() {
        //viewController?.displayInitionalData(viewModel: <#T##AuthentificationView.ViewModel#>)
    }
}
