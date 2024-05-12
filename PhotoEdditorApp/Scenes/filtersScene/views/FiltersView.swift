import UIKit
import SnapKit

// MARK: - FiltersView

final class FiltersView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let toolBarHeight: CGFloat = 40
        static let currentImageHeight: CGFloat = SizeCalculator.deviceHeight - 300
        static let currentImageWidth: CGFloat = SizeCalculator.deviceWidth - 50
        static let currentImageTopOffset: CGFloat = 25
        static let collectionItemSize: CGSize = .init(width: 80, height: 80)
        static let filtersCollectionViewHeight: CGFloat = 100
        static let filtersCollectionViewTopOffset: CGFloat = 20
        static let observingNotificationName: String = "edditingImageObserver"
        static let observerImageObjectName: String = "edditingImage"
    }
    
    // MARK: - Properties
    
    private var closeAction: (() -> Void)?
    private var dataSource: [FiltersCollectionViewCell.ViewModel] = [
        .init(itemImage: AppImages.blureIcon!, filterName: "CIGaussianBlur", isFilterApplied: false),
        .init(itemImage: AppImages.oldIcon!, filterName: "CISepiaTone", isFilterApplied: false),
        .init(itemImage: AppImages.shunyIcon!, filterName: "CISharpenLuminance", isFilterApplied: false),
        .init(itemImage: AppImages.blacAndWhiteIcon!, filterName: "CIPhotoEffectMono", isFilterApplied: false),
        .init(itemImage: AppImages.instantIcon!, filterName: "CIPhotoEffectInstant", isFilterApplied: false),
        .init(itemImage: AppImages.pixeledIcon!, filterName: "CIPixellate", isFilterApplied: false),
        .init(itemImage: AppImages.comicIcon!, filterName: "CIComicEffect", isFilterApplied: false)
    ]
    
    private var edditingImage = UIImage()
    private let toolBar = UIToolbar()
    private lazy var cancelChanges: UIBarButtonItem = .init(title: "Cancel changes", style: .plain, target: self, action: #selector(removeChanges))
    private let space: UIBarButtonItem = .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private lazy var saveButton: UIBarButtonItem = .init(title: "Save & Close", style: .done, target: self, action: #selector(save))
    private let space1: UIBarButtonItem = .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private lazy var closeButton: UIBarButtonItem = .init(title: "Close", style: .plain, target: self, action: #selector(close))
    
    private lazy var currentImageView: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 1
        image.layer.borderColor = AppPallete.titleTextColor.cgColor
        return image
    }()
    
    private lazy var filtersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Constants.collectionItemSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(FiltersCollectionViewCell.self, forCellWithReuseIdentifier: FiltersCollectionViewCell.id)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        addSUbviews()
        setupConstraints()
        initialConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func filterIt(with filterName: String) {
        let startImage = CIImage(image: currentImageView.image!)
        let filter = CIFilter(name: filterName)
        filter?.setValue(startImage, forKey: kCIInputImageKey)
        
        if let outputImage = filter?.outputImage {
            if let cgimg = CIContext().createCGImage(outputImage, from: outputImage.extent) {
                let newImage = UIImage(cgImage: cgimg)
                currentImageView.image = newImage
            }
        }
    }
}

// MARK: - Configure

private extension FiltersView {
    func addSUbviews() {
        [toolBar,
         currentImageView,
         filtersCollectionView].forEach {
            self.addSubview($0)
        }
    }
        
    func setupConstraints() {
        toolBar.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(Constants.toolBarHeight)
            make.top.equalToSuperview()
        }
        
        currentImageView.snp.makeConstraints { make in
            make.width.equalTo(Constants.currentImageWidth)
            make.height.equalTo(Constants.currentImageHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(toolBar.snp.bottom).offset(Constants.currentImageTopOffset)
        }
        
        filtersCollectionView.snp.makeConstraints { make in
            make.height.equalTo(Constants.filtersCollectionViewHeight)
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(currentImageView.snp.bottom).offset(Constants.filtersCollectionViewTopOffset)
        }
    }
    
    func initialConfigure() {
        backgroundColor = AppPallete.filtersBG
        toolBar.items = [cancelChanges, space, saveButton, space1, closeButton]
    }
}

// MARK: - Actions

private extension FiltersView {
    @objc func removeChanges() {
        currentImageView.image = edditingImage
    }
    
    @objc func save() {
        NotificationCenter.default.post(
            name: NSNotification.Name(Constants.observingNotificationName),
            object: [Constants.observerImageObjectName : currentImageView.image]
        )
        closeAction?()
    }
    
    @objc func close() {
        closeAction?()
    }
}

// MARK: - ViewModelConfigurable

extension FiltersView: ViewModelConfigurable {
    struct ViewModel {
        let edditingImage: UIImage
        let closeAction: (() -> Void)?
        
        init(
            edditingImage: UIImage,
            closeAction: (() -> Void)? = nil
        ) {
            self.edditingImage = edditingImage
            self.closeAction = closeAction
        }
    }
    
    func configure(with viewModel: ViewModel) {
        edditingImage = viewModel.edditingImage
        currentImageView.image = viewModel.edditingImage
        closeAction = viewModel.closeAction
    }
}


// MARK: - UICollectionViewDataSource

extension FiltersView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiltersCollectionViewCell.id, for: indexPath) as? FiltersCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let currentCell = dataSource[indexPath.row]
        cell.configure(with: currentCell)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FiltersView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRowItem = dataSource[indexPath.row]
        
        switch selectedRowItem.isFilterApplied {
        case true:
            currentImageView.image = edditingImage
        case false:
            filterIt(with: selectedRowItem.filterName)
        }
        
        dataSource[indexPath.row].isFilterApplied = !selectedRowItem.isFilterApplied
    }
}
