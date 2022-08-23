//
//  RoomsViewModelTests.swift
//  DirectoryAppTests
//
//  Created by KRISTINA UROSOVA on 18/07/22.
//

import XCTest
@testable import DirectoryApp


class RoomsViewModelTests: XCTestCase {

    var viewModel:RoomsViewModel!
    let requestManager = MockRequestManager()

    override func setUpWithError() throws {
       
        let coordinator =  AppCoordinator(navController: UINavigationController())

        viewModel = RoomsViewModel(requestManager: requestManager, coordinator: coordinator)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    // get rooms success
    func testWhenGetRoomsIsSuccess() async {
    
        requestManager.requestType = .room
        await viewModel.getRooms()

        XCTAssertEqual(viewModel.state, .showRoomsView)
        
        let room = viewModel.getRooms(for: 0)

        XCTAssertEqual(room.maxOccupancy, 100)
        XCTAssertEqual(room.occupiedMessage, "Occupied")

    }
    
    
    // getRooms Failed
    func testWhenGetPeopleIsFailed() async {
    
         await viewModel.getRooms()

        XCTAssertEqual(viewModel.state, .showError(NetworkError.invalidURL.localizedDescription))
        
    }
}

