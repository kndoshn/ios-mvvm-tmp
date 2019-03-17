import Foundation

struct Repository: Equatable, Mutatable {
    var id: Int64
    var name: String
    var description: String
    var isStarred: Bool
}
