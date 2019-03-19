import UIKit
import DataSourceKit
import RxSwift

final class RepositoryCell: UICollectionViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var starButton: UIButton!

    private(set) lazy var starButtonTap = starButton.rx.tap.asSignal()
    private(set) var reuseDisposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        reuseDisposeBag = DisposeBag()
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        var totalWidth = frame.width
        if let superview = superview {
            totalWidth = superview.frame.width
        }

        var targetSize = UIView.layoutFittingCompressedSize
        targetSize.width = totalWidth

        layoutAttributes.size = CGSize(
            width: targetSize.width,
            height: contentView.systemLayoutSizeFitting(
                targetSize,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel).height)
        return layoutAttributes
    }
}

extension RepositoryCell: BindableCell {
    static func makeBinder(value repository: Repository) -> CellBinder {
        return CellBinder(
            cellType: RepositoryCell.self,
            registrationMethod: .none,
            reuseIdentifier: "RepositoryCell",
            configureCell: { cell in
                cell.nameLabel.text = repository.name
                cell.descriptionLabel.text = repository.description
                cell.starButton.isSelected = repository.isStarred
            })
    }
}
