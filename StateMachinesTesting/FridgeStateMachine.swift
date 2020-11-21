//
//  FridgeStateMachine.swift
//  StateMachinesTesting
//
//  Created by Viacheslav Volodko on 14.11.2020.
//

import Foundation

class FridgeStateMachine {
    enum State {
        case cooling
        case waiting
    }

    enum Event {
        case minTemperatureReached
        case maxTemperatureReached
    }

    fileprivate(set) var state: State = .cooling

    func transition(with event: Event) {
        switch (state, event) {
            case (.cooling, .minTemperatureReached):
                state = .waiting
            case (.cooling, .maxTemperatureReached):
                break

            case (.waiting, .maxTemperatureReached):
                state = .cooling
            case (.waiting, .minTemperatureReached):
                break
        }
    }
}

extension FridgeStateMachine {
    convenience init(initialState: State) {
        self.init()
        self.state = state
    }
}
