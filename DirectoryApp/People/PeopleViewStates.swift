//
//  PeopleViewStates.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.

import Foundation

enum PeopleViewStates: Equatable {
    case showActivityIndicator
    case showPeopleView
    case showError(String)
    case none
}
