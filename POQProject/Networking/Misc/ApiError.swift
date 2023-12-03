//
//  ApiError.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation

enum ApiError: Swift.Error {
    case error(error: Error)
    case message(message: String)
    case invalidResponse(code: Int?)
    case sessionInvalid
    case invalidUrl
    case invalidRequest
    case unknown

    var errorMessage: String {
        switch self {
        case .error(error: let error):
            return error.localizedDescription
        case .message(message: let message):
            return message
        case .invalidResponse(let code):
            let codeString: String
            if let code {
                codeString = " - \(code)"
            } else {
                codeString = "N/A"
            }
            return "Invalid response" + codeString
        case .sessionInvalid:
            return "Session invalid"
        case .invalidUrl:
            return "Invalid URL"
        case .invalidRequest:
            return "Invalid URL Request"
        case .unknown:
            return "Unknown error"
        }
    }
}

extension Swift.Error {
    var apiErrorMessage: String {
        if let apiError = self as? ApiError {
            return apiError.errorMessage
        } else {
            return "Unknown error: " + self.localizedDescription
        }
    }
}
