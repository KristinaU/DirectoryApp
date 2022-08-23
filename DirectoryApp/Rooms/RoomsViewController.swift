//
//  RoomsViewController.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import UIKit
import Combine

final class RoomsViewController: UIViewController, Alertable {
    
    private lazy var activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel:RoomsViewModel
    
    private var bindings = Set<AnyCancellable>()

    init(viewModel:RoomsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        getRooms()
    }
}

// MARK: - Private Methods

extension RoomsViewController {
    private func getRooms() {
        Task {
            await viewModel.getRooms()
        }
    }
    
    private func setupBinding() {
        viewModel.$state.receive(on: RunLoop.main).sink(receiveValue: {[weak self] states in
            switch states {
            case .showActivityIndicator:
                self?.showActivity()
            case .showRoomsView:
                self?.hideActivity()
                self?.tableView.reloadData()
            case .showError( let message):
                self?.hideActivity()
                self?.showAlert(message:message)
            case .none:
                self?.hideActivity()
            }
        }).store(in: &bindings)
    }
       
    private func setupUI() {
        self.view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant:0.0).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant:0.0).isActive = true
        
        activityIndicator.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        activityIndicator.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        // TableView setup
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        
        tableView.register(RoomsTableViewCell.self, forCellReuseIdentifier:"Cell")
        
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:0.0).isActive = true
        
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:0.0).isActive = true
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:0.0).isActive = true
        
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:0.0).isActive = true
        
        self.navigationItem.title = NSLocalizedString("rooms", comment:"")

    }
    private func showActivity() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    private func hideActivity() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
}

extension RoomsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfRooms
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RoomsTableViewCell else {
            return UITableViewCell()
        }
        
        let room = viewModel.getRooms(for: indexPath.row)
        cell.configureData(room: room)        
        return cell
    }
}

