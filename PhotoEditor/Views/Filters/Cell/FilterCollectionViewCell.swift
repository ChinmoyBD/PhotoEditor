//
//  FilterCollectionViewCell.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 21/7/21.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FilterCollectionViewCell"
    
    let editedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(editedImage)
        
        editedImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

        editedImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        editedImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        editedImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        editedImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        editedImage.frame = CGRect(x: 10,
//                                     y: 10,
//                                     width: 100,
//                                     height: 100)
//
//    }
}
