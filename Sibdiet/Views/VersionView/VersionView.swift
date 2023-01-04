//
//  VersionView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 6/16/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import SafariServices

class VersionView: UIView{
    
    let values = VersionViewValues()
    
    //MARK: INIT VIEW
    func initView(){
        setTitle()
        if appVersion.needed != ONE{ setBackButton() }
        setUpdateButton()
        setDescriptionText()
        startView()
    }
    
    //MARK: BACK BUTTON
    var backButton = BarButton()
    func setBackButton(){
        backButton.frame(20, hasSafeArea ? 33 : 22, 65, 52)
        backButton.image01(CLOSE_IMG)
        backButton.text(values.cancel)
        backButton.onTap(self, #selector(closeVersionView))
        backButton.opacity(0)
        backButton.animate(opacity: 1, 1, curveEaseOut)
        backButton.initView()
        addSubview(backButton)
    }
    
    @objc func closeVersionView(){
        animate(opacity: 0, 1, curve)
    }
    
    //MARK: TITLE
    var title = UILabel()
    func setTitle(){
        title.frame(width/2 - 90, (hasSafeArea ? 44 : 20)+40, 180, 80)
        title.attributedText(values.title)
        title.numberOfLines(0)
        title.textAlignment(.center)
        addSubview(title)
    }

    //MARK: DESCRIPTION
    var descriptionText = UILabel()
    func setDescriptionText(){
        descriptionText.frame(20,
                              title.y + title.height/2,
                              width-40,
                              height-(title.y+title.height/2+updateButton.height+20))
        descriptionText.font(Sahel, 18)
        descriptionText.textColor(gray06)
        descriptionText.numberOfLines(0)
        descriptionText.backgroundColor(sand01)
        descriptionText.textAlignment(isRTL ? .right : .left)
        descriptionText.backgroundColor(.clear)
        descriptionText.text(appVersion.versionDescription)
        
        addSubview(descriptionText)
    }
    
    //MARK: UPDATE BUTTON
    var updateButton = UILabel()
    func setUpdateButton(){
        updateButton.frame(20, height - 80, width-40, 60)
        updateButton.text(values.update)
        updateButton.backgroundColor(skyBlue01)
        updateButton.textColor(white)
        updateButton.font(Shabnam, 19)
        updateButton.cornerRadius(20)
        updateButton.clipsToBounds(true)
        updateButton.textAlignment(.center)
        updateButton.onTap(self, #selector(tapUpdate))
        setVersion()
        addSubview(updateButton)
    }
    
    //MARK: VERSION
    var version = UILabel()
    func setVersion(){
        version.frame(8, 2, 80, 20)
        version.textAlignment(.left)
        version.font(Sahel, 15)
        version.text("VER " + appVersion.newVersion)
        version.textColor(white)
        updateButton.addSubview(version)
    }
    
    @objc func tapUpdate(){
        guard let requestUrl = URL(string: appVersion.updateURL) else { return }
        UIApplication.shared.open(requestUrl, options: [:], completionHandler: nil)
    }
    
    //MARK: START VIEW
    func startView(){
        backgroundColor(white01.opacity(0.9))
        cornerRadius(40)
        border(white, 10)
        if iOS14{
            animate(backgroundColor: gray02.opacity(0.3), 2, curveEaseInOut)
        }else{
            blurBack(5, 2)
        }
        transformY(-height)
        animate(transform: .identity, 0.7, curveEaseOut05)
    }
}
