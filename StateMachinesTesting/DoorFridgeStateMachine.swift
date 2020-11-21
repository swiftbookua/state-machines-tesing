//
//  FridgeStateMachine.swift
//  StateMachinesTesting
//
//  Created by Viacheslav Volodko on 14.11.2020.
//

import Foundation

class DoorFridgeStateMachine {
    enum State: Equatable, CaseIterable {
        case cooling
        case waiting
    }

    enum Event: Equatable, CaseIterable {
        case minTemperatureReached
        case maxTemperatureReached
        case doorOpened
    }

    fileprivate(set) var state: State = .cooling
    init(initialState: State) {
        self.state = initialState
    }

    func transition(with event: Event) {
        switch (state, event) {
        case (.cooling, .minTemperatureReached):
            state = .waiting
        case (.cooling, .doorOpened):
            state = .waiting
        case (.cooling, .maxTemperatureReached):
            break

        case (.waiting, .maxTemperatureReached):
            state = .cooling
        case (.waiting, .minTemperatureReached),
             (.waiting, .doorOpened):
            break
        }
    }
}
