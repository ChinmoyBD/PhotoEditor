//
//  HomeViewController.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 5/4/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var mainImgImportView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        mainImgImportView.layer.cornerRadius = mainImgImportView.height / 2
        topView.isHidden = true
        bottomView.isHidden = true
    }
    
    @IBAction func importMainImgButtonAction(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

//MARK: - Import Image
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) { [self] in
            if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
                topView.isHidden = false
                bottomView.isHidden = false
                mainImgImportView.isHidden = true
                mainImageView.image = image
            }
        }
    }
}

