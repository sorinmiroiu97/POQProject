//
//  HomeViewModel.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Combine

final class HomeViewModel: ObservableObject, ViewModelInitiable, ViewModelCancellable {
    typealias ModelObject = Any?

    private(set) var cancellables = Set<AnyCancellable>()

    @Published private(set) var repos: [Repo] = []
    @Published private(set) var apiError: ApiError?

    private let apiService: any NetworkInitiable

    required init(model: Any? = nil,
                  apiService: any NetworkInitiable = ApiService.shared) {
        self.apiService = apiService
    }

    @MainActor
    func fetchRepos() async throws {
        let repos: [Repo] = try await ReposEndpoint.repos.request(with: apiService)
        self.repos = repos
    }

    // example for the fetch using 
    // the publisher request function
    func fetchRepos() {
        ReposEndpoint.repos.request(with: apiService)
            .sink { [weak self] completion in
                guard let self else {
                    return
                }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.apiError = error
                    debugPrint(error.errorMessage)
                }
            } receiveValue: { [weak self] (repos: [Repo]) in
                guard let self else {
                    return
                }
                self.repos = repos
            }
            .store(in: &cancellables)
    }

    func clearRepos() {
        repos = []
    }
}
