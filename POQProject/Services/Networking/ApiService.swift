//
//  ApiService.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation
import Combine

final class ApiService: NetworkInitiable, ObservableObject {
    static let shared = ApiService()

    private let sessionConfig: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        return config
    }()

    private init() {
        // empty implementation
    }

    func perform<T: Codable>(request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await URLSession(configuration: sessionConfig).data(for: request)
            return try decode(data: data, from: response, with: request)
        } catch {
            throw ApiError.error(error: error)
        }
    }

    func requestPublisher<T: Codable>(with request: URLRequest) -> AnyPublisher<T, ApiError> {
        URLSession(configuration: sessionConfig)
            .dataTaskPublisher(for: request)
            // since url sessions tasks run on the background thread
            // there's no need to explicitly subscribe on the background thread
            // .subscribe(on: DispatchQueue.global(qos: .background))
            .tryCompactMap { [weak self] arg in
                guard let self = self else {
                    throw ApiError.unknown
                }
                let (data, response) = arg
                return try self.decode(data: data, from: response, with: request)
            }
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                } else {
                    return ApiError.error(error: error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: Helper functions
extension ApiService {
    private func printRequest(_ request: URLRequest) {
        URLSession(configuration: sessionConfig).dataTask(with: request) { data, response, error in
            if let data {
                debugPrint(String(data: data, encoding: .utf8) ?? "empty response")
            }
            if let response = response as? HTTPURLResponse {
                debugPrint(response)
            }
            if let error {
                debugPrint(error)
            }
        }.resume()
    }

    private func decode<T: Codable>(data: Data,
                                    from response: URLResponse,
                                    with request: URLRequest) throws -> T {
        print(#function)
        debugPrint("API-DEBUG: request url path -> \(request.url?.absoluteString ?? "N/A")")
        debugPrint("API-DEBUG: request body -> \(makeJson(from: request.httpBody))")
        // debugPrint("API-DEBUG: request response -> \(String(data: data, encoding: .utf8) ?? "N/A")")
        let successStatusCodes = 200...299

        guard let httpResponse = response as? HTTPURLResponse,
              successStatusCodes.contains(httpResponse.statusCode) else {
            throw ApiError.invalidResponse(code: (response as? HTTPURLResponse)?.statusCode)
        }
        do {
            let codable = try JSONDecoder().decode(T.self, from: data)
            return codable
        } catch {
            debugPrint("Decoding error: \(error)")
            throw ApiError.error(error: error)
        }
    }

    private func makeJson(from body: Data?) -> String {
        if let body,
           let jsonString = String(data: body, encoding: .utf8) {
            return "\(jsonString as AnyObject)"
        }
        return "NIL"
    }
}
