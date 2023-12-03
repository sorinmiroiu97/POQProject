//
//  TestCase+Expectation.swift
//  POQProjectTests
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import XCTest
import Combine

extension XCTestCase {
    func expectationFrom<T: Publisher>(
        publisher: T?,
        cancellables: inout Set<AnyCancellable>,
        onReceiveValue: @escaping (T.Output) -> () = { _ in }
    ) -> XCTestExpectation where T.Failure == Never {
        let exp = expectation(description: "Expectation for publisher -> " + String(describing: publisher))

        publisher?.sink { (output: T.Output) in
            onReceiveValue(output)
            exp.fulfill()
        }.store(in: &cancellables)

        return exp
    }

    func expectationFrom<T: Publisher>(
        publisher: T?,
        cancellables: inout Set<AnyCancellable>,
        onReceiveCompletion: @escaping (Subscribers.Completion<T.Failure>) -> () = { _ in },
        onReceiveValue: @escaping (T.Output) -> () = { _ in }
    ) -> XCTestExpectation {
        let exp = expectation(description: "Expectation for publisher -> " + String(describing: publisher))

        publisher?
            .sink(receiveCompletion: { completion in
                onReceiveCompletion(completion)
                exp.fulfill()
            }, receiveValue: { output in
                onReceiveValue(output)
                exp.fulfill()
            })
            .store(in: &cancellables)

        return exp
    }
}
