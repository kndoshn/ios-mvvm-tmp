import Foundation

protocol Mutatable {}

extension Mutatable {
    func mutated(mutator: (inout Self) -> Void) -> Self {
        var newValue = self
        mutator(&newValue)
        return newValue
    }
}
