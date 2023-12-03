//
//  POQProjectApp.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import SwiftUI

@main
struct POQProjectApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var routerStore = RouterStore()

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: .init())
                .environmentObject(routerStore)
        }
        .onChange(of: scenePhase) { scene in
            debugPrint("Transitioned to \(scene)")
        }
        // ios 17.0 api
//        .onChange(of: scenePhase) { oldScene, newScene in
//            debugPrint("Transitioned from \(oldScene) to \(newScene)")
//        }
    }
}
