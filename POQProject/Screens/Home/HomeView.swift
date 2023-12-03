//
//  HomeView.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import SwiftUI

struct HomeView: View, ViewInitiable {
    typealias ViewModel = HomeViewModel

    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject private var router: RouterStore

    @State private var isLoading = false
    @State private var apiError: ApiError?

    var body: some View {
        NavigationStack(path: $router.navPath) {
            content
                .navigationTitle("Home")
                .routedNavigation()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.clearRepos()
                        } label: {
                            Text("Clear repos")
                        }
                    }
                }
        }
    }

    private var content: some View {
        ZStack {
            ScrollView {
                headerView
                errorView
                reposList
            }
            loadingView
        }
    }

    @ViewBuilder
    private var loadingView: some View {
        if isLoading {
            ProgressView()
        }
    }

    private var headerView: some View {
        Section {
            VStack {
                HStack {
                    Text("Repos")
                        .font(.title)
                    Spacer()
                    fetchButton
                }
                if viewModel.repos.isEmpty {
                    Text("Hit the fetch button to get started!")
                }
            }
            .padding()
        }
    }

    private var fetchButton: some View {
        Button {
            Task {
                await fetchRepos()
            }
        } label: {
            Text("Fetch repos")
        }
    }

    @ViewBuilder
    private var errorView: some View {
        if let apiError {
            Section("Error") {
                Text("There was a network error")
                Text(apiError.errorMessage)
            }
        }
    }

    private var reposList: some View {
        ForEach(viewModel.repos) { repo in
            NavigationLink(value: Route.repo(repo)) {
                RepoCellView(repo: repo)
            }
        }
    }

    private func fetchRepos() async {
        isLoading = true
        do {
            try await viewModel.fetchRepos()
        } catch {
            debugPrint("error -> \(error.apiErrorMessage)")
            apiError = error as? ApiError ?? .unknown
        }
        isLoading = false
    }
}

#Preview {
    HomeView(viewModel: .init())
}
