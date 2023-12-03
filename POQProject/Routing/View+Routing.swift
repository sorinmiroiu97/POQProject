//
//  View+Routing.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import SwiftUI

struct RoutedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:
                    HomeView(viewModel: .init())
                case .repo(let repo):
                    RepoDetailView(repo: repo)
                }
            }
    }
}

extension View {
    func routedNavigation() -> some View {
        modifier(RoutedViewModifier())
    }
}
