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
            let sv = StickerView(frame: CGRect(x: 5, y: 5, width: popUpView.width-10, height: bottomView.height-30))
            sv.delegate = self
            popUpView.addSubview(sv)
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
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            UIView.animate(withDuration: 0.3) {
                self.topView.frame.origin.y -= 50
                self.popUpView.frame.origin.y -= self.bottomView.height+50
    //                self.popUpView.addSubview(sv)
            }
        }

    }
    
    @IBAction func popUpButtons(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.topView.frame.origin.y += 50
            self.popUpView.frame.origin.y += self.bottomView.height+50
        }
    }
    
}

//MARK: - Sticker

extension HomeViewController: StickerViewDelegate {
    func selectedImage(image: UIImage) {
        popUpButtons(UIButton())
        print(image)
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

