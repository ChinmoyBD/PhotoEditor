//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 19/7/21.
//

import UIKit

class EditorViewController: UIViewController {
    
    private let selectImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
        return button
    }()
    
    private let selectImageLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Image"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 19, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1865163445, green: 0.1187224463, blue: 0.2177631259, alpha: 1)
        
        selectImageButton.addTarget(self,
                              action: #selector(selectImageButtonTapped),
                              for: .touchUpInside)
        
        // Add SubView
        view.addSubview(selectImageLabel)
        view.addSubview(selectImageButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        selectImageLabel.frame = CGRect(x: (view.width/2)-60,
                                        y: (view.height/3),
                                        width: 120,
                                        height: 25)
        
        selectImageButton.frame = CGRect(x: (view.width/2)-50,
                                   y: selectImageLabel.bottom+2,
                                   width: 100,
                                   height: 100)
    }
    
    @objc private func selectImageButtonTapped() {
        print("Select Image")
    }


}

