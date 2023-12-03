//
//  Dictionary+URLQuery.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation

extension Dictionary {
    var queryString: String {
        var output = String(Constants.Char.questionMark)
        for (key, value) in self {
            output += "\(key)" + String(Constants.Char.equal) + "\(value)" + String(Constants.Char.and)
        }
        output = String(output.dropLast())
        return output.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? output
    }
}
