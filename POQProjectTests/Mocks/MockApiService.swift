//
//  MockApiService.swift
//  POQProjectTests
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation
import Combine
@testable import POQProject

final class MockApiService<Model: Codable>: NetworkInitiable {

    private let result: Result<Model?, ApiError>

    required init(result: Result<Model?, ApiError>) {
        self.result = result
    }

    func perform<T: Codable>(request: URLRequest) async throws -> T {
        switch result {
        case .success(let success):
            if let model = success as? T {
                return model
            } else {
                throw ApiError.unknown
            }
        case .failure(let failure):
            throw failure
        }
    }

    func requestPublisher<T: Codable>(with request: URLRequest) -> AnyPublisher<T, ApiError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.unknown))
                return
            }
            switch self.result {
            case .failure(let error):
                promise(.failure(error))
            case .success(let model):
                if let model = model as? T {
                    promise(.success(model))
                } else {
                    promise(.failure(.unknown))
                }
            }
        }.eraseToAnyPublisher()
    }
}

