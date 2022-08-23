//
//  RoomsTableViewCell.swift
//  DirectoryApp
//
//  Created by KRISTINA UROSOVA on 23/08/22.
//

import UIKit

final class RoomsTableViewCell: UITableViewCell {
    
    private lazy var parentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 10.0
        stackView.distribution = .fill
        return stackView
    }()
    
    
    lazy var idLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var occupiedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var maxOccupancyLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var createdAtLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Id"
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var idLabelName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Name"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var occupiedLabelName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Occupied Status"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var maxOccupancyLabelName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Max Occupancy"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var createdAtLabelName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Created At"
        label.numberOfLines = 0
        return label
    }()
    
    private func createGroupStackView()-> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        return stackView
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(parentStackView)
        parentStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:0.0).isActive = true
        
        parentStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant:0.0).isActive = true
        
        parentStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:0.0).isActive = true
        
        parentStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant:0.0).isActive = true

        
        [(idLabelName, idLabel), (maxOccupancyLabelName, maxOccupancyLabel), (occupiedLabelName, occupiedLabel), (createdAtLabelName, createdAtLabel)].forEach {  element in
            
            let stackView = createGroupStackView()
            stackView.addArrangedSubview(element.0)
            stackView.addArrangedSubview(element.1)

            parentStackView.addArrangedSubview(stackView)
        }
    }
    
    override func prepareForReuse() {
        idLabel.text = ""
        occupiedLabel.text = ""
        maxOccupancyLabel.text = ""
        createdAtLabel.text = ""
    }
    
    func configureData(room: Room) {
        idLabel.text = room.id
        occupiedLabel.text = room.occupiedMessage
        maxOccupancyLabel.text = "\(room.maxOccupancy)"
        createdAtLabel.text = room.createdAt
    }
}
