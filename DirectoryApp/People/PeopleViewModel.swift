//
//  PeopleViewModel.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import Foundation
import Combine

protocol PeopleViewModelAction {
    func navigateToDetails(for index:Int)
}

protocol PeopleViewModelInput {
    func getPeople() async
    func getPeopleImage(for index: Int, completion:@escaping (Data) -> Void) 
}

protocol PeopleViewModelOutput {
    var state: PeopleViewStates {get}
    var numberOfPeople:Int {get}
    func getPeople(for index: Int)-> People
}

final class PeopleViewModel {
    
    private var requestManager: RequestManagerProtocol

    private var peopleRecords: [People] = []
 
    private weak var coordinator: Coordinator?

    @Published  var state: PeopleViewStates = .none
    
    private var cancellables:Set<AnyCancellable> = Set()
    
    init(requestManager: RequestManagerProtocol,
         coordinator: AppCoordinator) {
        self.requestManager = requestManager
        self.coordinator = coordinator
    }
}

extension PeopleViewModel: PeopleViewModelAction {
    func navigateToDetails(for index: Int) {
         
    }
}

extension PeopleViewModel: PeopleViewModelOutput {
    var numberOfPeople:Int {
        return peopleRecords.count
    }
    
    func getPeople(for index: Int)-> People {
        return peopleRecords[index]
    }
}

extension PeopleViewModel: PeopleViewModelInput {
    
    func getPeopleImage(for index: Int, completion:@escaping (Data) -> Void)  {
        
        if index >= peopleRecords.count {
            return 
        }
        let urlStr = peopleRecords[index].avatar
        if let imageData = ImageManager.shared.getImage(url: urlStr) {
            DispatchQueue.main.async {
                completion(imageData)
            }
        } else {
            guard let url = URL(string: urlStr) else { return }
            Task {
                do {
                    let imageData =  try await requestManager.getImage(url: url)

                    ImageManager.shared.saveImage(url: urlStr, data: imageData)
                    DispatchQueue.main.async {
                        completion(imageData)
                    }
                } catch {
                    
                }
            }
        }
    }
    
    func getPeople() async {
        state = .showActivityIndicator
            do {
                let peopleResponse =   try await requestManager.perform(Request.people, type: PeopleResponce.self)
                
            peopleRecords = peopleResponse.map { $0.toDomain()}

                state = .showPeopleView
            } catch {
                state = .showError((error as! NetworkError).localizedDescription)
            }
    }
}

