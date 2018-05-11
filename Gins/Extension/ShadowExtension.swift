//
//  ShadowExtension.swift
//  Gins
//
//  Created by serfusE on 2018/5/11.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadow(offset: CGSize = CGSize(width: 0.4, height: 1)) {
        DispatchQueue.main.async {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.7
            self.layer.shadowOffset = offset
            self.layer.shadowRadius = 1
            
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
        }
        
    }

    func dropShadow(color: UIColor, opacity: Float, offSet: CGSize, radius: CGFloat, scale: Bool) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
