import UIKit
import DIKit
import DataSourceKit
import RxSwift
import RxCocoa

final class RepositoriesViewController: UIViewController, FactoryMethodInjectable {
    struct Dependency {
        let appResolver: AppResolver
    }
    
    static func makeInstance(dependency: RepositoriesViewController.Dependency) -> RepositoriesViewController {
        let storyboard = UIStoryboard(name: "Repositories", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()! as! RepositoriesViewController
        viewController.dependency = dependency
        return viewController
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var dependency: Dependency!
    private let dataSource = RepositoriesDataSource()
    private let disposeBag = DisposeBag()
    
    private lazy var viewModel = dependency.appResolver.resolveRepositoriesViewModel(
        starToggledIndex: dataSource.starredIndex)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        viewModel.cellDeclarations
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
