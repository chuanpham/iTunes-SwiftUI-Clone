//
//  TopAppsModel.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import Foundation

// MARK: - TopApps
struct TopApps: Codable {
    let feed: TopAppsFeed
}

// MARK: - Feed
struct TopAppsFeed: Codable {
    let title: String
    let id: String
    let author: TopAppAuthor
    let copyright: String
    let country: String
    let icon: String
    let results: [TopApp]
}

// MARK: - Author
struct TopAppAuthor: Codable {
    let name: String
    let url: String
}

// MARK: - Result
struct TopApp: Codable, Identifiable {
    let artistName, id, name, releaseDate: String
    let artworkUrl100: String
    let url: String
}

