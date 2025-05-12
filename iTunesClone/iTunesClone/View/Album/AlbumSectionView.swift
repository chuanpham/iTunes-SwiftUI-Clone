//
//  AlbumSectionView.swift
//  iTunesClone
//
//  Created by chuanpham on 12/5/25.
//

import SwiftUI

struct AlbumSectionView: View {
    
    let albums: [Album]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            LazyHStack(alignment: .top) {
                
                ForEach(albums) { album in
                    
                    NavigationLink {
                        AlbumDetailView(album: album)
                    } label: {
                        AlbumSectionCellView(album: album)
                    }
                    .buttonStyle(.plain)
                    
                }
                
            }
            .padding([.horizontal])
            
        }
        
    }
}

#Preview {
    NavigationView {
        AlbumSectionView(albums: [Album.example()])
    }
}
