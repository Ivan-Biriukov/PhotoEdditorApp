import UIKit
import SnapKit

fileprivate enum Constants {
    static let itemImageSidesInsets: CGFloat = 15
    static let selectedBGColor: UIColor = UIColor(red: 115/255, green: 190/255, blue: 170/255, alpha: 1.0)
}

final class FiltersCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let id = "FiltersCollectionViewCell"
    
    private lazy var itemImage = UIImageView()
    
    override var isSelected: Bool {
       didSet{
           if self.isSelected {
               UIView.animate(withDuration: 0.3) {
                   self.backgroundColor = Constants.selectedBGColor
               }
           }
           else {
               UIView.animate(withDuration: 0.3) {
                   self.backgroundColor = .clear
               }
           }
       }
   }
    
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
        
        itemImage.snp.makeConstraints { make in
            make.directionalHorizontalEdges.directionalVerticalEdges.equalToSuperview().inset(Constants.itemImageSidesInsets)
        }
    }
}

// MARK: - ViewModelConfigurable

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
