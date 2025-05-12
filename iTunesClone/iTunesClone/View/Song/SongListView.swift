//
//  SongListView.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import SwiftUI

struct SongListView: View {
    @ObservedObject var viewModel: SongListViewModel
    
    var body: some View {
        
        List {
            
            ForEach (viewModel.songs) { song in
                
                NavigationLink {
                    SongDetailView(song: song)
                } label: {
                    SongRowView(song: song)
                }
                .buttonStyle(.plain)
                
            }
            
            switch viewModel.state {
            case .start:
                Color.clear
                    .onAppear {
                        viewModel.loadMore()
                    }
            case .isLoading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
            case .loadedAll:
                EmptyView()
            case .error(let message):
                Text(message)
                    .foregroundStyle(.red)
            }
            
        }
        .listStyle(.plain)
        
    }
}

#Preview {
    NavigationView {
        SongListView(viewModel: SongListViewModel.example())
    }
}
