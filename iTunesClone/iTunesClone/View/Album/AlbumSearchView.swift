//
//  AlbumSearchView.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import SwiftUI

struct AlbumSearchView: View {
    
    @StateObject var viewModel = AlbumListViewModel()
    
    var body: some View {
        
        NavigationStack {
            Group {
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    AlbumListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
        
    }
    
}

#Preview {
    AlbumSearchView()
}
