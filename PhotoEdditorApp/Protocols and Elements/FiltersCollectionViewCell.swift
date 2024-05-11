import UIKit
import SnapKit

fileprivate enum Constants {
    static let itemImageSidesInsets: CGFloat = 15
}

final class FiltersCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let id = "FiltersCollectionViewCell"
    
    private lazy var itemImage = UIImageView()
    
    // MARK: - .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfigs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure

private extension FiltersCollectionViewCell {
    func initialConfigs() {
        contentView.addSubview(itemImage)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        itemImage.snp.makeConstraints { make in
            make.directionalHorizontalEdges.directionalVerticalEdges.equalToSuperview().inset(Constants.itemImageSidesInsets)
        }
    }
}

// MARK: -

extension FiltersCollectionViewCell: ViewModelConfigurable {
    struct ViewModel {
        let itemImage: UIImage
        let filterName: String
        var isFilterApplied: Bool
    }
    
    func configure(with viewModel: ViewModel) {
        itemImage.image = viewModel.itemImage
    }
}
