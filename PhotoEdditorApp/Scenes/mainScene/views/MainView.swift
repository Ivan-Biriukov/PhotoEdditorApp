// MARK: - Imports

import UIKit

// MARK: - MainView

final class MainView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        
    }
    
    // MARK: - Properties
    
    
    // MARK: - Private properties
    
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        addSUbviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure

private extension MainView {
    
    // MARK: - .addSubviews()
    
    func addSUbviews() {
        
    }
    
    // MARK: - .setupConstraints()
    
    func setupConstraints() {
        
    }
}

// MARK: - ViewModelConfigurable

extension MainView: ViewModelConfigurable {
    struct ViewModel {
        
    }
    
    func configure(with viewModel: ViewModel) {
        
    }
}
