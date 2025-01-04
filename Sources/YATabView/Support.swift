import SwiftUI

internal extension Binding where Value: Sendable {
    func makeOptional() -> Binding<Value?> {
        Binding<Value?> {
            wrappedValue
        } set: { value, transaction in
            withTransaction(transaction) {
                if let value {
                    wrappedValue = value
                }
            }
        }
    }
}
