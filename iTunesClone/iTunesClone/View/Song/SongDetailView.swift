//
//  SongDetailView.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import SwiftUI

struct SongDetailView: View {
    
    let song: Song
    
    @StateObject var albumDetailSongListViewModel: AlbumDetailSongListViewModel
    @StateObject var albumForSongViewModel = AlbumForSongViewModel()
    
    init(song: Song) {
        self.song = song
        
        self._albumDetailSongListViewModel = StateObject(wrappedValue: AlbumDetailSongListViewModel(albumID: song.collectionID))
    }
    
    var body: some View {
        
        VStack {
            
            if let album = albumForSongViewModel.album {
                AlbumHeaderView(album: album)
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
            AlbumDetailSongListView(viewModel: albumDetailSongListViewModel,
                                    selectedSong: song)
            
        }
        .onAppear {
            albumDetailSongListViewModel.fetch()
            albumForSongViewModel.fetch(song: song)
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

#Preview {
    SongDetailView(song: Song.example())
}
