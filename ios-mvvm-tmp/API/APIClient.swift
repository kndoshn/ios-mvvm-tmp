import Foundation
import RxSwift
import RxCocoa

protocol APIRequest: Equatable {
    associatedtype Response
}

protocol APIClient {
    func sendRequest<Request: APIRequest>(_ request: Request) -> Single<Request.Response>
}

final class LocalAPIClient: APIClient {
//    private let repositories: [Repository]
    
    func sendRequest<Request: APIRequest>(_ request: Request) -> Single<Request.Response> {
        switch request {
        default:
            return Single.error(RxError.unknown)
        }
    }
}
