//
//  PeopleViewController.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.

import UIKit
import Combine

final class PeopleViewController: UIViewController, Alertable {
    
    private lazy var activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private lazy var collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    

    private let viewModel:PeopleViewModel
    
    private var bindings = Set<AnyCancellable>()

    init(viewModel:PeopleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("people", comment:"")
        setupCollectionView()
        setupBinding()
        getPeople()
    }
}

// MARK: - Private Methods

extension PeopleViewController {
    private func getPeople() {
        Task {
            await viewModel.getPeople()
        }
    }
    
    private func setupBinding() {
        viewModel.$state.receive(on: RunLoop.main).sink(receiveValue: {[weak self] states in
            switch states {
            case .showActivityIndicator:
                self?.showActivity()
            case .showPeopleView:
                self?.hideActivity()
                self?.collectionView.reloadData()
            case .showError( let message):
                self?.hideActivity()
                self?.showAlert(message:message)
            case .none:
                self?.hideActivity()
            }
        }).store(in: &bindings)
    }
      
    private func setupCollectionView() {
        
        self.view.addSubview(collectionView)

        // Activity Indicator
        
        self.view.addSubview(activityIndicator)

        
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant:0.0).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant:0.0).isActive = true
        
        activityIndicator.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        activityIndicator.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        // CollectionView Setup
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PeopleCollectionViewCell.self, forCellWithReuseIdentifier:"Cell")
        
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:0.0).isActive = true
        
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:0.0).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:0.0).isActive = true
        
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:0.0).isActive = true
        
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
    
    private func navigateToGalleryView() {
        viewModel.navigateToDetails(for: 1)
    }
}

extension PeopleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPeople
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath) as? PeopleCollectionViewCell else {
            return UICollectionViewCell()
        }

        let people = viewModel.getPeople(for: indexPath.row)
        
        cell.configureData(people: people)
        
        viewModel.getPeopleImage(for: indexPath.row, completion: { imageData in
            cell.posterImageView.image = UIImage(data: imageData)
        })
        return cell
    }
}

extension PeopleViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:180)
    }
}
