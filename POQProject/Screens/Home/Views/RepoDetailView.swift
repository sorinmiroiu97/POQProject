//
//  RepoDetailView.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import SwiftUI

struct RepoDetailView: View {
    let repo: Repo

    var body: some View {
        content
            .navigationTitle(repo.name ?? "Repo detail")
    }

    private var content: some View {
        ScrollView(showsIndicators: false) {
            repoMainInfoView
            repoUrl
        }
        .padding()
    }

    private var repoMainInfoView: some View {
        VStack {
            RepoCellView(repo: repo)
        }
    }

    @ViewBuilder
    private var repoUrl: some View {
        if let urlPath = repo.url,
           let url = URL(string: urlPath) {
            HStack {
                Image(systemName: "link.circle.fill")
                    .font(.largeTitle)
                Link("Repo url", destination: url)
                    .font(.title)
                Spacer()
            }
        }
    }
}

#Preview {
    RepoDetailView(repo: Repo.dummy)
}
