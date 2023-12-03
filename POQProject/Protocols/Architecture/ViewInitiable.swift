//
//  ViewInitiable.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation

protocol ViewInitiable<ViewModel> {
    associatedtype ViewModel: ObservableObject, ViewModelInitiable

    var viewModel: ViewModel { get }
}

/*
 // IF WE REALLY WANT TO EXPLICITLY ENFORCE THE USAGE
 // OF A VIEWMODEL IN A VIEW THEN WE CAN USE THIS PROTOCOL

 struct MyView: View, ViewInitiable {
    typealias ViewModel = MyViewModel

    // HERE WE CAN USE ON OF THE FOLLOWING DECLARATIONS
    // EITHER AS AN ENVIRONMENT OBJECT OR OBSERVED OBJECT
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject private(set) var viewModel = MyViewModel()

    var body ...
 }
 */
