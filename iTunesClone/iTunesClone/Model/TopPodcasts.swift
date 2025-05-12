//
//  TopPodcasts.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import Foundation

// MARK: - TopPodcasts
struct TopPodcasts: Codable {
    let feed: TopPodcastsFeed
}

// MARK: - Feed
struct TopPodcastsFeed: Codable {
    let updated: String
    let results: [TopPodcastsResult]
}

// MARK: - Result
struct TopPodcastsResult: Codable, Identifiable {
    let id: String
    let name: String
    let artistName: String
    let artworkUrl100: String
    let genres: [TopPodcastsGenre]
    let url: String
}

// MARK: - Genre
struct TopPodcastsGenre: Codable, Identifiable {
    let genreID: String
    let name: String
    let url: String

    var id: String { genreID } // <-- satisfies Identifiable

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}
