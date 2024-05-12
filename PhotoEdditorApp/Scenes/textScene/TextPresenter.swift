//
//  TextPresenter.swift
//  PhotoEdditorApp
//
//  Created by иван Бирюков on 12.05.2024.
//

import Foundation

// MARK: - Imports

import Foundation

// MARK: - PresentsTextProtocol

protocol PresentsTextProtocol {
    func presentScreenData()
}

// MARK: - TextPresenter

final class TextPresenter {
    
    // MARK: - Properties
    
    weak var viewController: DisplayTextScene?
    private var contex: TextView.ViewModel
    
    // MARK: - Init
    
    init(viewController: DisplayTextScene? = nil, contex: TextView.ViewModel) {
        self.viewController = viewController
        self.contex = contex
    }
}

// MARK: - PresentsAuthentificationInfo

extension TextPresenter: PresentsTextProtocol {
    func presentScreenData() {
        viewController?.displayInitionalData(viewModel: contex)
    }
}
