//
//  HttpMethod.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Encoding {
    case URL
    case JSON
}
