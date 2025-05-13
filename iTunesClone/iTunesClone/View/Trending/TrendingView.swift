//
//  TrendingView.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import SwiftUI

struct TrendingView: View {
    @State private var selectedType: TrendingEntityType = .songs
    
    var body: some View {
        VStack {
            TrendingPickerView(selectedType: $selectedType)
            
            Divider()
            
            switch selectedType {
            case .songs:
                TopSongsView()
            case .podcasts:
                TopPodcastsView()
            case .apps:
                TopAppsView()
            case .books:
                TopBooksView()
            case .audioBooks:
                TopAudioBooksView()
            }
            
            Spacer()
        }
    }
}

private struct TopSongsView: View {
    @StateObject private var topSongsVM = TopSongsViewModel()
    @State private var selectedSongURL: IdentifiableURL? = nil
    
    var body: some View {
        topSongsView()
            .sheet(item: $selectedSongURL) { identifiable in
                SafariView(url: identifiable.url)
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
                LoadingIndicator()
            )
        case .loadedAll:
            return AnyView(
                List {
                    ForEach(topSongsVM.topSongs!.feed.results) { song in
                        Button(action: {
                            if let url = URL(string: song.url) {
                                selectedSongURL = IdentifiableURL(url: url)
                            }
                        }) {
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
}

private struct TopAppsView: View {
    @StateObject private var topAppsVM = TopAppsViewModel()
    @State private var selectedAppURL: IdentifiableURL? = nil
    
    var body: some View {
        topAppsView()
            .sheet(item: $selectedAppURL) { identifiable in
                SafariView(url: identifiable.url)
            }
    }
    
    private func topAppsView() -> some View {
        Group {
            Picker("Apps", selection: $topAppsVM.type) {
                ForEach(TopAppsEntityType.allCases) { type in
                    Text(type.name).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            contentViewForTopAppsState()
        }
        .onChange(of: topAppsVM.type) { _, _ in
            topAppsVM.fetchTopApps()
        }
    }
    
    @ViewBuilder
    private func contentViewForTopAppsState() -> some View {
        switch topAppsVM.state {
        case .start:
            Color.clear.onAppear {
                topAppsVM.fetchTopApps()
            }
            
        case .isLoading:
            LoadingIndicator()
            
        case .loadedAll:
            if let results = topAppsVM.topApps?.feed.results {
                List {
                    ForEach(results) { app in
                        Button(action: {
                            if let url = URL(string: app.url) {
                                selectedAppURL = IdentifiableURL(url: url)
                            }
                        }) {
                            HStack(alignment: .top) {
                                ImageLoadingView(
                                    urlString: app.artworkUrl100,
                                    width: 60,
                                    height: 60
                                )
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(app.name)
                                        .font(.headline)
                                        .font(.system(size: 10))
                                    
                                    Text("Release Date: \(app.releaseDate)")
                                        .font(.footnote)
                                        .font(.system(size: 8))
                                        .foregroundColor(.gray.opacity(0.8))
                                    
                                    Text(app.artistName)
                                        .font(.footnote)
                                        .font(.system(size: 8))
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
            } else {
                Text("No results")
            }
            
        case .error(let message):
            Text(message).foregroundStyle(.red)
        }
    }
}


private struct TopPodcastsView: View {
    @StateObject private var topPodcastsVM = TopPodcastsViewModel()
    @State private var selectedURL: IdentifiableURL? = nil
    
    var body: some View {
        topPodcastsView()
            .sheet(item: $selectedURL) { identifiable in
                SafariView(url: identifiable.url)
            }
    }
    
    private func topPodcastsView() -> some View {
        VStack {
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
            
            contentViewForTopPodcastsState()
        }
    }
    
    @ViewBuilder
    private func contentViewForTopPodcastsState() -> some View {
        switch topPodcastsVM.state {
        case .start:
            Color.clear.onAppear {
                topPodcastsVM.fetchTopPodcasts()
            }
        case .isLoading:
            LoadingIndicator()
        case .loadedAll:
            if let results = topPodcastsVM.topPodcasts?.feed.results {
                List {
                    Text("Updated at: \(topPodcastsVM.topPodcasts?.feed.updated ?? "Updated at: Unknown")")
                        .font(.footnote)
                        .font(.system(size: 10))
                        .foregroundColor(Color.gray)
                    
                    ForEach(results, id: \.id) { podcast in
                        Button(action: {
                            if let url = URL(string: podcast.url) {
                                selectedURL = IdentifiableURL(url: url)
                            }
                        }) {
                            HStack(alignment: .top) {
                                ImageLoadingView(
                                    urlString: podcast.artworkUrl100,
                                    width: 60,
                                    height: 60
                                )
                                VStack(alignment: .leading, spacing: 4) {
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
                                                .background(Color.gray.opacity(0.2))
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
                }
                .listStyle(.plain)
            } else {
                Text("No results")
            }
        case .error(let message):
            Text(message).foregroundStyle(.red)
        }
    }
}

private struct TopBooksView: View {
    @StateObject private var topBooksVM = TopBooksViewModel()
    @State private var selectedURL: IdentifiableURL? = nil
    
    var body: some View {
        topBooksView()
            .sheet(item: $selectedURL) { identifiable in
                SafariView(url: identifiable.url)
            }
    }
    
    private func topBooksView() -> some View {
        VStack {
            Picker("Books", selection: $topBooksVM.type) {
                ForEach(TopBooksEntityType.allCases, id: \.self) { type in
                    Text(type.name).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .onChange(of: topBooksVM.type) { _, _ in
                topBooksVM.fetchTopBooks()
            }
            
            contentViewForTopBooksState()
        }
    }
    
    @ViewBuilder
    private func contentViewForTopBooksState() -> some View {
        switch topBooksVM.state {
        case .start:
            Color.clear.onAppear {
                topBooksVM.fetchTopBooks()
            }
        case .isLoading:
            LoadingIndicator()
        case .loadedAll:
            if let results = topBooksVM.topBooks?.feed.results {
                bookListView(results)
            } else {
                Text("No results")
            }
        case .error(let message):
            Text(message).foregroundStyle(.red)
        }
    }
    
    
    @ViewBuilder
    private func bookListView(_ results: [TopBooksResult]) -> some View {
        List {
            Text("Updated at: \(topBooksVM.topBooks?.feed.updated ?? "Updated at: Unknown")")
                .font(.footnote)
                .font(.system(size: 10))
                .foregroundColor(Color.gray)
            
            ForEach(results, id: \.id) { book in
                Button(action: {
                    if let url = URL(string: book.url) {
                        selectedURL = IdentifiableURL(url: url)
                    }
                }) {
                    BookRowView(book: book)
                }
            }
        }
        .listStyle(.plain)
    }
    
    private struct BookRowView: View {
        let book: TopBooksResult
        
        var body: some View {
            HStack(alignment: .top) {
                ImageLoadingView(
                    urlString: book.artworkUrl100,
                    width: 60,
                    height: 60
                )
                VStack(alignment: .leading, spacing: 4) {
                    Text(book.name)
                        .font(.headline)
                        .font(.system(size: 10))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(book.genres) { genre in
                                Text(genre.name)
                                    .font(.footnote)
                                    .font(.system(size: 8))
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.gray.opacity(0.2))
                                    .foregroundColor(.primary)
                                    .cornerRadius(5)
                            }
                        }
                    }
                    
                    Text(book.artistName)
                        .font(.footnote)
                        .font(.system(size: 8))
                }
            }
        }
    }
}

private struct TopAudioBooksView: View {
    @StateObject private var topAudioBooksVM = TopAudioBooksViewModel()
    @State private var selectedURL: IdentifiableURL? = nil
    
    var body: some View {
        topAudioBooksView()
            .sheet(item: $selectedURL) { identifiable in
                SafariView(url: identifiable.url)
            }
    }
    
    private func topAudioBooksView() -> some View {
        switch topAudioBooksVM.state {
        case .start:
            return AnyView(
                Color.clear
                    .onAppear {
                        topAudioBooksVM.fetchTopAudioBooks()
                    }
            )
        case .isLoading:
            return AnyView(
                LoadingIndicator()
            )
        case .loadedAll:
            return AnyView(
                List {
                    ForEach(topAudioBooksVM.topAudioBooks!.feed.results) { book in
                        Button(action: {
                            if let url = URL(string: book.url) {
                                selectedURL = IdentifiableURL(url: url)
                            }
                        }) {
                            HStack {
                                ImageLoadingView(
                                    urlString: book.artworkUrl100,
                                    width: 60,
                                    height: 60
                                )
                                VStack(alignment: .leading) {
                                    Text(book.name)
                                        .font(.headline)
                                        .font(.system(size: 9))
                                    
                                    Text("Release Date: \(book.releaseDate)")
                                        .font(.footnote)
                                        .foregroundColor(.gray.opacity(0.8))
                                        .font(.system(size: 8))
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(book.genres) { genre in
                                                Text(genre.name)
                                                    .font(.footnote)
                                                    .font(.system(size: 8))
                                                    .padding(.horizontal, 6)
                                                    .padding(.vertical, 2)
                                                    .background(Color.gray.opacity(0.2))
                                                    .foregroundColor(.primary)
                                                    .cornerRadius(5)
                                            }
                                        }
                                    }
                                    
                                    Text(book.artistName)
                                        .font(.footnote)
                                        .font(.system(size: 8))
                                }
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
}

private struct LoadingIndicator: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 100)
            ProgressView()
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity)
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
                        .font(.system(size: 14))
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
