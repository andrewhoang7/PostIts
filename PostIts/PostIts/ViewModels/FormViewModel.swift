//
//  FormViewModel.swift
//  PostIts
//
//  Created by Andrew Hoang on 3/30/24.
//

import Foundation

@MainActor
@dynamicMemberLookup
class FormViewModel<Value>: ObservableObject {
    typealias Action = (Value) async throws -> Void
    
    @Published var value: Value
    @Published var error: Error?
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> T {
        get { value[keyPath: keyPath] }
        set { value[keyPath: keyPath] = newValue }
    }
    
    private let action: Action
    
    init(initialValue: Value, action: @escaping Action) {
        self.value = initialValue
        self.action = action
    }
    
    func submit() {
        Task {
            do {
                try await action(value)
            } catch {
                print("[FormViewModel] Cannot submit: \(error)")
                self.error = error
            }
        }
    }
}
