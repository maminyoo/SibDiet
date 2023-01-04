//
//  SelectorSwitch.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/18/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol SwitchValuesDelegate{
    func openSwitchValues(cell: String)
    func closeSwitchValues(cell: String)
}

class SwitchValues: UIView, SwitchValuesDelegate{
    
    var delegateSelectorSwitch: SwitchValuesDelegate?
    func delegate(_ delegate: SwitchValuesDelegate){
        self.delegateSelectorSwitch = delegate
    }
    
    var openHeight: CGFloat = 80
    var corner: CGFloat = 15

    var xRow: Int = 0
    func xRow(_ int: Int){
        self.xRow = int
    }
    
    var yRow: Int = 0
    var remainingCell: Int = 0
    
    var title: String!
    func title(_ title: String){
        self.title = title
    }
    
    var result = String()
    func result(_ result: String){
        self.result = result
    }
    
    var options = [String]()
    func options(_ options: [String]){
        self.options = options
    }
    
    var isDisable = false
    func isDisable(_ bool : Bool){
        self.isDisable = bool
    }
    
    var enable = false
    func enable(_ bool: Bool){
        self.enable = bool
    }
    
    var isOpen = false
    func isOpen(_ bool: Bool){
        self.isOpen = bool
    }
    
    var selected = true
    func selected(_ bool: Bool){
        self.selected = bool
    }
    
    var autoOpen = true
    func autoOpen(_ bool: Bool){
        self.autoOpen = bool
    }
    
    func reset(){
        result("")
        selected = false
        selectEditor.text("")
        for (_, cell) in optionCells{ cell.deSelect() }
    }
    
    //MARK: INIT VIEW
    func initView(){
        if options.count >= xRow{
            let row = options.count/xRow
            yRow += row
            remainingCell = options.count%xRow
            if remainingCell > 0 {
                yRow += 1
            }
            switch yRow {
            case 1: openHeight = 85
            case 2: openHeight = 150
            case 3: openHeight = 185
            default: openHeight = 240
            }
        }
        setAnswersView()
        setRightView()
        setLeftView()
        setStopView()
    }
    
    //MARK: RIGHT VIEW
    var rightView = UIView()
    func setRightView(){
        rightView.frame(isRTL ? width/3 * 2 : 0,
                        0,
                        width/3,
                        height-4)
        rightView.onTap(self, #selector(tapSelect))
        setRightGradient()
        setRightMask()
        setTextTitle()
        addSubview(rightView)
    }
    
    //MARK: RIGHT GRADIENT
    var rightGradient = CAGradientLayer()
    func setRightGradient(){
        rightGradient.frame(rightView.bounds)
        rightGradient.colors([gray01, gray02])
        rightGradient.startPoint(0, 0)
        rightGradient.endPoint(0, 1)
        rightView.addSublayer(rightGradient)
    }
    
    //MARK: RIGHT MASK
    var rightMask = UIView()
    func setRightMask(){
        rightMask.frame(rightView.bounds)
        let rightShape = CAShapeLayer()
        rightShape.frame(rightMask.bounds)
        let path = isRTL ?
            rightShape.roundCorner(rt: corner, lt: 0, lb: 0, rb: corner) :
            rightShape.roundCorner(rt: 0, lt: corner, lb: corner, rb: 0)
        rightShape.path(path)
        rightMask.addSublayer(rightShape)
        rightView.mask(rightMask)
    }
    
    //MARK: TITLE
    var textTitle = UILabel()
    func setTextTitle(){
        textTitle.frame(5,
                        rightView.y-rightView.height/2,
                        rightView.width-10,
                        rightView.height)
        textTitle.textColor(gray07)
        textTitle.font(UIFont(Sahel_Bold, 16)!)
        textTitle.textAlignment(isRTL ? .left : .right)
        textTitle.text(title)
        rightView.addSubview(textTitle)
    }
    
    //MARK: LEFT VIEW
    var leftView = UIView()
    func setLeftView(){
        leftView.frame(isRTL ? 0 : width/3,
                       0,
                       width - rightView.width + 1,
                       rightView.height)
        setLeftGradient()
        setLeftMask()
        setSelectEditor()
        addSubview(leftView)
    }
    
    //MARK: LEFT GRADIENT
    var leftGradient = CAGradientLayer()
    func setLeftGradient(){
        leftGradient.frame(leftView.bounds)
        leftGradient.colors([gray0, gray01])
        leftGradient.startPoint(0, 0)
        leftGradient.endPoint(0, 1)
        leftView.addSublayer(leftGradient)
    }
    
    //MARK: LEFT MASK
    var leftMask = UIView()
    func setLeftMask(){
        leftMask.frame(leftView.bounds)
        let leftShape = CAShapeLayer()
        leftShape.frame(leftMask.bounds)
        let path = isRTL ?
            leftShape.roundCorner(rt: 0, lt: corner, lb: corner, rb: 0) :
            leftShape.roundCorner(rt: corner, lt: 0, lb: 0, rb: corner)
        leftShape.path(path)
        leftMask.addSublayer(leftShape)
        leftView.mask(leftMask)
    }
    
    //MARK: SELECT
    var selectEditor = UILabel()
    func setSelectEditor(){
        selectEditor.frame(20,
                          0,
                          leftView.width - 40,
                          leftView.height)
        selectEditor.text(result)
        selectEditor.opacity(isDisable ? 0.7 : 1)
        selectEditor.textColor(gray07)
        selectEditor.textAlignment(.center)
        selectEditor.onTap(self, #selector(tapSelect))
        selectEditor.font(Sahel, 19)
        leftView.addSubview(selectEditor)
    }
    
    @objc func tapSelect(){
        if !isOpen{ open()
        }else{ close() }
    }
    
    //MARK: OPEN
    let duration: CFTimeInterval = 0.5
    @objc func open() {
        if enable && canOpen && !isDisable{
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
            hiddenTimer.invalidate()
            answersView.isHidden(false)
            isOpen(true)
            selectedColors()
            selectEditor.textColor(gray00)
            let height = rightView.height + openHeight
            let holderY = rightView.height + openHeight/2
            answersView.animate(height: height, duration, curve)
            answersView.animate(y: height/2, duration, curve)
            cellsHolder.animate(y: holderY, duration, curve)
            openSwitchValues(cell: title)
        }else{
            close()
        }
    }
    
    func openSwitchValues(cell: String) {
        delegateSelectorSwitch?.openSwitchValues(cell: cell)
    }
    
    //MARK: CLOSE
    var hiddenTimer = Timer()
    func close() {
        if isOpen{
            isOpen(false)
            answersView.animate(height: rightView.height, duration, curve)
            answersView.animate(y: rightView.height/2, duration, curve)
            cellsHolder.animate(y: openHeight/2, duration, curve)
            deSelectedColors()
            closeSwitchValues(cell: title)
            hiddenTimer = Timer.schedule(duration) { _ in
                self.answersView.isHidden(true)
            }
            var _ = Timer.schedule(0.4) { _ in
                self.selectEditor.textColor(gray07)
            }
        }
    }
    
    func closeSwitchValues(cell: String) {
        delegateSelectorSwitch?.closeSwitchValues(cell: cell)
    }
    
    //MARK: ANSWER VIEW
    var answersView = UIView()
    func setAnswersView(){
        answersView.frame(0, 0, width, rightView.height+openHeight)
        answersView.backgroundColor(gray01)
        answersView.cornerRadius(corner)
        answersView.border(gray00, 4)
        answersView.clipsToBounds(true)
        setCellsHolder()
        addSubview(answersView)
    }
    
    //MARK: HOLDER
    var cellsHolder = UIView()
    func setCellsHolder(){
        cellsHolder.frame(5, 0, width-10, openHeight)
        answersView.addSubview(cellsHolder)
        setOptionCells()
    }
    
    //MARK: CELL'S
    var optionCells = [Int: Button]()
    func setOptionCells(){
        var j = -1
        var i = xRow
        var k = -1
        var rowY = 1
        let row = CGFloat(xRow)
        var y: CGFloat = 20
        var lastRow = 0
        for option in options{
            j += 1
            i -= 1
            k += 1
            if i == -1{
                rowY += 1
                y += 60
                i = xRow
                i -= 1
            }
            if rowY == yRow && options.count != xRow{
                let distance = xRow - remainingCell
                lastRow = isRTL ? (xRow - remainingCell)/2 + distance : (xRow + remainingCell)/2 + distance
            }
            optionCells[j] = Button()
            let font = UIFont(Sahel, 17)!
            let width = option.width(height: 20, font: font) + 20
            let index = isRTL ? i : k
            var x: CGFloat = cellsHolder.width/row * CGFloat(index) + cellsHolder.width/(row*2) - width/2
            if lastRow != 0{
                let row : CGFloat = CGFloat(remainingCell)
                x = cellsHolder.width/row * CGFloat(index-lastRow) + cellsHolder.width/(row*2) - width/2
            }
            let w: CGFloat = width,
            h: CGFloat = 40
            optionCells[j]?.frame(x, y, w, h)
            optionCells[j]?.title(option)
            optionCells[j]?.transformR(-45)
            optionCells[j]?.tag(j)
            optionCells[j]?.shadow(.zero, gray09, 0.7, 1)
            optionCells[j]?.initView()
            if option == result{
                optionCells[j]?.select()
            }
            optionCells[j]?.onTap(self, #selector(onTaped(tap:)), 1)
            cellsHolder.addSubview(optionCells[j]!)
        }
    }
    
    //MARK: TAP
    @objc func onTaped(tap: UITapGestureRecognizer){
        let tag: Int = (tap.view?.tag)!
        let option = (optionCells[tag]?.title)!
        selected(true)
        result(option)
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        if selectEditor.text != option{
            selectEditor.animate(opacity: 0, 0.5, curveEaseIn05)
            var _ = Timer.schedule(0.4) { _ in
                self.selectEditor.text(option)
                self.selectEditor.animate(opacity: 1, 0.5, curveEaseOut05)
            }
        }
        for (i, cell) in optionCells{
            if i == tag{
                cell.select()
            }else{
                cell.deSelect()
            }
        }
        var _ = Timer.schedule(0.4) { _ in
            self.close()
        }
    }
    
    //MARK: STOP
    func setStopView(){
        isHidden(true)
        rightMask.x(isRTL ? -(rightView.width/2+5) : rightView.width*1.5+5)
        rightView.x(isRTL ? width/3 * 2 : rightView.width)
        leftMask.x(isRTL ? leftView.width*1.5+5 : -(leftView.width/2+10))
        leftView.x(isRTL ? width/2 - leftView.width/2 : rightView.width*2+rightView.width/2)
        let height = rightView.height
        answersView.height(height)
        answersView.y(height/2)
        cellsHolder.y(openHeight/2)
        answersView.width(0)
        answersView.x(self.width/2)
    }
    
    //MARK: START VIEW
    var canOpen = false
    func startView(delay: CFTimeInterval = 0){
        let duration: CFTimeInterval = 1.0
        hiddenTimer.invalidate()
        isHidden(false)
        enable(true)
        rightMask.animate(x: rightView.width/2, 1.0, curve, delay)
        rightView.animate(x: isRTL ? width/3 * 2 + rightView.width/2 : rightView.width/2,
                          duration, curve, delay)
        leftMask.animate(x: leftView.width/2, 1.0, curve, delay)
        leftView.animate(x: isRTL ? leftView.width/2 : leftView.width/2 + rightView.width-1,
                         duration, curve, delay)
        answersView.animate(width: width, duration, curve, delay+0.1)
        answersView.animate(x: width/2, duration, curve, delay)
        if !selected && autoOpen{
            var _ = Timer.schedule(0.8 + delay) { _ in
                self.open()
            }
        }
        var _ = Timer.schedule(0.7 + delay) { _ in
            self.canOpen = true
        }
    }
    
    //MARK: CLOSE VIEW
    func closeView(delay: CFTimeInterval = 0){
        if enable{
            let duration: CFTimeInterval = 0.8
            enable(false)
            canOpen = false
            rightMask.animate(x: isRTL ? -(rightView.width/2 + 5) : rightView.width*1.5,
                              duration, curve, delay)
            rightView.animate(x: isRTL ? width/3 * 2 : rightView.width,
                              duration, curve, delay)
            leftMask.animate(x: isRTL ? leftView.width + leftView.width/2 + 5 : -(leftView.width/2+10),
                             duration, curve, delay)
            leftView.animate(x: isRTL ? width/2 - leftView.width/2 : rightView.width*2 + rightView.width/2,
                             duration, curve, delay)
            answersView.animate(width: 0, duration, curve, delay)
            answersView.animate(x: width/2, duration, curve, delay)
            close()
            hiddenTimer = Timer.schedule(0.8 + delay) { _ in
                self.isHidden(true)
            }
        }
    }
    
    //MARK: SELECT COLOR
    @objc func selectedColors(){
        rightGradient.animate(colors: [gray01, gray0], 0.8, easeInOut)
        leftGradient.animate(colors: [selectedColor02, selectedColor01], 0.8, easeInOut)
    }
    
    //MARK: DESELECT COLOR
    func deSelectedColors(){
        rightGradient.animate(colors: [gray01, gray02], 0.7, easeInOut)
        leftGradient.animate(colors: [gray0, gray01], 0.7, easeInOut)
    }
}

