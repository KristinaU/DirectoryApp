//
//  CoordinatorType.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation
import UIKit

protocol CoordinatorType: AnyObject {
    var navController: UINavigationController { get set }
    func start()
}
