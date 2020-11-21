//
//  DoorFridgeStateMachineTests.swift
//  StateMachinesTestingTests
//
//  Created by Viacheslav Volodko on 14.11.2020.
//

import XCTest
@testable import StateMachinesTesting

class DoorFridgeStateMachineTests: XCTestCase {
    func testTransitions() {
        struct TestCase: CustomStringConvertible, CustomDebugStringConvertible {
            var stateFrom: DoorFridgeStateMachine.State
            var event: DoorFridgeStateMachine.Event
            var extectedState: DoorFridgeStateMachine.State
            var file: StaticString
            var line: UInt

            init(
                stateFrom: DoorFridgeStateMachine.State,
                event: DoorFridgeStateMachine.Event,
                extectedState: DoorFridgeStateMachine.State,
                file: StaticString = #filePath,
                line: UInt = #line
            ) {
                self.stateFrom = stateFrom
                self.event = event
                self.extectedState = extectedState
                self.file = file
                self.line = line
            }

            static func generateAllCases() -> [TestCase] {
                var result: [TestCase] = []
                for stateFrom in DoorFridgeStateMachine.State.allCases {
                    for event in DoorFridgeStateMachine.Event.allCases {
                        let stateMachine = DoorFridgeStateMachine(initialState: stateFrom)
                        stateMachine.transition(with: event)
                        result.append(.init(stateFrom: stateFrom, event: event, extectedState: stateMachine.state))
                    }
                }
                return result
            }


            var debugDescription: String {
                return """
                TestCase(stateFrom: .\(stateFrom), event: .\(event), extectedState: .\(extectedState))
                """
            }

            static func generateAllCasesCode() -> String {
                return "[\n    " +
                    generateAllCases().map(\.debugDescription).joined(separator: ",\n    ") +
                "\n]"
            }


            var description: String {
                return "\(stateFrom) --\(event)--> \(extectedState);"
            }

            static func generateDocumentation() -> String {
                return "```mermaid\ngraph TB;\n" +
                    generateAllCases()
                    .filter { $0.stateFrom != $0.extectedState }
                    .map(\.description)
                    .joined(separator: "\n") +
                "\n```"
            }
        }

        let testCases: [TestCase] = [
            TestCase(stateFrom: .cooling, event: .minTemperatureReached, extectedState: .waiting),
            TestCase(stateFrom: .cooling, event: .maxTemperatureReached, extectedState: .cooling),
            TestCase(stateFrom: .cooling, event: .doorOpened, extectedState: .cooling),
            TestCase(stateFrom: .waiting, event: .minTemperatureReached, extectedState: .waiting),
            TestCase(stateFrom: .waiting, event: .maxTemperatureReached, extectedState: .cooling),
            TestCase(stateFrom: .waiting, event: .doorOpened, extectedState: .waiting)
        ]

        for testCase in testCases {
            let sut = DoorFridgeStateMachine(initialState: testCase.stateFrom)
            sut.transition(with: testCase.event)
            XCTAssertEqual(sut.state, testCase.extectedState, file: testCase.file, line: testCase.line)
        }

        print(TestCase.generateAllCasesCode())
        print(TestCase.generateDocumentation())
    }
}

