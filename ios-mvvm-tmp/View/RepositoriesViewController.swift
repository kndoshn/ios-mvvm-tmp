import UIKit
import DIKit

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
    
    private var dependency: Dependency!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
