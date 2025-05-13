//
//  TopBooks.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import Foundation

// MARK: - TopBooks
struct TopBooks: Codable {
    let feed: TopBooksFeed
}

// MARK: - Feed
struct TopBooksFeed: Codable {
    let updated: String
    let results: [TopBooksResult]
}

// MARK: - Result
struct TopBooksResult: Codable, Identifiable {
    let artistName, id, name, releaseDate: String
    let artistID: String
    let artistURL: String
    let artworkUrl100: String
    let genres: [TopBooksGenre]
    let url: String

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url
    }
}

// MARK: - Genre
struct TopBooksGenre: Codable, Identifiable {
    let genreID, name: String
    let url: String
    
    var id: String { genreID } // <-- satisfies Identifiable

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}
