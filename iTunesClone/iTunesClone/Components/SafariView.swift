//
//  SafariView.swift
//  iTunesClone
//
//  Created by chuanpham on 13/5/25.
//

import SwiftUI
import SafariServices

struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No update needed for now
    }
}
