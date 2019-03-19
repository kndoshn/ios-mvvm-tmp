import Foundation
import DataSourceKit
import RxSwift
import RxCocoa

final class RepositoriesDataSource: CollectionViewDataSource<RepositoriesViewModel.CellDeclaration> {
    private let starredIndexRelay = PublishRelay<Int>()

    private(set) lazy var starredIndex = starredIndexRelay.asSignal()

    init() {
        super.init { declaration in
            switch declaration {
            case .empty(let isLoading):
                return EmptyCell.makeBinder(value: isLoading)
            case .repository(let repository):
                return RepositoryCell.makeBinder(value: repository)
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        switch cell {
        case let cell as RepositoryCell:
            cell.starButtonTap
                .emit(onNext: { [starredIndexRelay] in
                    starredIndexRelay.accept(indexPath.row)
                })
                .disposed(by: cell.reuseDisposeBag)
        default:
            break
        }
        return cell
    }
}

extension RepositoriesDataSource: RxCollectionViewDataSourceType {
    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<RepositoriesDataSource.Element>) {
        guard case .next(let newCellDeclarations) = observedEvent else {
            return
        }

        cellDeclarations = newCellDeclarations
        collectionView.reloadData()
    }
}
