//
//  MovieSearchView.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import SwiftUI

struct MovieSearchView: View {
    
    @StateObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        
        NavigationStack {
            Group {
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    MovieListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Movies")
        }
        
    }
}

#Preview {
    MovieSearchView()
}
