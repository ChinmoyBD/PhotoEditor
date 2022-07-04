//
//  UIImage+Extention.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 3/7/22.
//

import UIKit

extension UIImage {
    func resize(to newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
