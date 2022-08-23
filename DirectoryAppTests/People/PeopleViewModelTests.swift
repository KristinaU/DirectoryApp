//
//  PeopleViewModelTests.swift
//  DirectoryAppTests
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import XCTest
@testable import DirectoryApp

class PeopleViewModelTests: XCTestCase {

    var viewModel:PeopleViewModel!
    let requestManager = MockRequestManager()

    override func setUpWithError() throws {
       
        let coordinator =  AppCoordinator(navController: UINavigationController())
            
        viewModel = PeopleViewModel(requestManager: requestManager, coordinator: coordinator)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    // get People success
    func testWhenGetPeopleIsSuccess() async {
        
        requestManager.requestType = .people
       await viewModel.getPeople()
    
        XCTAssertEqual(viewModel.state, .showPeopleView)
    }
    
    
    // getPeople Failed
    func testWhenGetPeopleIsFailed() async {

        // When
         await viewModel.getPeople()

        XCTAssertEqual(viewModel.state, .showError(NetworkError.invalidURL.localizedDescription))
    }
    
    
    // get downLoad image success
    func testGetPeopleAvatarIsSuccess() async {
        
        await viewModel.getPeople()
        
        // When
         viewModel.getPeopleImage(for:0, completion: { imageData in
            // Then
            XCTAssertNotNil(imageData)
        })
    }
    
    
    // get downLoad image failed
    func testGetPeopleAvatarIsFailure() async {

         viewModel.getPeopleImage(for:0, completion: { imageData in
            // Then
            XCTAssertNil(imageData)
        })
    }

}
