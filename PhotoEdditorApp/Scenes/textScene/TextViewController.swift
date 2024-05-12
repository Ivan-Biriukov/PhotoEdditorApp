//
//  TextViewController.swift
//  PhotoEdditorApp
//
//  Created by иван Бирюков on 12.05.2024.
//

import Foundation

// MARK: - Imports

import UIKit

// MARK: - DisplayTextScene

protocol DisplayTextScene: AnyObject {
    func displayInitionalData(viewModel: TextView.ViewModel)
}

// MARK: - TextViewController

final class TextViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = TextView()
    private let interactor: TextBusinessLogic
    
    // MARK: - Init
    
    init(interactor: TextBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.showData()
    }
}

// MARK: - Confirming to DisplaTextScene

extension TextViewController: DisplayTextScene {
    func displayInitionalData(viewModel: TextView.ViewModel) {
        contentView.configure(with: viewModel)
    }
}

