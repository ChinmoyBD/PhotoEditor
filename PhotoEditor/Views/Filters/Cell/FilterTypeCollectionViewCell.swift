//
//  FilterTypeCollectionViewCell.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 4/7/22.
//

import UIKit

class FilterTypeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FilterTypeCollectionViewCell"
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(typeLabel)
        
        typeLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

        typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        typeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        typeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    override var isSelected: Bool {
        didSet {
            typeLabel.textColor = isSelected ? .blue : .black
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
