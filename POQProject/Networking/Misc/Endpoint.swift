//
//  Endpoint.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation
import Combine

typealias JSONDictionary = [String: Any]

protocol Endpoint {
    var baseUrlPath: String { get }
    var route: String { get }
    var urlParams: JSONDictionary? { get }
    var body: Data? { get throws }
    var httpMethod: HttpMethod { get }
    var encoding: Encoding { get }

    func request<T: Codable>(with service: any NetworkInitiable) async throws -> T
    func request<T: Codable>(with service: any NetworkInitiable) -> AnyPublisher<T, ApiError>
}

extension Endpoint {
    var baseUrlPath: String {
        ApiHelper.baseUrlPath + ApiHelper.apiRoute
    }

    var urlParams: JSONDictionary? {
        return nil
    }

    var body: Data? {
        get throws {
            return nil
        }
    }

    var httpMethod: HttpMethod {
        return .get
    }

    var encoding: Encoding {
        return .JSON
    }
}

extension Endpoint {
    func request<T: Codable>(with service: any NetworkInitiable = ApiService.shared) async throws -> T {
        var urlPath = baseUrlPath + route

        switch httpMethod {
        case .get:
            if let urlParams,
               !urlParams.isEmpty {
                urlPath.append(urlParams.queryString)
            }
        default:
            break
        }

        guard let url = URL(string: urlPath) else {
            throw ApiError.invalidUrl
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        ApiHelper.setHeaders(to: &urlRequest)

        switch httpMethod {
        case .post:
            do {
                urlRequest.httpBody = try body
            } catch {
                debugPrint("Endpoint.body throwable get - error: \(error)")
            }
        default:
            break
        }

        return try await service.perform(request: urlRequest)
    }

    func request<T: Codable>(with service: any NetworkInitiable = ApiService.shared) -> AnyPublisher<T, ApiError> {
        var urlPath = baseUrlPath + route

        switch httpMethod {
        case .get:
            if let urlParams,
               !urlParams.isEmpty {
                urlPath.append(urlParams.queryString)
            }
        default:
            break
        }

        guard let url = URL(string: urlPath) else {
            return Future { promise in
                promise(.failure(ApiError.invalidUrl))
            }
            .eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        ApiHelper.setHeaders(to: &urlRequest)

        switch httpMethod {
        case .post:
            do {
                urlRequest.httpBody = try body
            } catch {
                debugPrint("Endpoint.body throwable get - error: \(error)")
            }
        default:
            break
        }

        return service.requestPublisher(with: urlRequest)
    }
}
