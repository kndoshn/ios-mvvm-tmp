import Foundation

struct ListRepositoriesRequest: APIRequest, Equatable {
    typealias Response = ListRepositoriesResponse
}

struct ListRepositoriesResponse: Equatable {
    var repositories: [Repository]
}

struct StarRepositoryRequest: APIRequest, Equatable {
    typealias Response = StarRepositoryResponse
    var id: Int64
}

struct StarRepositoryResponse: Equatable {
    var repository: Repository
}

struct UnstarRepositoryRequest: APIRequest, Equatable {
    typealias Response = UnstarrepositoryResponse
    var id: Int64
}

struct UnstarrepositoryResponse: Equatable {
    var repository: Repository
}
