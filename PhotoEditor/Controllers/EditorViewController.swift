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
    
    let filters = ["CIBumpDistortion", "CIGaussianBlur", "CIPixellate", "CISepiaTone", "CITwirlDistortion", "CIUnsharpMask", "CIVignette"]
    
//    private var filterCollectionView: UICollectionView = {
//        let collectionView = UICollectionView()
//        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
//        return collectionView
//    }()
    
    private var filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1529217958, green: 0.1529547274, blue: 0.1529174745, alpha: 1)
        
        setupNavigationBar()
        setupCollectionView()
        
//        filterButton.addTarget(self,
//                              action: #selector(filterButtonTapped),
//                              for: .touchUpInside)


        
        // Add SubView
        view.addSubview(imageView)
        view.addSubview(filterButton)
        view.addSubview(filterCollectionView)
        print(imageView.bottom)
        filterCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.height/7 + view.height/1.5)+20).isActive = true
        filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        filterCollectionView.heightAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.frame = CGRect(x: 0,
                                 y: view.height/7,
                                 width: view.width,
                                 height: view.height/1.5)
        
//        filterButton.frame = CGRect(x: (view.width/2)-20,
//                                    y: imageView.bottom+10,
//                                    width: 40,
//                                    height: 20)
 

    }
    
    private func setupNavigationBar() {
        title = "Eidt"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1529218853, green: 0.1529548466, blue: 0.1572185457, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        filterCollectionView?.isScrollEnabled = true
//        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        filterCollectionView!.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        

        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
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

extension EditorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
        cell.editedImage.image = imageView.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (filterCollectionView.frame.width)/4.5, height: (filterCollectionView.frame.width)/4)
    }
    
}
