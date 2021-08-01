//
//  File.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 23/7/21.
//

import Foundation
import UIKit

class Shape {
    var aria: Double?
    var base: Double?
    var height: Double?
    var redius: Double?
    
    func calculateArea() -> Double {
        return 0.0
    }
    
    func calculatePerimeter() {
        
    }
}

class Triangle: Shape {
    override func calculateArea() -> Double {
        return (base ?? 0.0) * (height ?? 0.0)/2
    }
}

class Circle: Shape {
    override func calculateArea() -> Double {
        return 3.1415 * pow((redius ?? 0.0), 2.0)
    }
}

class Square: Shape {
    override func calculateArea() -> Double {
        return pow(aria ?? 0.0, 2.0)
    }
}
