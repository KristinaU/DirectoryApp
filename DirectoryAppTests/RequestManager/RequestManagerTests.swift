//
//  RequestManagerTests.swift
//  DirectoryAppTests
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import XCTest
@testable import DirectoryApp

class RequestManagerTests: XCTestCase {

    var requestManager: RequestManager!
    let mockApiManager = MockApiManager()
    override func setUpWithError() throws {
        requestManager = RequestManager(apiManager: mockApiManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Rooms
    func testPerformRoomApiSuccess() async {
        mockApiManager.enqueue(responsePath:"ValidRoomsResponse")
        let response =  try! await requestManager.perform(Request.room, type: RoomsResponce.self)
        
        XCTAssertEqual(response.count, 65)
    }
    
    func testPerformRoomApiInvalidRoomsResponse() async {
        mockApiManager.enqueue(responsePath:"InvalidRoomsResponse.")
        
        do {
            _ =  try await requestManager.perform(Request.room, type: RoomsResponce.self)
        }catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidServerResponse)

        }
    }
    
    func testPerformRoomApiEmptyRoomsResponse() async {
        mockApiManager.enqueue(responsePath:"EmptyRoomsResponse")
        let response =  try! await requestManager.perform(Request.room, type: RoomsResponce.self)
        
        XCTAssertEqual(response.count, 0)
    }
   
    // People
    
    func testPerformPeopleApiSuccess() async {
        mockApiManager.enqueue(responsePath:"ValidPeopleResponse")
        let response =  try! await requestManager.perform(Request.room, type: PeopleResponce.self)
        
        XCTAssertEqual(response.count, 69)
    }
    
    func testPerformPeopleApiInvalidPeopleResponse() async {
        mockApiManager.enqueue(responsePath:"InvalidPeopleResponse")
        
        do {
            _ =  try await requestManager.perform(Request.room, type: PeopleResponce.self)
        }catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.jsonParsingFailed)

        }
    }
    
    func testPerformPeopleApiEmptyPeopleResponse() async {
        mockApiManager.enqueue(responsePath:"EmptyPeopleResponse")
        let response =  try! await requestManager.perform(Request.room, type: PeopleResponce.self)
        
        XCTAssertEqual(response.count, 0)
    }
   
}
