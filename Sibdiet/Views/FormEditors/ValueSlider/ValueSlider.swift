//
//  ValueSlider.swift
//  Sibdiet

//  Created by Amin Sadeghian on 10/7/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol ValueSliderDelegate {
    func openSlider(_ tag: Int, color: UIColor)
    func closeSlider(_ tag: Int)
    func onRelease()
}

class ValueSliderResult{
    var title = String()
    init(_ title : String) {
        self.title = title
    }
   
    var main: Int{
        get{ standard.integer(forKey: "main\(title)") }
        set{ standard.set(newValue, forKey: "main\(title)") }
    }
  
    var decimal: Int{
        get{ standard.integer(forKey: "decimal\(title)") }
        set{ standard.set(newValue, forKey: "decimal\(title)") }
    }

    var hasResult: Bool{ main>0 }
    var result: String{ "\(main)\(decimal>0 ? ".\(decimal)" : "")" }
    
    func reset(){
        main = Int()
        decimal = Int()
    }
}

class ValueSliderModel{
    var title = String()
    var color = UIColor()
    var unicode = String()
    var mainTitle = String()
    var minMain = Int()
    var maxMain = Int()
    var defaultMain = Int()
    var mainDiv = Int()
    var decimalTitle = String()
    var minDecimal = Int()
    var maxDecimal = Int()
    var decimalDiv = Int()
    var optional = Bool()
    var optionalStr = String()
}

extension ValueSliderModel{
    var mains: [Int]{
        var res = [minMain]
        while res[res.count-1] != maxMain {
            res.append(res[res.count-1]+mainDiv)
        }
        return res
    }
    var decimals: [Int]{
        var res = [minDecimal]
        while res[res.count-1] != maxDecimal {
            res.append(res[res.count-1]+decimalDiv)
        }
        return res
    }
}

class ValueSlider : UIView, ValueSliderDelegate, SliderDelegate{
    
    var delegateValueSlider: ValueSliderDelegate?
    func delegate(_ delegate: ValueSliderDelegate){
        delegateValueSlider = delegate
    }
    
    var enable   = false
    var isOpen   = false
    var autoOpen = false
    var inFirst  = true
    let space            : CGFloat = 10
    var corner           : CGFloat = 20
    var closeHeight      : CGFloat = 70
    var openHeight       : CGFloat = 140
    var rightWidth       : CGFloat { isRTL ? unicode.width : title.width }
    var rightMaxX        : CGFloat{ isRTL ? unicode.maxX : titleView.maxX }
    var cellHeight       : CGFloat { isOpen ? fullHeight : closeHeight }
    var fullHeight       : CGFloat { closeHeight+openHeight }
    var mainIndex        : Int { model.mains.firstIndex(of: result.main) ?? 0 }
    var defaultIndex     : Int { model.mains.firstIndex(of: model.defaultMain)! }
    var selectedMain     : Bool { result.main != Int() }
    var mainWidth        : CGFloat {
        var string = selectedMain ? model.mains[mainIndex].string : model.defaultMain.string
        string = isRTL ? string.faNumber : string
        let fontS = isRTL ? Gandom : Sahel
        let font = UIFont(fontS, foregroundHeight-10)!
        return string.width(height: foregroundHeight-10, font: font)+2
    }
    var mainX            : CGFloat { mainNumbers[mainIndex].x }
    var selectedDecimal  : Bool { result.decimal > 0 }
    var foregroundHeight : CGFloat { foreground.height }
    var mainHolderWidth  : CGFloat { foreground.width/2 }
    var decimalIndex     : Int { model.decimals.firstIndex(of: result.decimal) ?? 0 }
    var decimalWidth     : CGFloat {
        var string = selectedDecimal ? model.decimals[decimalIndex].string : ""
        string = isRTL ? string.faNumber : string
        let fontS = isRTL ? Gandom : Sahel
        let font = UIFont(fontS, foregroundHeight/2-5)!
        return string.width(height: foregroundHeight/2, font: font)+2
    }
    var fullResultWidth : CGFloat { mainWidth + title.width + unicode.width + space*2 + (selectedDecimal ? slash.width+decimalWidth : 0) }
    var resultWidth : CGFloat { mainWidth + (selectedDecimal ? slash.width+decimalWidth : 0) }
    var maxTitleWidth: CGFloat { maxTitle.width(height: 22, font: UIFont(Sahel_Bold , 18)!) }
    
    var maxTitle = String()
    func maxTitle(_ string: String){
        maxTitle = string
    }
    
    var duration = CFTimeInterval()
    func duration(_ time: CFTimeInterval){
        duration = time
    }
    
    var model = ValueSliderModel()
    func model(_ model: ValueSliderModel){
        self.model = model
    }
    var result = ValueSliderResult("")
    func result(_ res: ValueSliderResult){
        result = res
    }
    
    func initView(){
        setBackground()
        setStop()
        fixResultPosition()
        setPositions()
    }
    
    //MARK: BACKGROUND
    var background = UIView()
    func setBackground(){
        background.frame(bounds)
        background.backgroundColor(gray00)
        background.cornerRadius(corner)
        background.clipsToBounds(true)
        setForeground()
        addSubview(background)
    }
    
    //MARK: FOREGROUND
    var foreground = UIView()
    func setForeground(){
        foreground.frame(5, 5, width-10, height-10)
        foreground.backgroundColor(oddColor)
        foreground.cornerRadius(corner-5)
        foreground.clipsToBounds(true)
        setGradient()
        setTitle()
        setUnicode()
        setMain()
        setSlash()
        setDecimal()
        if model.optional && !selectedMain { setOptional() }
        foreground.onTap(self, #selector(tap))
        background.addSubview(foreground, 3)
    }
    
    //MARK: OPTIONAL
    var optional = UILabel()
    func setOptional(){
        let fontS = isRTL ? Gandom : Sahel
        let font  = UIFont(fontS, 16)!
        let width = model.optionalStr.width(height: foregroundHeight, font: font)+10
        optional.frame(5, 0, width, foregroundHeight/2)
        optional.font(font)
        optional.text(model.optionalStr)
        optional.textColor(white02)
        optional.textAlignment(.center)
        foreground.addSubview(optional)
    }
    
    //MARK: MAIN
    var main = UILabel()
    func setMain(){
        var string = selectedMain ? model.mains[mainIndex].string : model.defaultMain.string
        string = isRTL ? string.faNumber : string
        let fontS = isRTL ? Gandom : Sahel
        let font = UIFont(fontS, foregroundHeight-10)!
        let width = string.width(height: foregroundHeight-10, font: font)+2
        let x = isRTL ? unicode.maxX + space : titleView.maxX + space
        main.frame(x, 5, width, foregroundHeight)
        main.text(string)
        main.textAlignment(.center)
        main.font(font)
        main.opacity(selectedMain ? 1 : 0)
        main.textColor(gray06)
        foreground.addSubview(main)
    }
    
    //MARK: GRADIENT
    var gradient = CAGradientLayer()
    func setGradient(){
        gradient.frame(2, 2, foreground.width-4, foreground.height-4)
        gradient.cornerRadius(corner-7)
        gradient.colors([evenColor, oddColor])
        foreground.addSublayer(gradient)
    }
    
    //MARK: MAIN NUMBERS
    lazy var mainNumbersHolder = UIView()
    lazy var mainNumbers = [UILabel]()
    var mainHeight = CGFloat()
    func setMainNumbers(){
        let fontS = isRTL ? Gandom : Sahel
        let font = UIFont(fontS, foregroundHeight-10)!
        var index = -1
        for title in model.mains{
            index += 1
            let label = UILabel()
            let string = isRTL ? title.string.faNumber : title.string
            let width = string.width(height: foregroundHeight-10, font: font)+2
            let y = foregroundHeight*index.toCGFloat + 5
            label.frame(mainHolderWidth/2-width/2, y, width, foregroundHeight)
            label.text(string)
            label.textColor(model.color)
            label.textAlignment(.center)
            label.font(font)
            mainHeight += label.height
            mainNumbers.append(label)
            mainNumbersHolder.addSubview(mainNumbers[index])
        }
        let y = (selectedMain ? mainIndex : defaultIndex).toCGFloat*foregroundHeight
        mainNumbersHolder.frame(0, 0, mainHolderWidth, mainHeight)
        mainNumbersHolder.y(-y+mainHeight/2)
        mainNumbersHolder.x(isRTL ?
            unicode.x+unicode.width/2+space+mainWidth/2 :
            titleView.x+titleView.width/2+space+mainWidth/2)
        mainNumbersHolder.opacity(0)
        foreground.addSubview(mainNumbersHolder, below: main)
    }
    
    //MARK: SLASH
    var slash = UILabel()
    var slashOver = UILabel()
    func setSlash(){
        let fontS = isRTL ? Gandom : Sahel
        let font = UIFont(fontS, foregroundHeight/3*2-14)!
        let string = "/"
        let width = string.width(height: foregroundHeight/3*2-14, font: font)+5
        let right = space + (isRTL ? unicode.maxX + main.width : titleView.maxX + main.width)
        slash.frame(selectedDecimal ? right : foreground.width/2,
                    selectedDecimal ? slash.height/2 + space : foregroundHeight + slash.height/2,
                    width,
                    foregroundHeight-10)
        slash.font(font)
        slash.textColor(gray05)
        slash.textAlignment(.center)
        slash.text(string)
        slashOver.frame(slash.bounds)
        slashOver.text(string)
        slashOver.opacity(0)
        slashOver.textColor(model.color)
        slashOver.font(font)
        slashOver.textAlignment(.center)
        slash.addSubview(slashOver)
        foreground.addSubview(slash)
    }
    
    //MARK: DECIMAL NUMBERS
    lazy var decimalNumbersHolder = UIView()
    lazy var decimalNumbers = [UILabel]()
    var decimalHeight = CGFloat()
    func setDecimalNumbers(){
        let fontS = isRTL ? Gandom : Sahel
        let font = UIFont(fontS, foregroundHeight/2-5)!
        let height = foregroundHeight/2-5
        var index = -1
        for des in model.decimals{
            index += 1
            let view = UIView()
            let label = UILabel()
            let string = des == 0 ? "" : isRTL ? des.string.faNumber : des.string
            let width = string.width(height: foregroundHeight/2, font: font)+2
            view.frame(mainHolderWidth/2-width/2,
                       foregroundHeight*index.toCGFloat,
                       width,
                       foregroundHeight)
            label.frame(0, foregroundHeight/2-5, width, height)
            label.text(string)
            label.font(font)
            label.textColor(model.color)
            label.textAlignment(.center)
            decimalNumbers.append(label)
            view.addSubview(decimalNumbers[index])
            decimalHeight += view.height
            decimalNumbersHolder.addSubview(view)
        }
        let x = slash.x+slash.width
        let y = decimalIndex.toCGFloat*foregroundHeight
        decimalNumbersHolder.frame(x, y, mainHolderWidth, decimalHeight)
        decimalNumbersHolder.x(slash.maxX+decimalWidth/2)
        decimalNumbersHolder.opacity(0)
        decimalNumbersHolder.y(-y+decimalHeight/2)
        foreground.addSubview(decimalNumbersHolder, below: decimal)
    }
    
    //MARK: DECIMAL
    var decimal = UILabel()
    func setDecimal(){
        var string = selectedDecimal ? model.decimals[decimalIndex].string : ""
        string = isRTL ? string.faNumber : string
        let fontS = isRTL ? Gandom : Sahel
        let font = UIFont(fontS, foregroundHeight/2-5)!
        let width = string.width(height: foregroundHeight/2, font: font)+2
        decimal.frame(slash.maxX, 7.5, width, foregroundHeight)
        decimal.text(string)
        decimal.textAlignment(.center)
        decimal.font(font)
        decimal.textColor(gray06)
        foreground.addSubview(decimal)
    }
    
    @objc func tap(){
        if !isOpen{ openSlider(tag, color: model.color) }
        else{ closeSlider(tag) }
    }
    
    //MARK: TITLE
    let titleView = UIView()
    let title = UILabel()
    let titleOFF = UILabel()
    func setTitle(){
        let font = UIFont(Sahel_Bold , 18)!
        let width = model.title.width(height: 22, font: font)
        titleView.frame(!isRTL ? foreground.width/4-width/2 : foreground.width/4*3 - width/2,
                        0,
                        width,
                        foregroundHeight)
        title.frame(titleView.bounds)
        title.text(model.title)
        title.textAlignment(.center)
        title.font(Sahel_Bold, 18)
        title.textColor(model.color)
        title.opacity(0)
        titleOFF.frame(titleView.bounds)
        titleOFF.text(model.title)
        titleOFF.font(Sahel_Bold, 18)
        titleOFF.textColor(gray06)
        titleOFF.textAlignment(.center)
        titleView.addSubview(titleOFF)
        titleView.addSubview(title)
        foreground.addSubview(titleView)
    }
    
    //MARK: UNICODE
    let unicode = UILabel()
    func setUnicode(){
        let font = UIFont(Sahel, 18)!
        let width = model.unicode.width(height: 20, font: font)
        let x = isRTL ? foreground.width/4-width/2 : foreground.width/5*4 - width/2
        unicode.frame(x, foregroundHeight/2 - foregroundHeight/4, width, foregroundHeight/2)
        unicode.text(model.unicode)
        unicode.font(font)
        unicode.textColor(gray05)
        foreground.addSubview(unicode)
    }
    
    //MARK: MAIN SLIDER
    var removeSlider = Timer()
    lazy var mainSlider = Slider()
    func setMainSlider(){
        mainSlider.frame(10, 5, width-20, height-10)
        mainSlider.values(model.mains)
        mainSlider.result(result.main)
        mainSlider.title(model.mainTitle)
        mainSlider.delegate(self)
        mainSlider.color(model.color)
        mainSlider.initView()
        mainSlider.shadow(.zero, gray05, 0.5, 0.6)
        background.addSubview(mainSlider, below: foreground)
    }
    
    //MARK: DECIMAL SLIDER
    lazy var decimalSlider = Slider()
    func setDecimalSlider(){
        decimalSlider.frame(10, 5, width-20, height-10)
        decimalSlider.values(model.decimals)
        decimalSlider.result(result.decimal)
        decimalSlider.title(model.decimalTitle)
        decimalSlider.enable(result.main>0 ? true : false)
        decimalSlider.color(model.color)
        decimalSlider.initView()
        decimalSlider.delegate(self)
        decimalSlider.shadow(.zero, gray05, 0.5, 0.6)
        background.addSubview(decimalSlider, below: foreground)
    }
    
    //MARK: OPEN
    var removedSlider = true
    func openSlider(_ tag: Int, color: UIColor) {
        if !isOpen {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
            isOpen = true
            removeSlider.invalidate()
            if removedSlider{ createList() }
            slashOver.animate(opacity: 1, duration, curve)
            main.animate(opacity:0, duration, curve)
            decimal.animate(opacity:0, duration, curve)
            decimalNumbersHolder.animate(opacity: 1, duration, curve)
            mainNumbersHolder.animate(opacity: selectedMain ? 1 : 0, duration, curve)
            title.animate(opacity: 1, duration, curve)
            background.animate(backgroundColor: gray0, duration, curve)
            foreground.animate(backgroundColor: gray00, duration, curve)
            background.animate(height: fullHeight, duration, curve)
            background.animate(y: fullHeight/2, duration, curve)
            gradient.animate(colors: [white, white], duration, easeInOut05)
            mainSlider.animate(y: foregroundHeight+mainSlider.height/2+15, duration, curve)
            decimalSlider.animate(y: mainSlider.y+decimalSlider.height/2+35, duration, curve)
            let mIndex = selectedMain ? mainIndex : defaultIndex
            let plus: CFTimeInterval = 0.6
            mainSlider.movePointer(index: mIndex, duration+plus)
            mainSlider.moveRuler(index: mIndex, duration+plus)
            mainSlider.pointer.moveRuler(index: mIndex, duration+plus)
            decimalSlider.movePointer(index: decimalIndex, duration+plus)
            decimalSlider.moveRuler(index: decimalIndex, duration+plus)
            decimalSlider.pointer.moveRuler(index: decimalIndex, duration+plus)
            delegateValueSlider?.openSlider(tag, color: model.color)
            fixResultPosition()
        }
    }
    
    //MARK: CRREATE LIST
    func createList(){
        removedSlider = false
        decimalSlider = Slider()
        setDecimalSlider()
        mainSlider = Slider()
        setMainSlider()
        mainNumbersHolder = UIView()
        mainNumbers = [UILabel]()
        setMainNumbers()
        decimalNumbersHolder = UIView()
        decimalNumbers = [UILabel]()
        setDecimalNumbers()
    }
    
    //MARK: CLOSE
    var closeTimer = Timer()
    func closeSlider(_ tag: Int) {
        if isOpen{
            isOpen = false
            setPositions()
            gradient.animate(colors: [evenColor, oddColor], duration, easeInOut05)
            slashOver.animate(opacity: 0, duration, curve)
            main.animate(opacity: selectedMain ? 1 : 0, duration, curve)
            decimal.animate(opacity: selectedDecimal ? 1 : 0, duration, curve)
            title.animate(opacity: 0, duration, curve)
            background.animate(backgroundColor: gray00, duration, curve)
            foreground.animate(backgroundColor: oddColor, duration, curve)
            background.animate(height: closeHeight, duration, curve)
            background.animate(y: closeHeight/2, duration, curve)
            mainSlider.animate(y: mainSlider.height/2+6, duration, curve)
            decimalSlider.animate(y: decimalSlider.height/2+6, duration, curve)
            mainSlider.movePointer(index: 0, duration)
            mainSlider.moveRuler(index: 0, duration)
            mainSlider.pointer.moveRuler(index: 0, duration)
            decimalSlider.movePointer(index: 0, duration)
            decimalSlider.moveRuler(index: 0, duration)
            decimalSlider.pointer.moveRuler(index: 0, duration)
            removeSlider = Timer.schedule(duration+0.1) { _ in self.removeList() }
            delegateValueSlider?.closeSlider(tag)
        }
    }
    
    //MARK: REMOVE LIST
    func removeList(){
        removedSlider = true
        decimalSlider.remove()
        mainSlider.remove()
        for m in mainNumbers{ m.remove() }
        mainNumbersHolder.remove()
        for d in decimalNumbers{ d.remove() }
        decimalNumbersHolder.remove()
    }
    
    //MARK: SET CLOSE POSITION 
    func setPositions(){
        let times: CGFloat = is5 ? 2 : hasSafeArea || isPlus ? 3.5 : isRTL ? 2.5 : 2
        let titleX = isRTL ?
            foreground.width - space*times - maxTitleWidth + title.width/2 :
            space*times + maxTitleWidth - title.width/2
        titleView.animate(x: titleX, duration, curve)
        let unicodeX = isRTL ? space*times + unicode.width/2 : foreground.width - space*times - unicode.width/2
        unicode.animate(x: unicodeX, duration, curve)
        let remainedWidth = foreground.width - maxTitleWidth - space*4 - unicode.width
        let rightX = isRTL ?
            unicode.width + remainedWidth/2 - resultWidth/2 + mainWidth/2 + space*2 :
            maxTitleWidth + space*2 + remainedWidth/2 - resultWidth/2 + mainWidth/2
        mainNumbersHolder.animate(x: rightX, duration, curve)
        let slashX = mainNumbersHolder.x + mainWidth/2 + slash.width/2
        slash.animate(x: slashX, duration, curve)
        let decimalX = mainNumbersHolder.x + mainWidth/2 + slash.width + decimalWidth/2
        decimalNumbersHolder.animate(x: decimalX, duration, curve)
        var mainString = selectedMain ? model.mains[mainIndex].string : model.defaultMain.string
        mainString = isRTL ? mainString.faNumber : mainString
        main.width(mainWidth)
        main.animate(x: mainNumbersHolder.x, duration, curve)
        main.text(mainString)
        var decimalString = selectedDecimal ? model.decimals[decimalIndex].string : ""
        decimalString = isRTL ? decimalString.faNumber : decimalString
        decimal.width(decimalWidth)
        decimal.text(decimalString)
        decimal.animate(x:decimalNumbersHolder.x, duration, curve)
    }
    
    //MARK: SLIDE
    var indexG = Int()
    func slide(title: String , index: Int) {
        if indexG != index{
            indexG = index
            checkFeedback()
        }
        
        optional.animate(transformY: -foregroundHeight, 0.5, curve)
        switch title {
        case model.mainTitle :
            result.main = model.mains[index]
            mainNumbersHolder.animate(opacity: 1, 0.5, curve)
            let y = mainNumbersHolder.height/2 - index.toCGFloat*foregroundHeight
            mainNumbersHolder.animate(y: y, 0.5, curve)
            decimalSlider.enable = true
            decimalSlider.animate(opacity: 1, 0.8, curve)
        case model.decimalTitle :
            result.decimal = model.decimals[index]
            let y = decimalNumbersHolder.height/2 - index.toCGFloat*foregroundHeight
            decimalNumbersHolder.animate(y: y, 0.5, curve)
        default: break
        }
        fixResultPosition()
    }
    
    func checkFeedback(){
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func onRelease(){
        delegateValueSlider?.onRelease()
    }
    
    func setStop(){
        enable = false
    }
    
    func startView(_ delay : CFTimeInterval = 0){
        enable = true
    }
    
    //MARK: FIX POSITION
    func fixResultPosition(){
        let duration: CFTimeInterval = 0.4
        let x = foreground.width/2 - fullResultWidth/2 + rightWidth/2
        if isRTL { unicode.animate(x: x, duration, curve) }
        else { titleView.animate(x: x, duration, curve) }
        let mainX = x + rightWidth/2 + mainWidth/2 + space
        mainNumbersHolder.animate(x: mainX, duration, curve)
        let slashY = selectedDecimal ? slash.height/2 + space : foregroundHeight + slash.height/2
        slash.animate(y: slashY, duration, curve)
        let slashX = mainNumbersHolder.x + mainWidth/2 + slash.width/2
        slash.animate(x: slashX, duration, curve)
        let decimalX = mainNumbersHolder.x + mainWidth/2 + slash.width + decimalWidth/2
        decimalNumbersHolder.animate(x: decimalX, duration, curve)
        let leftWidth = isRTL ? title.width/2 : unicode.width/2
        let leftX = selectedDecimal ?
            decimalNumbersHolder.x + decimalWidth/2 + leftWidth + space :
            mainNumbersHolder.x + mainWidth/2 + leftWidth + space
        if isRTL { titleView.animate(x: leftX, duration, curve) }
        else { unicode.animate(x: leftX, duration, curve) }
        main.animate(x: mainNumbersHolder.x, duration, curve)
        decimal.animate(x:decimalNumbersHolder.x, duration, curve)
    }
    
    //MARK: CLOSE VIEW
    func closeView(_ delay : CFTimeInterval = 0){
        enable = false
        var _:Timer = Timer.schedule(duration+0.8) { _ in self.remove() }
    }
}
