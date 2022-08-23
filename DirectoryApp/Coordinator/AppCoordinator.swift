//
//  AppCoordinator.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
    func navigateToPeople()
    func navigateToRooms()
}

final class AppCoordinator: Coordinator {
    private var navController: UINavigationController

    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let homeViewController = HomeViewController(homeViewModel: HomeViewModel(), coordinator: self)
         navController.viewControllers = [homeViewController]
    }
        
    func navigateToPeople() {
        
        let requestManager = RequestManager()
        let peopleViewModel = PeopleViewModel(requestManager: requestManager, coordinator: self)
        
        let peopleVC = PeopleViewController(viewModel: peopleViewModel)
        
        navController.pushViewController(peopleVC, animated: false)
        }
    
    func navigateToRooms() {
        
        let requestManager = RequestManager()
        let roomsViewModel = RoomsViewModel(requestManager: requestManager, coordinator: self)
        
        let roomsVC = RoomsViewController(viewModel: roomsViewModel)
                
        navController.pushViewController(roomsVC, animated: false)
    }

}
