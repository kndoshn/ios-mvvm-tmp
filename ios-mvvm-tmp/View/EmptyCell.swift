import UIKit
import DataSourceKit

final class EmptyCell: UICollectionViewCell {
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var messageLabel: UILabel!

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.size = superview?.frame.size ?? UIScreen.main.bounds.size
        return layoutAttributes
    }
}

extension EmptyCell: BindableCell {
    static func makeBinder(value isLoading: Bool) -> CellBinder {
        return CellBinder(
            cellType: EmptyCell.self,
            registrationMethod: .none,
            reuseIdentifier: "EmptyCell",
            configureCell: { cell in
                cell.messageLabel.isHidden = isLoading

                if isLoading {
                    cell.activityIndicatorView.startAnimating()
                } else {
                    cell.activityIndicatorView.stopAnimating()
                }
            })
    }
}
