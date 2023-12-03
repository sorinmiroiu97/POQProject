//
//  Colors.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import SwiftUI

enum Colors {
    case accentColor
    case background
    case blue

    var name: String {
        switch self {
        case .accentColor:
            return "AccentColor"
        case .background:
            return "background"
        case .blue:
            return "blue"
        }
    }

    var color: Color {
        Color(name)
    }
}
