//
//  SongSearchView.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import SwiftUI

struct SongSearchView: View {
    
    @StateObject private var viewModel = SongListViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            Group {
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    SongListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Songs")
            
        }
        
    }
}

#Preview {
    SongSearchView()
}
