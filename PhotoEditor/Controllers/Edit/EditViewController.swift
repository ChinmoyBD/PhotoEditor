//
//  EditViewController.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 1/7/22.
//

import UIKit
import AVKit

class EditViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var editingImageView: UIImageView!
    @IBOutlet weak var canvasViewHeight: NSLayoutConstraint!
    @IBOutlet weak var canvasViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var stickerView: StickerView!
    @IBOutlet weak var stickerViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var filterView: FilterView! {
        didSet {
            filterView.originalImage = originalImage
            filterView.loadCollectionViewData()
        }
    }
    @IBOutlet weak var filterViewTop: NSLayoutConstraint!
    
    
    var originalImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonsAction(_ sender: UIButton) {
        switch sender.tag {
        //Sticker
        case 0:
            stickerViewTop.constant = -5
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
            break
        //Text
        case 1:
            break
        //Filter
        case 2:
            stickerViewTop.constant = 188
            filterViewTop.constant = -5
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
            break
        //Crop
        case 3:
            if let originalImage = originalImage {
                let vc = CropViewController(image: originalImage)
                vc.delegate = self
                present(vc, animated: true, completion: nil)
            }
            break
        //Rotate
        case 4:
            break
        default:
            break
        }
    }
    
    @IBAction func navButtonsAction(_ sender: UIButton) {
        //Back
        if sender.tag == 0 {
            self.dismiss(animated: true)
        }
        //Next
        else {
            
        }
    }
    
}


extension EditViewController {
    
    func setup() {
        stickerView.delegate = self
    }
    
    func setupLayout() {
        
        editingImageView.image = originalImage

        let rect = AVMakeRect(aspectRatio: originalImage?.size ?? .zero, insideRect: topView.bounds)
        canvasViewWidth.constant = rect.width
        canvasViewHeight.constant = rect.height
    }
}

extension EditViewController: StickerViewDelegate, CropViewControllerDelegate{
    
    func selectedImage(image: UIImage) {
        print(image)
    }
    
    func dismiss() {
        stickerViewTop.constant = 188
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            // 'image' is the newly cropped version of the original image
        originalImage = image
        setupLayout()
        
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
}
