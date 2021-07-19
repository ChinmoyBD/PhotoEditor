//
//  EditorViewController.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 20/7/21.
//

import UIKit

class EditorViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1529217958, green: 0.1529547274, blue: 0.1529174745, alpha: 1)
        
        // Add SubView
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        title = "Eidt"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1529218853, green: 0.1529548466, blue: 0.1572185457, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        
        imageView.frame = CGRect(x: 0,
                                 y: view.height/7,
                                 width: view.width,
                                 height: view.height/1.5)
    }
    

}
