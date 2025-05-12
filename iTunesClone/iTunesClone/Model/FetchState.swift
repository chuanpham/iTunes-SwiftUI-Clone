//
//  FetchState.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import Foundation

enum FetchState: Comparable {
    case start
    case isLoading
    case loadedAll
    case error(String)
}
