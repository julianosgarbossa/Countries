//
//  ResponseCache.swift
//  Countries
//

import Foundation

final class ResponseCache {

    static let shared = ResponseCache()

    private let fileManager = FileManager.default
    private let defaultTTL: TimeInterval = 24 * 60 * 60

    private lazy var cacheDirectory: URL = {
        let dir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("CountriesAPICache", isDirectory: true)
        try? fileManager.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }()

    func save<T: Codable>(_ value: T, forKey key: String) {
        let wrapper = CacheEntry(data: value, timestamp: Date())
        guard let data = try? JSONEncoder().encode(wrapper) else { return }
        let fileURL = cacheDirectory.appendingPathComponent(key.cacheFileName)
        try? data.write(to: fileURL, options: Data.WritingOptions.atomic)
    }

    func load<T: Codable>(_ type: T.Type, forKey key: String, ttl: TimeInterval? = nil) -> T? {
        let fileURL = cacheDirectory.appendingPathComponent(key.cacheFileName)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        guard let entry = try? JSONDecoder().decode(CacheEntry<T>.self, from: data) else { return nil }

        let maxAge = ttl ?? defaultTTL
        guard Date().timeIntervalSince(entry.timestamp) < maxAge else {
            try? fileManager.removeItem(at: fileURL)
            return nil
        }

        return entry.data
    }

    func invalidate(forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key.cacheFileName)
        try? fileManager.removeItem(at: fileURL)
    }
}

private struct CacheEntry<T: Codable>: Codable {
    let data: T
    let timestamp: Date
}

private extension String {
    var cacheFileName: String {
        let safe = self.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? self
        return safe + ".cache"
    }
}
