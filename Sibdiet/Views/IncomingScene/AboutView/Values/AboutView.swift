//
//  AboutView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 10/20/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import MessageUI

protocol AboutViewDelegate {
    func setFirstView()
    func share()
}

class AboutView: UIView, AboutViewDelegate{
    
    var touchable = false
    let cornerRound: CGFloat = 10
    var open = false
    let values = AboutViewValues()
    let nameTitle = String()

    var delegateAboutView: AboutViewDelegate?
    func delegate(_ delegate: AboutViewDelegate){
        self.delegateAboutView = delegate
    }

    //MARK: INIT VIEW
    func initView(){
//        setDr()
        setTopFrame()
//        setDrInfo()
        setDietDescription()
        setBackDietDescription()
        setBottomView()
        setShareButton()
        setLicense()
        setDiets()
        startView()
    }
    
    //MARK: TOPBAR
    var topBarView = UIView()
    func setTopFrame(){
        topBarView.frame(topFrame)
        topBarView.shadow(CGSize(0, 1), gray09, 1, 0.7)
        topBarView.backgroundColor(barBackgroundColor)
        setBackButton()
        setName()
        setSubTitle()
        addSubview(topBarView)
    }
    
    //MARK: NAME
    var name = UILabel()
    func setName(){
        let font = UIFont(JosefinSans, (hasSafeArea ? 32 : 30))!
        let width = values.nameTitle.width(height: 27, font: font)
        name.frame(topBarView.width/2 - width/2,
                   topBarView.height - (hasSafeArea ? 57 : 52),
                   width,
                   35)
        name.text(values.nameTitle)
        name.font(values.nameFont)
        name.textColor(aboutColor)
        name.shadow(CGSize(0, 1), gray06, 0.7, 0.6)
        name.textAlignment(.center)
        topBarView.addSubview(name)
    }
    
    //MARK: SUBTITLE
    var subTitle = SubTitle()
    func setSubTitle(){
        let font = values.subTitleFont
        let width = values.subTitle.width(height: 20, font: font) + 10
        let x: CGFloat = topBarView.width/2 - width/2,
        y: CGFloat = topBarView.height - 22
        subTitle.frame(x, y, width, 20)
        subTitle.string(values.subTitle)
        subTitle.font(values.subTitleFont)
        subTitle.backColor(aboutColor)
        subTitle.initView()
        topBarView.addSubview(subTitle)
    }
    
    //MARK: BACK BUTTON
    var backButton = BarButton()
    func setBackButton(){
        backButton.frame(isRTL ? topBarView.width - 63 : 3,
                         topBarView.height - (hasSafeArea ? 58 :  54),
                         60,
                         52)
        backButton.image01(BACK_IMG)
        backButton.text(values.backButtonTitle)
        backButton.font(values.backButtonFont)
        backButton.onTap(self, #selector(closeView))
        backButton.initView()
        topBarView.addSubview(backButton)
    }
    
    //MARK: SHARE BUTTON
     var shareButton = BarButton()
     func setShareButton(){
         shareButton.frame(!isRTL ? topBarView.width - 63 : 3,
                          topBarView.height - (hasSafeArea ? 58 :  54),
                          60,
                          52)
         shareButton.image01(SHARE_IMG)
         shareButton.text(values.shareButtonTitle)
         shareButton.font(values.backButtonFont)
         shareButton.onTap(self, #selector(share))
         shareButton.initView()
         topBarView.addSubview(shareButton)
     }
    
    @objc func share(){
        delegateAboutView?.share()
    }
    
    //MARK: DR VIEW
    var drView = UIView()
    var drViewOrigin: CATransform3D!
    func setDr(){
        drView.frame(10, -102+(hasSafeArea ? 44 : 20), 120, 300)
        drView.backgroundColor(gray01)
        drView.cornerRadius(20)
        drView.border(gray0, 5)
        drViewOrigin = drView.transform3D
        drView.clipsToBounds(true)
        setDrImage()
        addSubview(drView)
    }
    
    var drImage = CALayer()
    func setDrImage(){
        drImage.frame = CGRect(-20, 150, 160, 160)
        drImage.contents(UIImage(DR_IMG)!)
        drImage.contentsGravity(.resizeAspect)
        drView.addSublayer(drImage)
    }
    
    //MARK: DR INFO
    var drInfoView = UIView()
    var drInfoViewOrigin: CATransform3D!
    func setDrInfo(){
        drInfoView.frame(10, drView.y - drView.height/2, width-20, drView.height)
        drInfoView.backgroundColor(gray0)
        drInfoView.cornerRadius(20)
        drInfoViewOrigin = drInfoView.transform3D
        addSubview(drInfoView, below: drView)
        setDrTitle()
        setDrInfos()
    }
    
    var drTitle = UILabel()
    func setDrTitle(){
        let width = drInfoView.width - drView.width - 5,
        x: CGFloat = drInfoView.width - width - 5,
        y: CGFloat = drInfoView.height - drImage.height + 20
        drTitle.frame(x, y, width, 20)
        drTitle.textColor(gray08)
        drTitle.font(values.drTitleFont)
        drTitle.adjustsFontSizeToFitWidth(true)
        drTitle.text(values.drTitle)
        drTitle.shadow(CGSize(1, 1), white02, 0.5, 1)
        drTitle.textAlignment(isRTL ? .right : .left)
        drInfoView.addSubview(drTitle)
    }
    
    var drInfos = UILabel()
    func setDrInfos(){
        drInfos.frame(drTitle.x - drTitle.width/2,
                      drTitle.y + drTitle.height/2,
                      drTitle.width,
                      115)
        drInfos.textColor(gray06)
        drInfos.text(values.drInfos)
        drInfos.font(values.drInfosFont)
        drInfos.numberOfLines(0)
        drInfos.adjustsFontSizeToFitWidth(true)
        drInfos.textAlignment(isRTL ? .right : .left)
        drInfoView.addSubview(drInfos)
    }
    
    //MARK: BG DIET DESCRIPTION
    var backDietDescription = CAShapeLayer()
    func setBackDietDescription(){
        backDietDescription.frame(10,
                                  dietDescription.y - dietDescription.height/2 - 2,
                                  width-20,
                                  dietDescription.height)
        backDietDescription.backgroundColor(gray02)
        backDietDescription.cornerRadius(cornerRound)
        setBackDietDescriptionMask()
        backDietDescription.mask(backDietDescriptionMask)
        addSublayer(backDietDescription, 0)
    }
    
    var backDietDescriptionMask = CAShapeLayer()
    var backDietDescriptionMaskOrigin: CATransform3D!
    func setBackDietDescriptionMask(){
        backDietDescriptionMask.frame(backDietDescription.bounds)
        backDietDescriptionMask.cornerRadius(cornerRound)
        backDietDescriptionMask.backgroundColor(UIColor.blue)
        backDietDescriptionMaskOrigin = backDietDescriptionMask.transform
    }
    
    var dietDescriptionMask = UIView()
    var dietDescriptionMaskOrigin: CATransform3D!
    func setDietDescriptionMask(){
        dietDescriptionMask.frame(dietDescription.bounds)
        dietDescriptionMask.backgroundColor(gray03)
        dietDescriptionMaskOrigin = dietDescriptionMask.layer.transform
    }
    
    //MARK: DIET DESCRIPTION
    var dietDescription = UILabel()
    func setDietDescription(){
        dietDescription.frame(20,
                              //                              drInfoView.y + drInfoView.height/2 + 10,
            topBarView.y + topBarView.height/2 + 10,
            width-40,
            values.description.1)
        dietDescription.attributedText(values.description.0)
        dietDescription.textAlignment(isRTL ? .right : .left)
        dietDescription.lineBreakMode(.byTruncatingTail)
        dietDescription.numberOfLines(0)
        setDietDescriptionMask()
        dietDescription.mask = dietDescriptionMask
        addSubview(dietDescription)
    }
    
    //MARK: LICENSE
    var license = UILabel()
    var licenseOrigin: CATransform3D!
    func setLicense(){
        let distance: CGFloat = values.license.isPersianString ? 20 : 27
        license.frame(5,
                      bottomView.y - bottomView.height/2 - distance,
                      width-10,
                      20)
        license.textColor(gray07)
        license.font(values.licenseFont)
        license.text(values.license)
        license.textAlignment(.center)
        licenseOrigin = license.transform3D
        license.adjustsFontSizeToFitWidth(true)
        addSubview(license)
    }
    
    //MARK: BOTTOM VIEW
    let bottomView = UIView()
    func setBottomView(){
        let height:CGFloat = hasSafeArea ? 45 : 30
        bottomView.frame(0, self.height - height,  width, height)
        bottomView.shadow(.zero, gray06, 1.5, 0.7)
        setCreateView()
        setEmailView()
        addSubview(bottomView)
    }
        
    //MARK: CREATE VIEW
    func setCreateView(){
        let view = UIView()
        view.frame(isRTL ? width - width/2 : 0,
                   0,
                   width/2,
                   bottomView.height)
        view.backgroundColor(createColor)
        let text = UILabel()
        text.frame(0, 0, width/2, 30)
        text.textColor(gray00)
        text.font(Sahel, 16)
        text.adjustsFontSizeToFitWidth(true)
        text.text(values.create)
        text.textAlignment(.center)
        view.addSubview(text)
        bottomView.addSubview(view)
    }
    
    //MARK: EMAIL
    func setEmailView(){
        let view = UIView()
        view.frame(isRTL ? 0 : width/2,
                   0,
                   width-width/2,
                   bottomView.height)
        view.backgroundColor(gray00)
        let text = UILabel()
        text.frame(5, 0, view.width-10, 30)
        text.textColor(createColor)
        text.font(Sahel, 16)
        text.text("Amin Sadeghian")
        text.adjustsFontSizeToFitWidth(true)
        text.textAlignment(.center)
        view.addSubview(text)
        bottomView.addSubview(view)
    }
    
    //MARK: DIET'S VIEW
    var dietsView = DietsList()
    var dietsOriginR: CGRect!
    var dietsOriginT: CATransform3D!
    func setDiets(){
        let x: CGFloat = -1,
        y: CGFloat = backDietDescription.y + backDietDescription.height/2 + 5,
        w: CGFloat = width+2,
        k: CGFloat = self.height - backDietDescription.y - backDietDescription.height/2,
        j: CGFloat = self.height - license.y + license.height/2,
        h: CGFloat = k - j - 10
        dietsView.frame = CGRect(x: x, y: y, width: w, height: h)
        dietsView.onPan(self, #selector(panDiets(pan:)))
        dietsView.border(gray05, 1)
        dietsView.list = values.dietList
        dietsView.clipsToBounds = true
        dietsView.backgroundColor = gray13
        dietsOriginR = dietsView.bounds
        dietsOriginT = dietsView.transform3D
        dietsView.setDietCells()
        addSubview(dietsView)
    }
    
   
    //MARK: PAN DIET
    var dietsCellsY: CGFloat!
    @objc func panDiets(pan:  UIPanGestureRecognizer){
        let listHeight: CGFloat = dietsView.dietsCells.height
        let topCellsY: CGFloat = listHeight/2
        let bottomCellsY =  -(dietsView.dietsCells.h - dietsView.height - topCellsY) - 15

        let translation = pan.translation(in: dietsView)
        
        switch pan.state {
        case .began:
            dietsCellsY = dietsView.dietsCells.y
        case .changed:
            
            let changedY = dietsCellsY + translation.y
            dietsView.dietsCells.y = changedY
        case .ended:
            let velocity = pan.velocity(in: dietsView)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 100
            let slideFactor = 0.1 * slideMultiplier
            let y = dietsView.dietsCells.y + (velocity.y * slideFactor)
            let time = CFTimeInterval(slideFactor * 2)
            
            if y > topCellsY{
                dietsView.move(to: topCellsY, duration: 0.5)
            }else if y < bottomCellsY{
                dietsView.move(to: bottomCellsY, duration: 0.5)

            }else {
                dietsView.dietsCells.animate(y: y, time, curveEaseOut03)
            }
        default:
            break
        }
    }
    
    //MARK: START VIEW
    func startView(){
        backButton.opacity = 0.2
        
        let topFrame01Y = CGAffineTransform(y: -topBarView.height)
        topBarView.transform = topFrame01Y
        topBarView.animate(transformPoint: CGPoint(1, 1), 0.7, curve)
        
//        let drView01Y = CATransform3DTranslate(drViewOrigin, 0, -250, 0)
//        drView.transform3D = drView01Y
//        drView.animate(transform3D: drViewOrigin, 1, curve)
//
//        let drInfo01Y = CATransform3DTranslate(drInfoViewOrigin, 0, -250, 0)
//        drInfoView.transform3D = drInfo01Y
//        drInfoView.animate(transform3D: drInfoViewOrigin, 1, curve)
        
        let backDietDescriptionMask01Y = CATransform3DTranslate(backDietDescriptionMaskOrigin, 0, -backDietDescription.height, 0)
        backDietDescriptionMask.transform = backDietDescriptionMask01Y
        backDietDescriptionMask.animate(transform3D: backDietDescriptionMaskOrigin, 0.8, easeInOut, 0.8)
        
        let dietDescriptionMask01Y = CATransform3DTranslate(dietDescriptionMaskOrigin, 0, -dietDescription.height, 0)
        dietDescriptionMask.layer.transform = dietDescriptionMask01Y
        dietDescriptionMask.layer.animate(transform3D: dietDescriptionMaskOrigin, 0.8, easeInOut, 0.8)

        let diets01S = CATransform3DScale(dietsOriginT, 1, 0, 0)
        dietsView.transform3D = diets01S

        dietsView.opacity = 0
        dietsView.animate(opacity: 1, 0.8, curveEaseIn05, 0.8)
        dietsView.animate(transform3D: dietsOriginT, 0.8, curveEaseOut05)

        let heightHelper = dietsOriginR.height + license.height
        let diets01H = heightHelper + bottomView.height + backDietDescription.height - 25
        dietsView.height = diets01H

        let diets02H = dietsOriginR.height + license.height + bottomView.height
        dietsView.animate(height: diets02H, 0.8, curveEaseInOut, 0)

        let diets02Y = (license.height )/2 - 35
        let diets02T = CATransform3DTranslate(dietsOriginT, 0, diets02Y, 0)
        dietsView.animate(transform3D: diets02T, 0.8, curveEaseOut05, 0)

        let diets03H = dietsOriginR.height + bottomView.height
        dietsView.animate(height: diets03H, 0.8, curveEaseOut05, 0)

        dietsView.animate(height: dietsOriginR.height, 0.5, curveEaseOut05, 0)
        dietsView.animate(transform3D: dietsOriginT, 0.5, curveEaseOut05, 0)

        let license01P = CATransform3DTranslate(licenseOrigin, 0, bottomView.height+license.height, 0)
        let license02P = CATransform3DTranslate(licenseOrigin, 0, bottomView.height, 0)
        license.transform3D = license01P
        license.layer.animate(transform3D: license02P, 0.8, easeOut05, 1.5)
        license.layer.animate(transform3D: licenseOrigin, 0.7, easeOut05, 2.3)
        
        bottomView.transformY(bottomView.height)
        bottomView.animate(transform: .identity, 0.7, curveEaseOut05, 2.3)
        
        backButton.animate(opacity: 1, 0.5, curveEaseInOut, 2)
        
        let _: Timer = Timer.schedule(3.0) { _ in
            self.enableTouch()
        }
    }
    
    @objc func enableTouch(){
        touchable = true
    }
    
    //MARK: CLOSE DIET
//    @objc func closeDiets(){
//        touchable = false
//        closeGesture.isHidden = true
//        backButton.opacity = 0.2
//
//        backDietDescriptionMask.animate(transform3D: backDietDescriptionMaskOrigin, 0.8, easeInOut05)
//        dietDescriptionMask.layer.animate(transform3D: dietDescriptionMaskOrigin, 0.8, easeInOut05)
//
//        var k: CGFloat!
//        if isX{
//            k = 3
//        }else if is5{
//            k = -11
//        }else if is6{
//            k = -2
//        }else if isPlus{
//            k = -2
//        }else{
//            k = 16
//        }
//
//        let diets01T = CATransform3DTranslate(dietsOriginT, 0, (dietDescription.height/2) + k + 9, 0)
//        dietsView.animate(transform3D: diets01T, 0.8, curveEaseInOut05)
//        dietsView.animate(height: dietsOriginR.height, 0.8, curveEaseInOut05)
//        dietsView.animate(transform3D: dietsOriginT, 0.8, curveEaseInOut05)
//        dietsView.animate(backgroundColor: gray13,  1.9, curveEaseOut05)
//
//        backButton.animate(opacity: 1, 0.7, curveEaseInOut, 1.2)
//
//        let _: Timer = Timer.schedule(1.9) { _ in
//            self.isClose()
//        }
//    }
    
    @objc func isClose(){
        touchable = true
        open = false
    }
    
    //MARK: CLOSE VIEW
    @objc func closeView(){
        if touchable{
            touchable = false
            
            dietsView.animate(height: 0, 0.8, curve)
            dietsView.animate(opacity: 0, 0.8, curve)

            let backDietDescriptionMask01Y = CATransform3DTranslate(backDietDescriptionMaskOrigin, 0, -backDietDescription.height, 0)
            backDietDescriptionMask.animate(transform3D: backDietDescriptionMask01Y, 0.6, easeInOut05, 0.5)
            
            let dietDescriptionMask01Y = CATransform3DTranslate(dietDescriptionMaskOrigin, 0, -dietDescription.height, 0)
            dietDescriptionMask.layer.animate(transform3D: dietDescriptionMask01Y, 0.6, easeInOut05, 0.5)
            
//            let drView01Y = CATransform3DTranslate(drViewOrigin, 0, -300, 0)
//            drView.animate(transform3D: drView01Y, 1, curveEaseInOut05, 0.7)
            
//            let drInfo01Y = CATransform3DTranslate(drInfoViewOrigin, 0, -300, 0)
//            drInfoView.animate(transform3D: drInfo01Y, 1, curveEaseInOut05, 0.7)
            
            topBarView.animate(transformY: -topBarView.height, 0.7, curveEaseInOut05, 0.9)
            
            bottomView.animate(transformY: bottomView.height, 0.6, curveEaseIn06, 0.5)
            
            let license01P = CATransform3DTranslate(licenseOrigin, 0, bottomView.height, 0)
            let license02P = CATransform3DTranslate(licenseOrigin, 0, bottomView.height+license.height, 0)
            license.layer.animate(transform3D: license01P, 0.6, easeIn06, 0.5)
            license.layer.animate(transform3D: license02P, 0.6, easeInOut05, 1.1)
            
            let _: Timer = Timer.schedule(1.7) { _ in self.setFirstView() }
        }
    }
    
    @objc func setFirstView() {
        self.remove()
        delegateAboutView?.setFirstView()
    }
}
