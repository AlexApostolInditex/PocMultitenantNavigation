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
    static func updateUserState(to state: UserIdentity)
    static func getUserState() -> UserIdentity
}


public final class StateRepository: StateRepositoryProtocol {
    private static var userState: UserIdentity = .guest

    public static func updateUserState(to state: UserIdentity) {
        userState = state
    }

    public static func getUserState() -> UserIdentity {
        userState
    }
}
