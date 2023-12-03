//
//  Notification+Publisher.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import SwiftUI

extension View {
    func onNotification(_ notificationName: Notification.Name,
                        perform action: @escaping (Notification) -> Void) -> some View {
        onReceive(
            NotificationCenter.default
                .publisher(for: notificationName)
                .receive(on: DispatchQueue.main)
        ) { (notification: Notification) in
            action(notification)
        }
    }

    #if os(iOS) || os(tvOS)
    func onAppEnteredBackground(perform action: @escaping (Notification) -> Void) -> some View {
        onNotification(
            UIScene.didEnterBackgroundNotification,
            perform: action
        )
    }

    func onAppWillEnterForeground(perform action: @escaping (Notification) -> Void) -> some View {
        onNotification(
            UIScene.willEnterForegroundNotification,
            perform: action
        )
    }
    #endif
}

//example usage
/*
struct TestView: View {

    @State private var isLoading = true

    var body: some View {
        Group {
            // ...
        }
        .onNotification(Notification.Name.token) { (notification: Notification) in
            isLoading = true
        }
        .onAppWillEnterForeground { _ in
            isLoading = false
        }
        .onAppEnteredBackground { _ in
            isLoading = false
        }
    }
}
*/
