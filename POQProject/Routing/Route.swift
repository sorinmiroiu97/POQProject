//
//  Route.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case home
    case repo(Repo)
}

protocol Routable: AnyObject {
    var navPath: NavigationPath { get set }
    func navigate(to route: Route)
}
