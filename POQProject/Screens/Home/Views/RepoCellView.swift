//
//  RepoCellView.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import SwiftUI

struct RepoCellView: View {
    let repo: Repo

    var body: some View {
        content
    }

    private var content: some View {
        infoView
            .padding()
    }

    private var infoView: some View {
        VStack {
            Unwrap(repo.name) { repoName in
                Text(repoName)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            Unwrap(repo.description) { description in
                Text(description)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    RepoCellView(repo: Repo.dummy)
}
