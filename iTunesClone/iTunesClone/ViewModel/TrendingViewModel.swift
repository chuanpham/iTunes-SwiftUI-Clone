//
//  TrendingViewModel.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import Foundation

class TopSongsViewModel: ObservableObject {
    @Published var topSongs: TopSongs? = nil
    
    @Published var state: FetchState = .start
    
    let service = APIService()
    
    func fetchTopSongs() {
        state = .isLoading
        
        service.fetchTopSongs { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self?.topSongs = results
                    self?.state = .loadedAll
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
}

class TopAppsViewModel: ObservableObject {
    @Published var topApps: TopApps? = nil
    @Published var type: TopAppsEntityType = .free
    
    @Published var state: FetchState = .start
    
    let service = APIService()
    
    func fetchTopApps() {
        state = .isLoading
        
        service.fetchTopApps(type: type) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self?.topApps = results
                    self?.state = .loadedAll
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
}

class TopPodcastsViewModel: ObservableObject {
    @Published var topPodcasts: TopPodcasts? = nil
    
    @Published var type: TopPodcastsEntityType = .top
    
    @Published var state: FetchState = .start
    
    let service = APIService()
    
    func fetchTopPodcasts() {
        state = .isLoading
        
        service.fetchTopPodcasts(type: type) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self?.topPodcasts = results
                    self?.state = .loadedAll
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
}
