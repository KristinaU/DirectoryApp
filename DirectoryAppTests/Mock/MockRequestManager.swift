//
//  MockRequestManager.swift
//  DirectoryAppTests
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation
@testable import DirectoryApp

class MockRequestManager: RequestManagerProtocol {
    
    var requestType: Request?  
    
    func perform<T>(_ request: RequestProtocol, type: T.Type) async throws -> [T] where T : Decodable {
      
        if requestType == .people {
            return People.mockData() as! [T]
        }
        
        else if requestType == .room {
            return Room.mockData() as! [T]
        }
        else {
            throw NetworkError.invalidURL
        }
    }
    
    func getImage(url: URL) async throws -> Data {
        if url.absoluteString == "valid" {
            return Data()
        }
        throw NetworkError.invalidServerResponse
    }
}

extension People {
    static func mockData() -> [PeopleResponce] {
        return [PeopleResponce(firstName: "Maggie", avatar:"www.test.com", lastName:"les", email:"maggie.les@test.com", jobTitle:
                        "cpac")]
    }
}

extension Room {
    static func mockData()-> [RoomsResponce] {
        return [RoomsResponce(createdAt: "", isOccupied:true, maxOccupancy: 100, id: "11")]
    }
}
