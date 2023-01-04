//
//  UIViewControllerEX.swift
//  Sibdiet
//
//  Created by Amin on 3/23/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import UIKit

extension UIViewController{
    func addSubview(_ uiview: UIView){
        view.addSubview(uiview)
    }
    func present(_ link : [String]){
        present(UIActivityViewController(link), animated: true, completion: nil)
    }
}

extension UIActivityViewController{
    convenience init(_ items: [String]) {
        self.init(activityItems: items, applicationActivities: nil)
    }
}
