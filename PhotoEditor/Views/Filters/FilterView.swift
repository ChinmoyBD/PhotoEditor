//
//  FilterView.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 3/7/22.
//

import UIKit
import AVKit

protocol FilterViewDelegate {
    func filterdIamge(image: UIImage)
    func dismiss(image: UIImage)
    func applyFilter()
}

class FilterView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var filterTypeCollectionView: UICollectionView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    var originalImage: UIImage?
    var thumImage: UIImage?
    var delegate: FilterViewDelegate?
    
    // apply sepia filter
    let context = CIContext()
    
    let filters = [
        "CIColorMonochrome", "CIColorPosterize", "CIFalseColor", "CIMaskToAlpha", "CIMaximumComponent",
        "CIMinimumComponent", "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectMono",
        "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CISepiaTone",
        "CIVignette", "CIVignetteEffect"
    ]
    

    var filtersType = ["Basic", "Instagram", "GPUFilter"]
    var filtersImage = [UIImage]()

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
        
        setupCollectionView()
        loadCollectionViewData()
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        if let delegate = delegate, let originalImage = originalImage {
            delegate.dismiss(image: originalImage)
        }
    }
    @IBAction func applyFilterButtonPressed(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.applyFilter()
        }
    }
}


extension FilterView {
    
    func setupCollectionView() {
        filterTypeCollectionView.delegate = self
        filterTypeCollectionView.dataSource = self
        filterTypeCollectionView.register(FilterTypeCollectionViewCell.self, forCellWithReuseIdentifier: FilterTypeCollectionViewCell.identifier)
        filterTypeCollectionView.selectItem(at: [0, 0], animated: true, scrollPosition: .bottom)
        
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
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
        switch collectionView {
        case self.filterTypeCollectionView:
            return filtersType.count
        case self.filterCollectionView:
            return filtersImage.count
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.filterTypeCollectionView:
            let cell = filterTypeCollectionView.dequeueReusableCell(withReuseIdentifier: FilterTypeCollectionViewCell.identifier, for: indexPath) as! FilterTypeCollectionViewCell
            cell.backgroundColor = UIColor(named: "cell")
            cell.layer.cornerRadius = 5
            cell.typeLabel.text = filtersType[indexPath.row]
            return cell
            
        case self.filterCollectionView:
            let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
            cell.backgroundColor = UIColor(named: "cell")
            cell.layer.cornerRadius = 5
            cell.editedImage.image = filtersImage[indexPath.row]
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.filterTypeCollectionView:
            break
        case self.filterCollectionView:
            if let delegate = delegate {
                let img = setFilter(filterType: filters[indexPath.row])
                delegate.filterdIamge(image: img)
            }
        default:
            break
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
