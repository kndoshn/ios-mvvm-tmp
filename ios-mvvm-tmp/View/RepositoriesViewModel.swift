import Foundation
import DIKit
import DataSourceKit
import RxSwift
import RxCocoa

final class RepositoriesViewModel: Injectable {
    struct Dependency {
        let starToggledIndex: Signal<Int>
        let apiClient: APIClient
    }

    enum CellDeclaration: Equatable {
        case empty(isLoading: Bool)
        case repository(Repository)
    }

    struct State: CellsDeclarator, Mutatable {
        var repositories = [] as [Repository]
        var isLoading = false

        var cells: [CellDeclaration] {
            if repositories.isEmpty {
                return [.empty(isLoading: isLoading)]
            } else {
                return repositories.map { .repository($0) }
            }
        }

        func declareCells(_ cell: (CellDeclaration) -> Void) {
            guard !repositories.isEmpty else {
                cell(.empty(isLoading: isLoading))
                return
            }

            for repository in repositories {
                cell(.repository(repository))
            }
        }
    }

    private let stateRelay = BehaviorRelay(value: State())

    private(set) lazy var cellDeclarations = stateRelay.asDriver()
        .map { $0.cellDeclarations }
        .distinctUntilChanged()

    private let disposeBag = DisposeBag()
    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
        bindToggleStar()
        loadRepositories()
    }

    private func bindToggleStar() {

    }

    private func loadRepositories() {

    }
}
