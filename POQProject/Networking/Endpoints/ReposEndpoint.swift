//
//  ReposEndpoint.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation

enum ReposEndpoint: Endpoint {
    case repos

    var route: String {
        switch self {
        case .repos:
            return "/repos"
        }
    }
}
