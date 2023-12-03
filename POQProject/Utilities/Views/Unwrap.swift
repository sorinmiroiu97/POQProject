//
//  Unwrap.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import SwiftUI

struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    init(_ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }

    var body: some View {
        value.map(contentProvider)
    }
}

struct Unwrap_Previews: PreviewProvider {
    static let nonNilMessage: String? = "non nil text"
    static let nilMessage: String? = nil

    static var previews: some View {
        VStack {
            Unwrap(nonNilMessage) { message in
                Text(message)
            }
            Unwrap(nilMessage) { message in
                Text(message)
            }
        }
    }
}
