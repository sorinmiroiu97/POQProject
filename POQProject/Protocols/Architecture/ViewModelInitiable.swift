//
//  ViewModelInitiable.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Combine

protocol ViewModelInitiable<ModelObject>: AnyObject {
    associatedtype ModelObject

    init(model: ModelObject, apiService: any NetworkInitiable)
}

/*
 final class MyViewModel: ObservableObject, ViewModelInitiable {
     typealias ModelObject = Any?

     required init(model: Any? = nil,
                   apiService: any NetworkInitiable = ApiService.shared) {
        // init code
     }
 }
*/

protocol ViewModelCancellable: AnyObject {
    var cancellables: Set<AnyCancellable> { get }
}

/*
 final class MyViewModel: ObservableObject, ViewModelCancellable {
    private(set) var cancellables: Set<AnyCancellable> = []
 }
 */
