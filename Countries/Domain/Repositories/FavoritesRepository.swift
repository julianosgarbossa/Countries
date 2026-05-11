//
//  FavoritesRepository.swift
//  Countries
//

import Foundation

final class FavoritesRepository {

    static let shared = FavoritesRepository()

    private let localStorage = FavoritesLocalStorage.shared
    private let cloudService = FirestoreFavoritesService.shared

    private var isLoggedIn: Bool {
        AuthService.shared.isLoggedIn
    }

    private init() {}

    func allIds() -> Set<String> {
        localStorage.allIds()
    }

    func contains(_ countryId: String) -> Bool {
        localStorage.contains(countryId)
    }

    @discardableResult
    func toggle(_ countryId: String) -> Bool {
        let result = localStorage.toggle(countryId)
        syncToCloudIfNeeded()
        return result
    }

    func syncAfterLogin(completion: (() -> Void)? = nil) {
        guard isLoggedIn else {
            completion?()
            return
        }

        let localIds = localStorage.allIds()

        cloudService.fetchFavorites { [weak self] result in
            guard let self else {
                completion?()
                return
            }

            switch result {
            case .success(let cloudIds):
                let merged = localIds.union(cloudIds)

                for id in merged {
                    if !localIds.contains(id) {
                        self.localStorage.add(id)
                    }
                }

                self.cloudService.saveFavorites(merged) { _ in
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }

    private func syncToCloudIfNeeded() {
        guard isLoggedIn else { return }
        let ids = localStorage.allIds()
        cloudService.saveFavorites(ids)
    }
}
