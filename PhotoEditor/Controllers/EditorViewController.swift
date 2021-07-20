//
//  EditorViewController.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 20/7/21.
//

import UIKit
import CoreImage

class EditorViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Filter", for: .normal)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1529217958, green: 0.1529547274, blue: 0.1529174745, alpha: 1)
        
        filterButton.addTarget(self,
                              action: #selector(filterButtonTapped),
                              for: .touchUpInside)

        
        // Add SubView
        view.addSubview(imageView)
        view.addSubview(filterButton)
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
        
        filterButton.frame = CGRect(x: (view.width/2)-20,
                                    y: imageView.bottom+10,
                                    width: 40,
                                    height: 20)
    }
    
    // apply sepia filter
    let context = CIContext()
    
    @objc private func filterButtonTapped() {
        
        if imageView.image == nil {
            return
        }
        
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        
        filter?.setValue(CIImage(image: imageView.image!), forKey: kCIInputImageKey)
        let output = filter?.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    

}
