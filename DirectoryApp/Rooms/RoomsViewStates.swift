//
//  RoomsViewStates.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation

enum RoomsViewStates: Equatable {
    case showActivityIndicator
    case showRoomsView
    case showError(String)
    case none
}
