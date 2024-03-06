//
//  StateRepository.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation

public enum UserIdentity {
    case guest
    case user
}

public protocol StateRepositoryProtocol {
    func updateUserState(to state: UserIdentity)
    func getUserState() -> UserIdentity
}


public final class StateRepository: StateRepositoryProtocol {
    private var userState: UserIdentity = .guest

    public func updateUserState(to state: UserIdentity) {
        userState = state
    }

    public func getUserState() -> UserIdentity {
        userState
    }
}
