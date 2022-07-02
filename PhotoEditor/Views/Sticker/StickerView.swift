//
//  StickerView.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 16/4/22.
//

import UIKit

protocol StickerViewDelegate {
    func selectedImage(image: UIImage)
    func dismiss()
}

class StickerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stickerCollectionView: UICollectionView!
    
    var emojis = [UIImage]()
    var delegate: StickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("StickerView", owner: self, options: nil)![0] as! UIView
        //contentView.fixInView(self)
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        stickerCollectionView.delegate = self
        stickerCollectionView.dataSource = self
        stickerCollectionView.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: StickerCollectionViewCell.identifier)
        loadCollectionViewData()
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.dismiss()
        }
    }
    
    
    func loadCollectionViewData() {
        for i in 0x1F601...0x1F64F {
            let image = String(UnicodeScalar(i) ?? "-").emojiToImage(size: 120)
            emojis.append(image)
        }
        
        stickerCollectionView.reloadData()
    }
    
    
    //MARK: - Sticker Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = stickerCollectionView.dequeueReusableCell(withReuseIdentifier: "StickerCollectionViewCell", for: indexPath) as! StickerCollectionViewCell
        cell.backgroundColor = UIColor(named: "cell")
        cell.layer.cornerRadius = 5
        cell.editedImage.image = emojis[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.selectedImage(image: emojis[indexPath.row])
        }
    }

}
