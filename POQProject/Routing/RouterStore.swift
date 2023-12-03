//
//  RouterStore.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Combine
import SwiftUI

enum MenuSelection: Int {
    case home // dashboard
    case detail
}

final class RouterStore: ObservableObject, Routable {
    @Published var navPath = NavigationPath()

    @Published var menuSelection: MenuSelection = .home

    func navigate(to route: Route) {
        navPath.append(route)
    }
}
