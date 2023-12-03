//
//  ApiHelper.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation

struct ApiHelper {
    // TODO: move the RequestHeader enum into the constants file
    private enum RequestHeader {
        static let deviceId = "Device-Id"
        static let apiAccessToken = "Token"
        // device info headers
        static let appVersion = "App-Version"
        static let appBuild = "App-Build"
        static let deviceType = "Device-Type"
        static let deviceOS = "Device-Os"
        static let apiVersion = "Api-Version"
        // generic http headers
        static let accept = "Accept"
    }

    private init() {
        // empty implementation
    }

    enum ApiEnvironment {
        case dev
        case live

        static var environment: ApiEnvironment {
            #if DEBUG
            return .dev
            #else
            return .live
            #endif
        }
    }

    static var baseUrlPath: String {
        switch ApiEnvironment.environment {
        case .dev,
                .live:
            return "https://api.github.com"
        }
    }

    static var apiRoute: String {
        switch ApiEnvironment.environment {
        case .dev,
                .live:
            return "/orgs/square"
        }
    }

    static var headers: [String: String?] {
        return [
            RequestHeader.accept: "*/*",
        ]
    }

    static func setHeaders(to urlRequest: inout URLRequest) {
        let apiHeader = ApiHelper.headers
//        let deviceDict = DeviceInfo.makeInfoHeader()
//        let headers = apiHeader.merging(deviceDict) { $1 }
        let headers = apiHeader
        headers.forEach { args in
            let (key, value) = args
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}
