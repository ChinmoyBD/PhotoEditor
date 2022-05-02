//
//  Extensions.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 19/7/21.
//

import Foundation
import UIKit

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
    
}


extension String {
    
    func emojiToImage(size: CGFloat) -> UIImage {
        
        let outputImageSize = CGSize.init(width: size, height: size)
        let baseSize = self.boundingRect(with: CGSize(width: 2048, height: 2048),
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: UIFont.systemFont(ofSize: size / 2)], context: nil).size
        let fontSize = outputImageSize.width / max(baseSize.width, baseSize.height) * (outputImageSize.width / 2)
        let font = UIFont.systemFont(ofSize: fontSize)
        let textSize = self.boundingRect(with: CGSize(width: outputImageSize.width, height: outputImageSize.height),
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: font], context: nil).size
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byClipping
        
        let attr : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : font,
                                                     NSAttributedString.Key.paragraphStyle: style,
                                                     NSAttributedString.Key.backgroundColor: UIColor.clear ]
        
        UIGraphicsBeginImageContextWithOptions(outputImageSize, false, 0)
        self.draw(in: CGRect(x: (size - textSize.width) / 2,
                             y: (size - textSize.height) / 2,
                             width: textSize.width,
                             height: textSize.height),
                  withAttributes: attr)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}
