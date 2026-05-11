//
//  ViewState.swift
//  Countries
//

import Foundation

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case empty(message: String)
    case error(message: String)

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
}
