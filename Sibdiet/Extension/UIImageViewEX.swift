//
//  UIImageViewEX.swift
//  Sibdiet
//
//  Created by Amin on 4/1/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import UIKit

extension UIImageView{
    func image(_ image: UIImage){
        self.image = image
    }
    
    func contentMode(_ mode: UIView.ContentMode){
        self.contentMode = mode
    }
}

extension UIImage{
    convenience init?(_ name: String) {
        self.init(named: name)
    }
}
