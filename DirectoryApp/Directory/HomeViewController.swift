//
//  HomeViewController.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private weak var coordinator: Coordinator?
    private var homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel, coordinator: Coordinator) {
        self.homeViewModel = homeViewModel
        self.coordinator = coordinator
        super.init(nibName:nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        // TableView setup
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"Cell")
        
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:0.0).isActive = true
        
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:0.0).isActive = true
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:0.0).isActive = true
        
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:0.0).isActive = true
        
        // Set Title
        
        self.navigationItem.title = NSLocalizedString("directory", comment: "")
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                
        cell.accessoryType = .disclosureIndicator

        cell.textLabel?.text = homeViewModel.getTitle(for: indexPath.row)
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :
            coordinator?.navigateToPeople()
        case 1 :
            coordinator?.navigateToRooms()
        default:
            print("")
        }
    }
}
