//
//  PeopleCollectionViewCell.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import UIKit

final class PeopleCollectionViewCell: UICollectionViewCell {
    
    lazy var posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupUI() {
        self.contentView.addSubview(posterImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(titleLabel)

        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        
        posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
        
        posterImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        posterImageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        
        nameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5.0).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0).isActive = true
        
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5.0).isActive = true
        
        nameLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 5.0).isActive = true
        
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5.0).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0).isActive = true
        
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5.0).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5.0).isActive = true
    }
    
    func configureData(people: People) {
        nameLabel.text = people.firstName + people.lastName
        titleLabel.text = people.jobTitle
        self.contentView.layer.borderColor = UIColor.gray.cgColor
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.cornerRadius = 5.0

        posterImageView.layer.cornerRadius = 35
        posterImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        posterImageView.image = nil
        titleLabel.text = ""
    }
    
}
