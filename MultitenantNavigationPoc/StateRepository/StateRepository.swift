//
//  StateRepository.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import Foundation
import Combine

public enum UserIdentity {
    case guest
    case user
}

public protocol StateRepositoryProtocol {
    static func updateUserState(to state: UserIdentity)
    static func getUserState() -> UserIdentity
    static var userStateSignal: PassthroughSubject<UserIdentity, Never> { get }
}


public final class StateRepository: StateRepositoryProtocol {
    public static var userStateSignal = PassthroughSubject<UserIdentity, Never>()

    private static var userState: UserIdentity = .guest

    public static func updateUserState(to state: UserIdentity) {
        userState = state
        userStateSignal.send(userState)
    }

    public static func getUserState() -> UserIdentity {
        userState
    }
}
