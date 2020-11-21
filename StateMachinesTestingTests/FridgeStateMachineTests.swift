//
//  StateMachinesTestingTests.swift
//  StateMachinesTestingTests
//
//  Created by Viacheslav Volodko on 14.11.2020.
//

import XCTest
@testable import StateMachinesTesting

class FridgeStateMachineTests: XCTestCase {
    func testTransitions() {
        var sut = FridgeStateMachine(initialState: .waiting)
        sut.transition(with: .maxTemperatureReached)
        XCTAssertEqual(sut.state, .cooling)

        sut = FridgeStateMachine(initialState: .waiting)
        sut.transition(with: .minTemperatureReached)
        XCTAssertEqual(sut.state, .waiting)

        sut = FridgeStateMachine(initialState: .cooling)
        sut.transition(with: .maxTemperatureReached)
        XCTAssertEqual(sut.state, .cooling)

        sut = FridgeStateMachine(initialState: .cooling)
        sut.transition(with: .minTemperatureReached)
        XCTAssertEqual(sut.state, .waiting)
    }
}
