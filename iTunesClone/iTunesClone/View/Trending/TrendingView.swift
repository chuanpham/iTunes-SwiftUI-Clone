//
//  TrendingView.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import SwiftUI

struct TrendingView: View {
    @StateObject private var topSongsVM = TopSongsViewModel()
    @StateObject private var topAppsVM = TopAppsViewModel()
    @StateObject private var topPodcastsVM = TopPodcastsViewModel()
    
    @State private var selectedType: TrendingEntityType = .songs
    
    var body: some View {
        VStack {
            TrendingPickerView(selectedType: $selectedType)
            
            Divider()
            
            switch selectedType {
            case .songs:
                topSongsView()
            case .podcasts:
                topPodcastsView()
            case .apps:
                topAppsView()
            case .books:
                Text("Podcasts")
            case .audioBooks:
                Text("Podcasts")
            }
            
            Spacer()
        }
    }
    
    private func loadingIndicator() -> some View {
        return VStack {
            Spacer().frame(height: 100)
            ProgressView()
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity)
        }
    }
    
    private func topSongsView() -> some View {
        switch topSongsVM.state {
        case .start:
            return AnyView(
                Color.clear
                    .onAppear {
                        topSongsVM.fetchTopSongs()
                    }
            )
        case .isLoading:
            return AnyView(
                loadingIndicator()
            )
        case .loadedAll:
            return AnyView(
                List {
                    ForEach(topSongsVM.topSongs!.feed.results) { song in
                        HStack {
                            ImageLoadingView(
                                urlString: song.artworkUrl100,
                                width: 60,
                                height: 60
                            )
                            VStack(alignment: .leading) {
                                Text(song.name)
                                    .font(.headline)
                                    .font(.system(size: 10))
                                Text("Release Date: \(song.releaseDate ?? "N/A")")
                                    .font(.footnote)
                                    .foregroundColor(.gray.opacity(0.8))
                                    .font(.system(size: 8))
                                Text(song.artistName)
                                    .font(.footnote)
                                    .font(.system(size: 8))
                            }
                        }
                    }
                }
                    .listStyle(.plain)
            )
        case .error(let message):
            return AnyView(
                Text(message)
                    .foregroundStyle(.red)
            )
        }
    }
    
    private func topAppsView() -> some View {
        return Group {
            Picker("Apps", selection: $topAppsVM.type) {
                ForEach(TopAppsEntityType.allCases) { type in
                    Text(type.name).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            switch topAppsVM.state {
            case .start:
                Color.clear
                    .onAppear {
                        topAppsVM.fetchTopApps()
                    }
            case .isLoading:
                loadingIndicator()
            case .loadedAll:
                List {
                    ForEach (topAppsVM.topApps!.feed.results) { app in
                        HStack {
                            ImageLoadingView(
                                urlString: app.artworkUrl100,
                                width: 60,
                                height: 60
                            )
                            VStack(alignment: .leading) {
                                Text(app.name)
                                    .font(.headline)
                                    .font(.system(size: 10))
                                Text("Release Date: \(app.releaseDate)")
                                    .font(.footnote)
                                    .foregroundColor(.gray.opacity(0.8))
                                    .font(.system(size: 8))
                                Text(app.artistName)
                                    .font(.footnote)
                                    .font(.system(size: 8))
                            }
                        }
                    }
                }
                .listStyle(.plain)
            case .error(let message):
                Text(message)
                    .foregroundStyle(.red)
            }
        }
        .onChange(of: topAppsVM.type) { _, newValue in
            topAppsVM.fetchTopApps()
        }
    }
    
    private func topPodcastsView() -> some View {
        return VStack {
            Picker("Podcasts", selection: $topPodcastsVM.type) {
                ForEach(TopPodcastsEntityType.allCases, id: \.self) { type in
                    Text(type.name).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .onChange(of: topPodcastsVM.type) { _, _ in
                topPodcastsVM.fetchTopPodcasts()
            }
            
            switch topPodcastsVM.state {
            case .start:
                Color.clear.onAppear {
                    topPodcastsVM.fetchTopPodcasts()
                }
            case .isLoading:
                AnyView(loadingIndicator())
            case .loadedAll:
                if let results = topPodcastsVM.topPodcasts?.feed.results {
                    AnyView(
                        List {
                            Text("Updated at: \(topPodcastsVM.topPodcasts?.feed.updated ?? "Updated at: Unknown")")
                                .font(.footnote)
                                .font(.system(size: 10))
                                .foregroundColor( Color.gray)
                            
                            ForEach(results, id: \.id) { podcast in
                                HStack {
                                    ImageLoadingView(
                                        urlString: podcast.artworkUrl100,
                                        width: 60,
                                        height: 60
                                    )
                                    VStack(alignment: .leading) {
                                        Text(podcast.name)
                                            .font(.headline)
                                            .font(.system(size: 10))
                                        
                                        HStack {
                                            ForEach(podcast.genres) { genre in
                                                Text(genre.name)
                                                    .font(.footnote)
                                                    .font(.system(size: 8))
                                                    .padding(.horizontal, 6)
                                                    .padding(.vertical, 2)
                                                    .background( Color.gray.opacity(0.2))
                                                    .foregroundColor(.primary)
                                                    .cornerRadius(5)
                                            }
                                        }
                                        
                                        Text(podcast.artistName)
                                            .font(.footnote)
                                            .font(.system(size: 8))
                                    }
                                }
                            }
                        }
                            .listStyle(.plain)
                    )
                } else {
                    AnyView(Text("No results"))
                }
            case .error(let message):
                AnyView(Text(message).foregroundStyle(.red))
            }
        }
    }
}

struct TrendingPickerView: View {
    @Binding var selectedType: TrendingEntityType
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(TrendingEntityType.allCases) { type in
                    Text(type.name)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selectedType == type ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(selectedType == type ? .white : .primary)
                        .cornerRadius(12)
                        .onTapGesture {
                            withAnimation {
                                selectedType = type
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}
