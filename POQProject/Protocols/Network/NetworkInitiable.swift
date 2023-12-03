//
//  NetworkInitiable.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation
import Combine

protocol NetworkInitiable: AnyObject {
    // we could even have a "classic" request function with a callback here

    func perform<T: Codable>(request: URLRequest) async throws -> T
    func requestPublisher<T: Codable>(with request: URLRequest) -> AnyPublisher<T, ApiError>
}
