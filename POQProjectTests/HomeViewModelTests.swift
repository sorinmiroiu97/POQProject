//
//  HomeViewModelTests.swift
//  POQProjectTests
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import XCTest
import Combine
@testable import POQProject

final class HomeViewModelTests: XCTestCase {

    private var viewModel: HomeViewModel?
    private var cancellables = Set<AnyCancellable>()

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        cancellables = []
    }

    func testReposFetchSuccessful() async throws {
        let result: Result<[Repo]?, ApiError> = .success([Repo.dummy])
        viewModel = .init(apiService: MockApiService(result: result))
        let unwrappedViewModel = try XCTUnwrap(viewModel, "ViewModel should be initialised at this point!")
        try await unwrappedViewModel.fetchRepos()
        XCTAssertFalse(unwrappedViewModel.repos.isEmpty)
        XCTAssertEqual(unwrappedViewModel.repos.first, Repo.dummy)
    }

    func testEmptyReposFetchSuccessful() async throws {
        let result: Result<[Repo]?, ApiError> = .success([])
        viewModel = .init(apiService: MockApiService(result: result))
        let unwrappedViewModel = try XCTUnwrap(viewModel, "ViewModel should be initialised at this point!")
        try await unwrappedViewModel.fetchRepos()
        XCTAssert(unwrappedViewModel.repos.isEmpty)
    }

    func testReposFetchFailure() async throws {
        let result: Result<[Repo]?, ApiError> = .failure(.unknown)
        viewModel = .init(apiService: MockApiService(result: result))
        let unwrappedViewModel = try XCTUnwrap(viewModel, "ViewModel should be initialised at this point!")
        do {
            try await unwrappedViewModel.fetchRepos()
        } catch {
            XCTAssert(unwrappedViewModel.repos.isEmpty)
            XCTAssertNotNil(error as? ApiError)
            XCTAssertEqual((error as? ApiError)?.errorMessage, ApiError.unknown.errorMessage)
        }
    }

    func testReposPublisherFetchSuccessful() throws {
        let result: Result<[Repo]?, ApiError> = .success([Repo.dummy])
        viewModel = .init(apiService: MockApiService(result: result))
        let unwrappedViewModel = try XCTUnwrap(viewModel, "ViewModel should be initialised at this point!")
        
        unwrappedViewModel.fetchRepos()

        let publisher = unwrappedViewModel.$repos
        let exp = expectationFrom(publisher: publisher,
                                  cancellables: &cancellables) { (output: [Repo]?) in
            XCTAssertNotNil(output)
            XCTAssertEqual(output?.first, Repo.dummy)
            XCTAssertFalse(unwrappedViewModel.repos.isEmpty)
        }

        wait(for: [exp], timeout: 0.5)
    }

    func testEmptyReposPublisherFetchSuccessful() throws {
        let result: Result<[Repo]?, ApiError> = .success([])
        viewModel = .init(apiService: MockApiService(result: result))
        let unwrappedViewModel = try XCTUnwrap(viewModel, "ViewModel should be initialised at this point!")
        unwrappedViewModel.fetchRepos()

        let publisher = unwrappedViewModel.$repos
        let exp = expectationFrom(publisher: publisher,
                                  cancellables: &cancellables) { (output: [Repo]?) in
            XCTAssertNotNil(output)
            XCTAssert(unwrappedViewModel.repos.isEmpty)
        }

        wait(for: [exp], timeout: 0.5)
    }

    func testReposPublisherFetchFailure() throws {
        let result: Result<[Repo]?, ApiError> = .failure(.unknown)
        viewModel = .init(apiService: MockApiService(result: result))
        let unwrappedViewModel = try XCTUnwrap(viewModel, "ViewModel should be initialised at this point!")
        unwrappedViewModel.fetchRepos()

        let publisher = unwrappedViewModel.$apiError

        let exp = expectationFrom(publisher: publisher,
                                  cancellables: &cancellables) { output in
            XCTAssert(unwrappedViewModel.repos.isEmpty)
            XCTAssertNotNil(output)
            XCTAssertEqual(output?.errorMessage, ApiError.unknown.errorMessage)
        }

        wait(for: [exp], timeout: 0.5)
    }

    func testClearReposSuccessful() async throws {
        let result: Result<[Repo]?, ApiError> = .success([Repo.dummy])
        viewModel = .init(apiService: MockApiService(result: result))
        let unwrappedViewModel = try XCTUnwrap(viewModel, "ViewModel should be initialised at this point!")
        try await unwrappedViewModel.fetchRepos()
        unwrappedViewModel.clearRepos()
        XCTAssert(unwrappedViewModel.repos.isEmpty)
    }
}
