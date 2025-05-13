//
//  TopAudioBooks.swift
//  iTunesClone
//
//  Created by chuanpham on 13/5/25.
//

import Foundation

// MARK: - TopAudioBooks
struct TopAudioBooks: Codable {
    let feed: TopAudioBooksFeed
}

// MARK: - Feed
struct TopAudioBooksFeed: Codable {
    let updated: String
    let results: [TopAudioBooksResult]
}

// MARK: - Result
struct TopAudioBooksResult: Codable, Identifiable {
    let artistName, id, name, releaseDate: String
    let artistID: String
    let artistURL: String
    let artworkUrl100: String
    let genres: [TopAudioBooksGenre]
    let url: String

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url
    }
}

// MARK: - Genre
struct TopAudioBooksGenre: Codable, Identifiable {
    let genreID, name: String
    let url: String
    
    var id: String { genreID } // <-- satisfies Identifiable

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}
