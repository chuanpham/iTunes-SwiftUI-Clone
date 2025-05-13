//
//  EntityType.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import Foundation

enum EntityType: String, Identifiable, CaseIterable {
    case all
    case album
    case song
    case movie
    
    var id: String {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .all:
            return "All"
        case .album:
            return "Albums"
        case .song:
            return "Songs"
        case .movie:
            return "Movies"
        }
    }
}

enum TrendingEntityType: String, Identifiable, CaseIterable {
    case songs
    case apps
    case podcasts
    case books
    case audioBooks
    
    var id: String {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .songs:
            return "Songs"
        case .apps:
            return "Apps"
        case .podcasts:
            return "Podcasts"
        case .books:
            return "Books"
        case .audioBooks:
            return "Audio Books"
        }
    }
}

enum TopAppsEntityType: String, Identifiable, CaseIterable, Equatable {
    case free
    case paid
    
    var id: String {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .free:
            return "Top Free"
        case .paid:
            return "Top Paid"
        }
    }
    
    var path: String {
        switch self {
        case .free:
            return "top-free"
        case .paid:
            return "top-paid"
        }
    }
}

enum TopPodcastsEntityType: String, Identifiable, CaseIterable, Equatable {
    case top
    case topSubscriber
    
    var id: String {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .top:
            return "Top"
        case .topSubscriber:
            return "Top Subscriber"
        }
    }
    
    var path: String {
        switch self {
        case .top:
            return "top"
        case .topSubscriber:
            return "top-subscriber"
        }
    }
}

enum TopBooksEntityType: String, Identifiable, CaseIterable, Equatable {
    case topFree
    case topPaid
    
    var id: String {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .topFree:
            return "Top Free"
        case .topPaid:
            return "Top Paid"
        }
    }
    
    var path: String {
        switch self {
        case .topFree:
            return "top-free"
        case .topPaid:
            return "top-paid"
        }
    }
}
