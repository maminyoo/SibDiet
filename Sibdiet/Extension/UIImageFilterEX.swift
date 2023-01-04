//
//  UIImageFilterEX.swift
//  Sibdiet
//
//  Created by Amin on 6/11/20.
//  Copyright © 2020 maminyoo. All rights reserved.
//

import UIKit

extension UIImage {
    
    var noseReduced: UIImage? {
        guard let openGLContext = EAGLContext(api: .openGLES2) else { return self }
        let context = CIContext(eaglContext: openGLContext)
        if let currentFilter = CIFilter(name: "CINoiseReduction") {
            currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
            currentFilter.setValue(0.001, forKey: "inputNoiseLevel")
            currentFilter.setValue(1, forKey: "inputSharpness")
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: cgimg, scale: scale, orientation: imageOrientation)
                }
            }
        }
        return nil
    }
}
