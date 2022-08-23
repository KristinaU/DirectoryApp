//
//  RoomsViewModel.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation
import Combine

protocol RoomsViewModelInput {
    func getRooms() async
}

protocol RoomsViewModelOutput {
      var state: RoomsViewStates {get}
      var numberOfRooms: Int {get}
    func getRooms(for index: Int)-> Room
}

final class RoomsViewModel {
    
    private var requestManager: RequestManagerProtocol

    private var roomRecords: [Room] = []
 
    private weak var coordinator: Coordinator?

    @Published  var state: RoomsViewStates = .none
    
    private var cancellables:Set<AnyCancellable> = Set()
    
    init(requestManager: RequestManagerProtocol,
         coordinator: Coordinator) {
        self.requestManager = requestManager
        self.coordinator = coordinator
    }
}

extension RoomsViewModel: RoomsViewModelOutput {
    var numberOfRooms: Int {
        return roomRecords.count
    }
    
    func getRooms(for index: Int) -> Room {
        return roomRecords[index]
    }
    
}
extension RoomsViewModel: RoomsViewModelInput {
    func getRooms() async {
        state = .showActivityIndicator
        do {
            let roomsResponse =   try await requestManager.perform(Request.room, type: RoomsResponce.self)
            
        roomRecords = roomsResponse.map { $0.toDomain()}

            state = .showRoomsView
        } catch {
            state = .showError((error as! NetworkError).localizedDescription)
        }
    }
}

