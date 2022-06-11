// Copyright © 2022 xDesign. All rights reserved.

import ComposableArchitecture
import SwiftUI

@dynamicMemberLookup
struct SharedComposableState<State: Equatable>: Equatable {
    var path: NavigationPath
    var state: State

    subscript<Dependency>(dynamicMember keyPath: WritableKeyPath<State, Dependency>) -> Dependency {
        get { self.state[keyPath: keyPath] }
        set { self.state[keyPath: keyPath] = newValue }
    }

    static func live(state: State) -> Self {
        Self(path: .init(), state: state)
    }

    func map<NewState>(_ transform: @escaping (State) -> NewState) -> SharedComposableState<NewState> {
        .init(path: self.path, state: transform(self.state))
    }
}

struct ComposableState: Equatable {
    var childState: ComposableChildState?
    enum Routes: Hashable {
        case child
    }
}

enum ComposableAction {
    case navigateToChild
    case updatePath(NavigationPath)
}

struct ComposableEnvironment {}

let composableReducer = Reducer<SharedComposableState<ComposableState>, ComposableAction, ComposableEnvironment>
    .init { state, action, env in
        switch action {
        case .navigateToChild:
            state.path.append(ComposableState.Routes.child)
            state.childState = .init(text: "Child State")
        case let .updatePath(newPath):
            state.path = newPath
        }
        return .none
    }

struct ComposableView: View {
    let store: Store<SharedComposableState<ComposableState>, ComposableAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationStack(path: viewStore.binding(get: \.path, send: { .updatePath($0) })) {
                Button("Go to child") {
                    viewStore.send(.navigateToChild)
                }
                .navigationDestination(for: ComposableState.Routes.self) { route in
                    switch route {
                    case .child:
                        IfLetStore(store.scope(state: \.childState)) { store in
                            ComposableChildView(store: store)
                        }
                    }
                }
            }
        }
    }
}

struct ComposableChildView: View {
    let store: Store<ComposableChildState, ComposableAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Text(viewStore.text)
        }
    }
}

struct ComposableChildState: Equatable {
    let text: String
}
