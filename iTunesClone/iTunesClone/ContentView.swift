//
//  ContentView.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            SongSearchView()
                .tabItem {
                    Label("Songs", systemImage: "music.note.list")
                }
            
            AlbumSearchView()
                .tabItem {
                    Label("Albums", systemImage: "rectangle.stack.badge.play")
                }
            
            MovieSearchView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
            
            TrendingView()
                .tabItem {
                    Label("Trending", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
