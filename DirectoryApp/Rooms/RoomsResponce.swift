//
//  RoomsResponseDTO.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 18/07/22.
//

import Foundation

struct RoomsResponce: Decodable {
    var createdAt: String
    var isOccupied: Bool
    var maxOccupancy: Int
    var id: String
}

// MARK: - Mappings to Domain

extension RoomsResponce {
    func toDomain() -> Room {
        return Room(createdAt:createdAt, occupiedMessage: isOccupied ? "Occupied" :"Not Occupied", maxOccupancy: maxOccupancy, id: id)
    }
}
