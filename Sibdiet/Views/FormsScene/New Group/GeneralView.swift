//
//  GeneralInfoView.swift
//  Sibdiet
//
//  Created by Amin on 9/21/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol GeneralInfoViewDelegate {
    func setBodyView(_ fromView: String)
    func setSpecialView(_ fromView: String)
}

class GeneralView: UIView , GeneralInfoViewDelegate{
    
    var delegateGeneralInfoView: GeneralInfoViewDelegate?
    func delegate(_ delegate: GeneralInfoViewDelegate){
        self.delegateGeneralInfoView = delegate
    }
    var fromView = String()
    
    let values = GeneralInfoValues()
    
    let sliceDrag: CGFloat = 4
    let corner: CGFloat = is5 ? 20 : 30
    
    //MARK: INIT VIEW
    func initView(_ fromView: String){
        self.fromView = fromView
        setTopBarView()
        setBottomView()
        setMiddleView()
        showView()
    }
    
    //MARK: TOP BAR
    var topBar = UIView()
    func setTopBarView(){
        topBar.frame(0, 0, width, hasSafeArea ? 352 : 330)
        topBar.backgroundColor(barBackgroundColor.opacity(0.9))
        topBar.shadow(CGSize(0, 1), gray09, 1, 0.7)
        setTopBarHead()
        setBg()
        setBmiLabel()
        addSubview(topBar)
    }
    
    //MARK: HEAD
    var topBarHead = UIView()
    func setTopBarHead(){
        topBarHead.frame(0, (hasSafeArea ? 44 : 20), width, 110)
        setName()
        setBackButton()
        setGenderMarital()
        setAgeLabel()
        topBar.addSubview(topBarHead)
    }
    
    //MARK: BACK
    var backButton = BarButton()
    func setBackButton(){
        backButton.frame(isRTL ? width - 65 : 5,
                         0,
                         60,
                         52)
        backButton.image01(BACK_IMG)
        backButton.text(values.backButtonTitle)
        backButton.onTap(self, #selector(backView))
        backButton.initView()
        topBarHead.addSubview(backButton)
    }
    
    var isClose = true
    @objc func backView(){
        if isClose{
            isClose = false
            closeView()
            setBodyView(fromView)
        }
    }
    
    func setBodyView(_ fromView: String) {
        delegateGeneralInfoView?.setBodyView(fromView)
    }
    
    //MARK: NAME
    let name = UILabel()
    func setName(){
        name.frame(60, (hasSafeArea ? -5 : -10), topBar.width - 120, 48)
        name.text(profile.fullName)
        name.font(Sahel_Bold, 40)
        name.textAlignment(.center)
        name.textColor(specialInfoColor)
        name.adjustsFontSizeToFitWidth(true)
        topBarHead.addSubview(name)
        setHalfName()
    }
    
    func setHalfName(){
        let name02 = UILabel()
        name02.frame(name.frame)
        name02.text(profile.fullName)
        name02.font(name.font)
        name02.textAlignment(.center)
        name02.textColor(specialInfoColor)
        name02.adjustsFontSizeToFitWidth(true)
        let mask = UIView()
        mask.frame(name02.bounds)
        mask.backgroundColor(green02)
        mask.transformY(name02.height/2+5)
        name02.mask = mask
        topBarHead.addSubview(name02)
    }
    
    //MARK: GENDER MARITAL
    var genderMarital = UILabel()
    func setGenderMarital(){
        genderMarital.frame(width/2-85,
                            name.y+name.height/2 + 10,
                            170,
                            27)
        genderMarital.backgroundColor(gray0)
        genderMarital.cornerRadius(8)
        genderMarital.border(gray03, 1)
        genderMarital.text(values.genderMarital)
        genderMarital.font(Sahel, 18)
        genderMarital.textAlignment(.center)
        genderMarital.textColor(gray05)
        genderMarital.clipsToBounds(true)
        topBarHead.addSubview(genderMarital)
    }
    
    //MARK: AGE
    var ageLabel = UILabel()
    func setAgeLabel(){
        ageLabel.frame(0,
                       genderMarital.y+genderMarital.height/2 + 8,
                       topBar.width,
                       28)
        ageLabel.text(values.age)
        ageLabel.textColor(gray06)
        ageLabel.textAlignment(.center)
        ageLabel.font(Sahel, 20)
        ageLabel.adjustsFontSizeToFitWidth(true)
        topBarHead.addSubview(ageLabel)
    }
    
    //MARK: BG OF BODY
    var bg = UIView()
    func setBg(){
        bg.frame(15,
                 topBarHead.y + topBarHead.height/2 + 13,
                 width - 30,
                 132)
        bg.cornerRadius(15)
        bg.backgroundColor(gray01.opacity(0.7))
        bg.clipsToBounds(true)
        bg.border(gray02, 1)
        setBodyStateLabel()
        setWeightLabel()
        setStatureLabel()
        setWristLabel()
        topBar.addSubview(bg)
    }
    
    //MARK: BODY STATE
    var bodyStateLabel = UILabel()
    func setBodyStateLabel(){
        let x = (-bg.height/2)+bg.width-28
        bodyStateLabel.frame(isRTL ? -bg.height/2 : x,
                             bg.height - 14,
                             bg.height,
                             28)
        bodyStateLabel.text(values.bodyState)
        bodyStateLabel.textColor(gray0)
        bodyStateLabel.textAlignment(.center)
        bodyStateLabel.backgroundColor(gray03)
        bodyStateLabel.font(Sahel, isRTL ? 20 : 18)
        bodyStateLabel.adjustsFontSizeToFitWidth(true)
        bodyStateLabel.anchorPoint(CGPoint.zero)
        bodyStateLabel.transformR(-90)
        bg.addSubview(bodyStateLabel)
    }
    
    //MARK: WEIGHT
    var weightLabel = UILabel()
    func setWeightLabel(){
        weightLabel.frame(15,
                          bg.height/3,
                          bg.width - 30,
                          bg.height/3)
        weightLabel.attributedText(values.weight)
        weightLabel.textAlignment(isRTL ? .right : .left)
        bg.addSubview(weightLabel)
    }
    
    //MARK: STATURE
    var statureLabel = UILabel()
    func setStatureLabel(){
        statureLabel.frame(15,
                           5,
                           bg.width - 30,
                           bg.height/3)
        statureLabel.attributedText(values.stature)
        statureLabel.textAlignment(isRTL ? .right : .left)
        bg.addSubview(statureLabel)
    }
    
    //MARK: WRIST
    var wristLabel = UILabel()
    func setWristLabel(){
        wristLabel.frame(15,
                         bg.height/3*2-(isRTL ? 8 : 5),
                         bg.width - 30,
                         bg.height/3)
        wristLabel.attributedText(values.wrist)
        wristLabel.textAlignment(isRTL ? .right : .left)
        bg.addSubview(wristLabel)
    }
    
    //MARK: BMI
    var bmiLabel = UILabel()
    func setBmiLabel(){
        bmiLabel.frame = CGRect(width/2-70,
                                topBar.height - 40,
                                140,
                                28)
        bmiLabel.text(values.BMI)
        bmiLabel.textColor(gray03)
        bmiLabel.backgroundColor(gray0)
        bmiLabel.textAlignment(.center)
        bmiLabel.cornerRadius(8)
        bmiLabel.clipsToBounds(true)
        bmiLabel.font(GillSans, 24)
        topBar.addSubview(bmiLabel)
    }
    
    //MARK: MIDDLE VIEW
    var middleView = UIView()
    func setMiddleView(){
        middleView.frame(0,
                         topBar.y+topBar.height/2,
                         width,
                         height-(bottomBar.height+topBar.height))
        if values.hasIdealWeight{
            setIdealWeightView()
            setOverWeightView()
        }else{
            setBabyBg()
        }
        middleView.shadow(CGSize(-1, 0), gray07, 3, 0.8)
        addSubview(middleView)
    }
    
    //MARK: BABY
    let babyBg = UIView()
    func setBabyBg(){
        babyBg.frame(15, 15, middleView.width-30, middleView.height-30)
        babyBg.backgroundColor(gray0.opacity(0.9))
        babyBg.border(gray0, 5)
        babyBg.cornerRadius(30)
        babyBg.opacity(0)
        babyBg.animate(opacity: 1, 1, curveEaseOut, 0.8)
        setBabyDes()
        middleView.addSubview(babyBg)
    }
    
    //MARK: BABY LABEL
    lazy var babyLabel = UILabel()
    func setBabyDes(){
        babyLabel.frame(babyBg.bounds)
        babyLabel.text(values.noIdealHave)
        babyLabel.textColor(white02)
        babyLabel.textAlignment(.center)
        babyLabel.font(Sahel_Bold, 28)
        babyLabel.numberOfLines(0)
        babyLabel.adjustsFontSizeToFitWidth(true)
        babyBg.addSubview(babyLabel)
    }
    
    //MARK: IDEAL
    var idealWeightView = UIView()
    func setIdealWeightView(){
        idealWeightView.frame(0, 0, middleView.width, middleView.height/2)
        idealWeightView.onPan(self, #selector(onPanIdeal(pan:)))
        setIdealBg()
        setIdealTitle()
        setIdealInt()
        setIdealInt02()
        setIdealKg()
        middleView.addSubview(idealWeightView)
    }
    
    //MARK: PAN IDEAL
    var onDragIdeal = false
    @objc func onPanIdeal(pan: UIPanGestureRecognizer){
        let translation = pan.translation(in: idealWeightView)
        switch pan.state {
        case .began:
            onDragIdeal = true
            if !onDragOver{
                getPosition()
            }
        case .changed:
            let translate = translation.x
            let x = idealX + translate/sliceDrag
            if x > idealX && !onDragOver {
                idealTitle.x(isRTL ? idealTitleX - translate/sliceDrag : idealTitleX)
                idealKg.x(isRTL ? idealKgX : idealKgX - translate/sliceDrag)
                idealInt.x = idealIntX - translate/(sliceDrag*2)
                idealInt02.x = idealIntX - translate/(sliceDrag*2)
                idealWeightView.x = idealX + translate/sliceDrag
                overWeightView.x = idealX - translate/sliceDrag
                overKg.x(isRTL ? overKgX + translate/sliceDrag : overKgX)
                overTitle.x(isRTL ?  overTitleX : overTitleX + translate/sliceDrag)
                overInt.x = overIntX + translate/(sliceDrag*2)
                overInt02.x = overIntX + translate/(sliceDrag*2)
            }
        case .ended:
            onDragIdeal = false
            resetPsition()
        default:
            break
        }
    }
    
    let backBg = CAShapeLayer()
    func setIdealBg(){
        backBg.frame(10, 10, middleView.width-10, middleView.height/2-15)
        backBg.path(backBg.roundCorner(rt: 0, lt: corner, lb: corner, rb: 0))
        backBg.fillColor(skyBlue01)
        idealWeightView.addSublayer(backBg)
        let overBg = CAShapeLayer()
        overBg.frame(20, 10, middleView.width-20, backBg.height)
        overBg.path(overBg.roundCorner(rt: 0, lt: corner, lb: corner, rb: 0))
        overBg.fillColor(gray0)
        idealWeightView.addSublayer(overBg)
    }
    
    //MARK: IDEAL TITLE
    let idealTitle = UILabel()
    func setIdealTitle(){
        idealTitle.frame(isRTL ? width-210 : 30,
                         backBg.y - backBg.height/2,
                         200,
                         backBg.height)
        idealTitle.attributedText(values.ideal)
        idealTitle.numberOfLines(0)
        idealTitle.textAlignment(isRTL ? .right : .left)
        idealWeightView.addSubview(idealTitle)
    }
    
    //MARK: IDEAL NUMBER
    let idealInt = UILabel()
    func setIdealInt(){
        let d: CGFloat = hasSafeArea || isPlus ? 5 : is5 ? -5 : 0
        let height: CGFloat = idealWeightView.height
        let font = UIFont(Sahel, height)!
        idealInt.frame(isRTL ? 20 : 35,
                       backBg.y - backBg.height/2 + d,
                       backBg.width-10,
                       height)
        idealInt.text(values.normalWeight)
        idealInt.font(font)
        idealInt.shadow(CGSize(0, 2), gray13, 0.5, 0.8)
        idealInt.textColor(skyBlue01)
        idealInt.textAlignment(.center)
        idealWeightView.addSubview(idealInt)
    }
    
    let idealInt02 = UILabel()
    func setIdealInt02(){
        idealInt02.frame(idealInt.frame)
        idealInt02.text(values.normalWeight)
        idealInt02.font(idealInt.font)
        idealInt02.textColor(skyBlue02)
        idealInt02.textAlignment(.center)
        let mask = UIView()
        mask.frame(idealInt02.bounds)
        mask.backgroundColor(skyBlue02)
        mask.transformY(idealInt02.height/2)
        idealInt02.mask = mask
        idealWeightView.addSubview(idealInt02)
    }
    
    //MARK: IDEAL KG
    let idealKg = UILabel()
    func setIdealKg(){
        idealKg.frame(isRTL ? 30 : width-210,
                      backBg.y - backBg.height/2,
                      200,
                      backBg.height)
        idealKg.text(values.idealKG)
        idealKg.font(Sahel, 22)
        idealKg.textColor(gray06)
        idealKg.textAlignment(isRTL ? .left : .right)
        idealWeightView.addSubview(idealKg)
    }
    
    //MARK: OVER WEIGHT
    var overWeightView = UIView()
    func setOverWeightView(){
        overWeightView.frame(0, middleView.height/2, middleView.width, middleView.height/2)
        overWeightView.onPan(self, #selector(onPanOver(pan:)))
        setOverBg()
        setOverTitle()
        setOverInt()
        setOverInt02()
        setOverKg()
        middleView.addSubview(overWeightView)
    }
    
    //MARK: PAN OVER
    var onDragOver = false
    @objc func onPanOver(pan: UIPanGestureRecognizer){
        let translation = pan.translation(in: overWeightView)
        switch pan.state {
        case .began:
            onDragOver = true
            if !onDragIdeal {
                getPosition()
            }
        case .changed:
            let translate = translation.x
            let x = overX - translation.x/sliceDrag
            if x > overX && !onDragIdeal {
                idealTitle.x(isRTL ? idealTitleX + translate/sliceDrag : idealTitleX)
                idealKg.x(isRTL ? idealKgX : idealKgX + translate/sliceDrag)
                idealInt.x = idealIntX + translate/(sliceDrag*2)
                idealInt02.x = idealIntX + translate/(sliceDrag*2)
                idealWeightView.x = overX - translation.x/sliceDrag
                overWeightView.x = overX + translate/sliceDrag
                overKg.x(isRTL ? overKgX - translate/sliceDrag : overKgX)
                overTitle.x(isRTL ?  overTitleX : overTitleX - translate/sliceDrag)
                overInt.x = overIntX - translate/(sliceDrag*2)
                overInt02.x = overIntX - translate/(sliceDrag*2)
            }
        case .ended:
            onDragOver = false
            resetPsition()
        default:
            break
        }
    }
    
    var idealX: CGFloat!
    var idealKgX: CGFloat!
    var overTitleX: CGFloat!
    var overX: CGFloat!
    var idealTitleX: CGFloat!
    var idealIntX: CGFloat!
    var overKgX: CGFloat!
    var overIntX : CGFloat!
    func getPosition(){
        idealX = idealWeightView.x
        idealKgX = idealKg.x
        overX = overWeightView.x
        overTitleX = overTitle.x
        idealTitleX = idealTitle.x
        idealIntX = idealInt.x
        overKgX = overKg.x
        overIntX = overInt.x
    }
    
    //MARK: RESET POTISION
    func resetPsition(){
        let curve = curveEaseOut05
        let duration: CFTimeInterval = 0.6
        idealWeightView.animate(x: idealWeightView.width/2, duration, curve)
        overWeightView.animate(x: overWeightView.width/2, duration, curve)
        
        let idealTitleX = isRTL ?
            width - idealTitle.width/2 - 10 :
            idealTitle.width/2 + 30
        idealTitle.animate(x: idealTitleX, duration, curve)
        
        let idealKgX = isRTL ?
            idealKg.width/2 + 30 :
            width - idealKg.width/2 - 10
        idealKg.animate(x: idealKgX, duration, curve)
        
        let spaceIdealInt: CGFloat = isRTL ? 20 : 35
        idealInt.animate(x: idealInt.width/2 + spaceIdealInt, duration, curve)
        idealInt02.animate(x: idealInt.width/2 + spaceIdealInt, duration, curve)
        
        let overKgX = isRTL ?
            overKg.width/2 + 10 :
            width - overKg.width/2 - 30
        overKg.animate(x: overKgX, duration, curve)
        
        let overTitleX = isRTL ?
            width - overTitle.width/2 - 30 :
            overTitle.width/2 + 10
        overTitle.animate(x: overTitleX, duration, curve)
        
        let spaceOverInt: CGFloat = isRTL ? 0 : 15

        overInt.animate(x: overInt.width/2 + spaceOverInt, duration, curve)
        overInt02.animate(x: overInt.width/2 + spaceOverInt, duration, curve)
    }
    
    let backOverBg = CAShapeLayer()
    func setOverBg(){
        backOverBg.frame(0, 5, middleView.width-10, middleView.height/2-15)
        backOverBg.path = backOverBg.roundCorner(rt: corner, lt: 0, lb: 0, rb: corner)
        backOverBg.fillColor(orange01)
        overWeightView.addSublayer(backOverBg)
        let overBg = CAShapeLayer()
        overBg.frame(0, 5, middleView.width-20, middleView.height/2-15)
        overBg.path(overBg.roundCorner(rt: corner, lt: 0, lb: 0, rb: corner))
        overBg.fillColor(gray0)
        overWeightView.addSublayer(overBg)
    }
    
    //MARK: OVER TITLE
    let overTitle = UILabel()
    func setOverTitle(){
        overTitle.frame(isRTL ? self.width - 230 : 10,
                        backOverBg.y - backOverBg.height/2,
                        200,
                        backOverBg.height)
        overTitle.text(values.over)
        overTitle.font(Sahel, 22)
        overTitle.textColor(gray06)
        overTitle.numberOfLines(0)
        overTitle.textAlignment(isRTL ? .right : .left)
        overWeightView.addSubview(overTitle)
    }
    
    //MARK: OVER NUMBER
    let overInt = UILabel()
    func setOverInt(){
        let d: CGFloat = hasSafeArea || isPlus ? 5 : is5 ? -5 : 0
        let height: CGFloat = idealWeightView.height
        overInt.frame(isRTL ? 0 : 15,
                      backOverBg.y - backOverBg.height/2 + d,
                      backOverBg.width-10,
                      height)
        overInt.text(values.overWeight)
        overInt.font(Sahel, height)
        overInt.textColor(orange02)
        overInt.textAlignment(.center)
        overInt.shadow(CGSize(0, 2), gray13, 0.5, 0.8)
        overWeightView.addSubview(overInt)
    }
    
    let overInt02 = UILabel()
    func setOverInt02(){
        overInt02.frame(overInt.frame)
        overInt02.text(values.overWeight)
        overInt02.font(overInt.font)
        overInt02.textColor(orange01)
        overInt02.textAlignment(.center)
        let mask = UIView()
        mask.frame(overInt02.bounds)
        mask.backgroundColor(green02)
        mask.transformY(overInt02.height/2)
        overInt02.mask(mask)
        overWeightView.addSubview(overInt02)
    }
    
    //MARK: OVER KG
    let overKg = UILabel()
    func setOverKg(){
        overKg.frame(isRTL ? 10 : self.width-230,
                     backOverBg.y - backOverBg.height/2,
                     200,
                     backOverBg.height)
        overKg.text(values.idealKG)
        overKg.font(Sahel, 22)
        overKg.textColor(gray06)
        overKg.textAlignment(isRTL ? .left : .right)
        overWeightView.addSubview(overKg)
    }
    
    //MARK: BOTTOM BAR
    var bottomBar = UIView()
    func setBottomView(){
        bottomBar.frame(btmFrame)
        bottomBar.shadow(CGSize(0, -1), gray09, 0.5, 0.7)
//        bottomBar.blurBack(2, 1)
        bottomBar.backgroundColor(skyBlue01)
        setBottomTitle()
        bottomBar.onTap(self, #selector(specialInfo))
        addSubview(bottomBar)
    }
    
    @objc func specialInfo(){
        if isClose{
            isClose = false
            closeView()
            var _:Timer = Timer.schedule(0.1) { _ in
                self.setSpecialView(self.fromView)
            }
        }
    }

    func setSpecialView(_ fromView: String) {
        delegateGeneralInfoView?.setSpecialView(fromView)
    }
    
    //MARK: BOTTOM TITLE
    var bottomTitle = UILabel()
    func setBottomTitle(){
        bottomTitle.frame(0, 0, width, 55)
        bottomTitle.text(values.specialInfo)
        bottomTitle.font(Shabnam, 18)
        bottomTitle.textColor(gray0)
        bottomTitle.shadow(CGSize(0, 1), gray09, 1, 0)
        bottomTitle.textAlignment(.center)
        bottomBar.addSubview(bottomTitle)
    }
    
    //MARK: START VIEW
    func showView(){
        topBar.transformY(-topBar.height)
        topBar.animate(transform: .identity, 0.8, curve, 0.8)
        idealWeightView.transformX(idealWeightView.width)
        idealWeightView.animate(transform: .identity, 0.7, curve, 0.8)
        overWeightView.transformX(-overWeightView.width)
        overWeightView.animate(transform: .identity, 0.7, curve, 0.8)
        bottomBar.transformY(bottomBar.height)
        bottomBar.animate(transform: .identity, 0.7, curve, 0.8)
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        topBar.animate(transformY: -topBar.height, 0.8, curve)
        idealWeightView.animate(transformX: idealWeightView.width, 0.7, curve)
        overWeightView.animate(transformX: -overWeightView.width, 0.7, curve)
        bottomBar.animate(transformY: bottomBar.height, 0.7, curve)
        babyBg.animate(opacity: 0, 0.7, curve)
        var _ = Timer.schedule(1) { _ in self.remove() }
    }
}
