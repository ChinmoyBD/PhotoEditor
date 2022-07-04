//
//  FilterView.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 3/7/22.
//

import UIKit
import AVKit

protocol FilterViewDelegate {
    func selectedFilter(image: UIImage)
    func dismiss()
    func applyFilter()
}

class FilterView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    var originalImage: UIImage?
    var thumImage: UIImage?
    var filtersImage = [UIImage]()
    var delegate: FilterViewDelegate?
    
    // apply sepia filter
    let context = CIContext()
    
    let filters = [
        "CIColorCrossPolynomial", "CIColorCube", "CIColorCubeWithColorSpace", "CIColorInvert", "CIColorMap",
        "CIColorMonochrome", "CIColorPosterize", "CIFalseColor", "CIMaskToAlpha", "CIMaximumComponent",
        "CIMinimumComponent", "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectMono",
        "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CISepiaTone",
        "CIVignette", "CIVignetteEffect"
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)![0] as! UIView
        //contentView.fixInView(self)
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        loadCollectionViewData()
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.dismiss()
        }
    }
    
    
    func loadCollectionViewData() {
        
        guard let originalImage = originalImage else { return }

        let rect = AVMakeRect(aspectRatio: originalImage.size, insideRect: CGRect(origin: .zero, size: CGSize(width: 200, height: 250)))
        thumImage = originalImage.resize(to: CGSize(width: rect.width, height: rect.height))
        
        for filter in filters {
            let img = setFilter(filterType: filter)
            filtersImage.append(img)
        }
   
        filterCollectionView.reloadData()
    }
    
    
    //MARK: - Sticker Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtersImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        cell.backgroundColor = UIColor(named: "cell")
        cell.layer.cornerRadius = 5
        cell.editedImage.image = filtersImage[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            //delegate.selectedImage(image: emojis[indexPath.row])
        }
    }

}


extension FilterView {
    
    private func setFilter(filterType: String) -> UIImage {
        
        guard let thumImage = thumImage else {
            return UIImage()
        }
        
        let filter = CIFilter(name: filterType)
        if filterType == "CISepiaTone" {
            filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        }
        
        filter?.setValue(CIImage(image: thumImage), forKey: kCIInputImageKey)
        let output = filter?.outputImage
//        guard let output = output else {
//            return originalImage!
//        }
        if output == nil {
            return thumImage
        }
        return UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
}
