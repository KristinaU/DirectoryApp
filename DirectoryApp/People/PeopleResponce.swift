//
//  ImagesResponse.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation

// MARK: - PeopleResponce
struct PeopleResponce: Codable {
    
    var createdAt: String?
    var firstName: String?
    var avatar: String?
    var lastName: String?
    var email: String?
    var jobTitle: String?
    var favouriteColor: String?
    var id: String?
    
    enum CodingKeys: String, CodingKey{
        case createdAt,firstName,avatar,email,lastName,favouriteColor,id
        case jobTitle = "jobtitle"
    }
}

// MARK: - Mappings to Domain

extension PeopleResponce {
    func toDomain() -> People {
        return People(firstName: firstName ?? "", avatar: avatar ?? "", lastName: lastName ?? "", email: email ?? "", jobTitle: jobTitle ?? "", joinedDate: createdAt ?? "")
    }
}
