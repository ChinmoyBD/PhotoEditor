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
    @IBOutlet weak var popUpView: UIView!
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
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            print(bottomView.height)
            UIView.animate(withDuration: 0.3) {
                self.topView.frame.origin.y -= 50
                self.popUpView.frame.origin.y -= self.bottomView.height+50
            } completion: { (finished) in
                if finished{
                    //self.popUpView.frame.origin.y += self.bottomView.height
                }
            }
            
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
    }
    
    @IBAction func popUpButtons(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.topView.frame.origin.y += 50
            self.popUpView.frame.origin.y += self.bottomView.height+50
        }
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

