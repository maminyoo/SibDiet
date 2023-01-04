//
//  DateEditor.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/14/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol DateEditorDelegate{
    func onFocusYearEditor()
    func endEditingDateEditor()
    func openMonth()
    func closeMonth()
    func openDay()
    func closeDay()
}

class DateEditor: UIView, DateEditorDelegate, DaysViewDelegate, MonthsViewDelegate, UITextFieldDelegate{
    
    // MARK: DEFINE VALUES
    var delegateDateEditor: DateEditorDelegate?
    func delegate(_ delegate: DateEditorDelegate){
        self.delegateDateEditor = delegate
    }
    
    var title = String()
    func title(_ title: String){
        self.title = title
    }
    
    var date = Date()
    func date(_ date: Date){
        self.date = date
    }
    
    var font = UIFont(Traffic, 20)!
    func font(_ font: UIFont){
        self.font = font
    }
    
    var selectorFont = UIFont(Sahel, 17)!
    func selectorFont(_ font: UIFont){
        self.selectorFont = font
    }
    
    var dateType = "jalali"
    func dateType(_ type: String){
        self.dateType = type
    }
    
    var isSelectedDay: Bool = true
    func isSelectedDay(_ bool: Bool){
        self.isSelectedDay = bool
    }
    
    var dayTitle = "روز"
    func dayTitle(_ title: String){
        self.dayTitle = title
    }
    
    var daysLabel = [String]()
    func daysLabel(_ labels: [String]){
        self.daysLabel = labels
    }
    
    var isSelectedMonth: Bool = true
    func isSelectedMonth(_ bool: Bool){
        self.isSelectedMonth = bool
    }
    
    var monthTitle = "ماه"
    func monthTitle(_ title: String){
        self.monthTitle = title
    }
    
    var monthNumber = String()
    func monthNumber(_ number: String){
        self.monthNumber = number
    }
    
    var monthsLabel = [String]()
    func monthsLabel(_ labels:[String]){
        self.monthsLabel = labels
    }
    
    var monthReplaceCharacters = [String: String]()
   func monthReplaceCharacters(_ characters: [String:String]){
        self.monthReplaceCharacters = characters
    }
    
    var isSelectedYear: Bool = true
    func  isSelectedYear(_ bool: Bool){
        self.isSelectedYear = bool
    }
    
    var yearTitle = "سال"
    func yearTitle(_ title: String){
        self.yearTitle = title
    }
    
    var result = Date()
    func result(_ date: Date){
        self.result = date
    }
    
    var isOpenDay = false
    func isOpenDay(_ bool: Bool){
        self.isOpenDay = bool
    }
    
    var isOpenMonth = false
    func isOpenMonth(_ bool: Bool){
        self.isOpenMonth = bool
    }
    
    var isDisable = false
    func isDisable(_ bool: Bool){
        self.isDisable = bool
    }
    
    var enable = false
    func enable(_ bool: Bool){
        self.enable = bool
    }
    
    var focus = false
    func focus(_ bool: Bool){
        self.focus = bool
    }
    
    var dayResult = String()
    func dayResult(_ dayResult: String){
        self.dayResult = dayResult
    }
    
    var yearResult = String()
    func yearResult(_ yearResult: String){
        self.yearResult = yearResult
    }
    
    var monthResult = String()
    func monthResult(_ monthResult: String){
        self.monthResult = monthResult
    }
    
    let origin = CGAffineTransform(1, 1)
    let duration: CFTimeInterval = 0.5
    var corner: CGFloat = 15
    var daysHeight: CGFloat = 215
    var monthsHeight = CGFloat()
    
    // MARK: INIT VIEW
    func initView(){
        monthsHeight = dateType == "jalali" ? 140 : 155
        
        if !isSelectedDay{
            dayResult(dayTitle)
            monthResult(monthTitle)
        }else{
            dayResult(dayResult)
            if !isSelectedMonth{
                monthResult(monthTitle)
            }else{
                monthResult(monthResult)
            }
        }
        
        setDays()
        setMonths()
        setRightView()
        setLeftView()
        setStopView()
        if !isSelectedDay{
            setOpenDayHelper()
        }
        result = date
    }
    
    var openDayHelper = UIView()
    func setOpenDayHelper(){
        openDayHelper.frame(self.bounds)
        openDayHelper.onTap(self, #selector(openDay))
        addSubview(openDayHelper)
    }
    
    //MARK: DAYS
    var days = DaysView()
    func setDays(){
        var day = isSelectedDay ? dateType == "miladi" ? date.day : date.persianDay : dayResult
        day = isSelectedDay ? Int(day.enNumber)! < 10 ? "0\(day)" : "\(day)" : "\(day)"
        day = isRTL ? day.faNumber : day.enNumber
        dayResult(day)
        days.frame(0, 0, self.width, rightView.height+daysHeight)
        days.corner(corner)
        days.daysHeight(daysHeight)
        days.daysLabel(daysLabel)
        days.selectorFont(selectorFont)
        days.dayResult(dayResult)
        days.closeHeight(rightView.height)
        days.delegate(self)
        days.initView()
        addSubview(days, 0)
    }
    
    //MARK: SELECTED DAY
    func selectedDay(_ dayNumber: String) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        isSelectedDay(true)
        showSlash()
        dayResult(dayNumber)
        if dayEditor.text != dayResult{
            dayEditor.animate(opacity: 0, 0.5, curveEaseIn05)
            var _ = Timer.schedule(0.4) { _ in
                self.dayEditor.text(dayNumber)
                self.dayEditor.animate(opacity: 1, 0.5, curveEaseOut05)
            }
        }
        var _ = Timer.schedule(0.4) { _ in
            self.closeDay()
        }
        convertDate()
    }
    
    //MARK: OPEN DAY
    @objc func openDay() {
        if enable{
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
            isOpenDay(true)
            openDayHelper.isHidden(true)
            let height = rightView.height + daysHeight
            days.animate(height: height, duration, curve)
            days.animate(y: height/2, duration, curve)
            days.openDay()
            delegateDateEditor?.openDay()
            selectedColors()
            dayEditor.textColor(gray00)
        }else{
            closeDay()
        }
    }
    
    //MARK: CLOSE DAY
    func closeDay() {
        if isOpenDay{
            isOpenDay(false)
            if dayResult == dayTitle{
                openDayHelper.isHidden(false)
            }
            let height = rightView.height
            days.animate(height: height, duration, curve)
            days.animate(y: height/2, duration, curve)
            days.closeDay()
            delegateDateEditor?.closeDay()
            endEditingDateEditor()
            var _ = Timer.schedule(0.4) { _ in
                self.dayEditor.textColor(gray07)
            }
            if !isSelectedMonth && isSelectedDay {
                var _ = Timer.schedule(duration) { _ in
                    self.openMonth()
                }
            }
        }
    }
    
    //MARK: MONTHS
    var months = MonthsView()
    func setMonths(){
        let month = isSelectedMonth ? dateType == "miladi" ? date.month : date.persianMonth : monthResult
        monthResult(month)
        months.frame(0, 0, self.width, rightView.height+monthsHeight)
        months.corner(corner)
        months.monthsLabel(monthsLabel)
        months.selectorFont(selectorFont)
        months.monthsHeight(monthsHeight)
        months.monthResult(month)
        months.closeHeight(rightView.height)
        months.delegate(self)
        months.initView()
        addSubview(months, 1)
    }
    
    //MARK: SELECTED MONTH
    func selectedMonth(_ month: String, _ numberMonth: String) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        if !isSelectedMonth && !isSelectedYear{
            yearEditor.animate(opacity: 1, 0.8, curveEaseOut05, 0.3)
            var _ = Timer.schedule(1.0) { _ in
               self.yearEditor.becomeFirstResponder()
            }
        }
        monthNumber(numberMonth)
        isSelectedMonth(true)
        monthResult(month)
        if monthEditor.text != month{
            monthEditor.animate(opacity: 0, 0.5, curveEaseIn05)
            var _ = Timer.schedule(0.4) { _ in
                self.monthEditor.text(month)
                self.monthEditor.animate(opacity: 1, 0.5, curveEaseOut05)
            }
        }
        var _ = Timer.schedule(0.4) { _ in
            self.closeMonth()
        }
        showSlash()
        convertDate()
    }
    
    //MARK: SHOW SLASH
    func showSlash(){
        if isRTL {
            firstSlash.animate(opacity: 1, 0.5, curve, 0.5)
            if isSelectedMonth{
                secendSlash.animate(opacity: 1, 0.5, curve, 0.5)
            }
        }else{
            secendSlash.animate(opacity: 1, 0.5, curve, 0.5)
            if isSelectedMonth{
                firstSlash.animate(opacity: 1, 0.5, curve, 0.5)
            }
        }
    }
    
    //MARK: OPEN MONTH
    @objc func openMonth() {
        if isSelectedDay{
            if enable{
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()
                hiddenMonthTimer.invalidate()
                isOpenMonth(true)
                monthEditor.animate(opacity: 1, 0.3, curve)
                let height = rightView.height+monthsHeight
                months.animate(height: height, duration, curve)
                months.animate(y: height/2, duration, curve)
                months.openMonth()
                delegateDateEditor?.openMonth()
                selectedColors()
                monthEditor.textColor(gray00)
            }else{
                closeMonth()
            }
        }
    }
    
    //MARK: CLOSE MONTH
    var hiddenMonthTimer = Timer()
    func closeMonth(){
        if isOpenMonth{
            isOpenMonth(false)
            let height = rightView.height
            months.animate(height: height, duration, curve)
            months.animate(y: height/2, duration, curve)
            months.closeMonth()
            convertDate()
            endEditingDateEditor()
            delegateDateEditor?.closeMonth()
            var _ = Timer.schedule(0.4) { _ in
                self.monthEditor.textColor(gray07)
            }
        }
    }
    
    //MARK: RIGHT VIEW
    var rightView = UIView()
    func setRightView(){
        rightView.frame(isRTL ? width/3 * 2 : 0,
                        0,
                        width/3,
                        height-4)
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
        textTitle.font(Sahel_Bold, 16)
        textTitle.textAlignment(isRTL ? .left : .right)
        textTitle.text(title)
        rightView.addSubview(textTitle)
    }
    
    //MARK: LEFT VIEW
    let leftView = UIView()
    func setLeftView(){
        leftView.frame(isRTL ? 0 : width/3,
                       0,
                       width - rightView.width + 1,
                       rightView.height)
        setLeftGradient()
        setLeftMask()
        setDayEditor()
        setMonthEditor()
        setYearEditor()
        setSecendSlash()
        setFirstSlash()
        addSubview(leftView)
    }
    
    //MARK: SLASH 01
    let firstSlash = UILabel()
    func setFirstSlash(){
        firstSlash.frame(leftView.width - leftView.width/3 - 3,
                         0,
                         20,
                         leftView.height)
        firstSlash.text("/")
        firstSlash.opacity(isRTL ? isSelectedDay ? 1 : 0 : isSelectedMonth ? 1 : 0)
        firstSlash.textColor(gray07)
        firstSlash.textAlignment(.center)
        leftView.addSubview(firstSlash)
    }
   
    //MARK: SLASH 02
    let secendSlash = UILabel()
    func setSecendSlash(){
        secendSlash.frame(leftView.width/3 - 17,
                         0,
                         20,
                         leftView.height)
        secendSlash.text("/")
        secendSlash.opacity(isRTL ? isSelectedMonth ? 1 : 0 : isSelectedDay ? 1 : 0)
        secendSlash.textColor(gray07)
        secendSlash.textAlignment(.center)
        leftView.addSubview(secendSlash)
    }
    
    //MARK: LEFT GRADIENT
    let leftGradient = CAGradientLayer()
    func setLeftGradient(){
        leftGradient.frame(leftView.bounds)
        leftGradient.colors([gray0, gray01])
        leftGradient.startPoint(0, 0)
        leftGradient.endPoint(0, 1)
        leftView.addSublayer(leftGradient)
    }
    
    //MARK: LEFT MASK
    let leftMask = UIView()
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
    
    //MARK: DAY EDITOR
    let dayEditor = UILabel()
    func setDayEditor(){
        var day = isSelectedDay ? dateType == "miladi" ? date.day : date.persianDay : dayResult
        day = isSelectedDay ? Int(day.enNumber)! < 10 ? "0\(day)" : "\(day)" : "\(day)"
        day = isRTL ? day.faNumber : day.enNumber
        dayEditor.frame(isRTL ? leftView.width - leftView.width/3 : 0,
                        0,
                        leftView.width/3,
                        leftView.height)
        dayEditor.font(Sahel, 21)
        dayEditor.text(day)
        dayEditor.textColor(gray07)
        dayEditor.textAlignment(.center)
        dayEditor.onTap(self, #selector(tapDayB), 1)
        leftView.addSubview(dayEditor)
    }
    
    @objc func tapDayB(){
        if isOpenDay{
            closeDay()
        }else{
            openDay()
        }
    }

    //MARK: MONTH EDITOR
    var monthEditor = UILabel()
    func setMonthEditor(){
        let month = isSelectedMonth ? dateType == "miladi" ? date.month : date.persianMonth : monthResult
        monthEditor.frame(leftView.width - (leftView.width/3 * 2),
                          0,
                          leftView.width/3,
                          leftView.height)
        monthEditor.text(month)
        monthEditor.adjustsFontSizeToFitWidth(true)
        monthEditor.textColor(gray07)
        monthEditor.textAlignment(.center)
        monthEditor.onTap(self, #selector(tapMonth))
        monthEditor.font(Sahel, 21)
        leftView.addSubview(monthEditor)
    }
    
    @objc func tapMonth(){
        if !isOpenMonth{
            openMonth()
        }else{
            closeMonth()
        }
    }
    
    //MARK: YEAR EDITOR
    var yearEditor = UITextField()
    func setYearEditor(){
        var text = yearTitle
        if isSelectedYear || date.year != Date().year{
            text = dateType == "jalali" ? date.persianYear : date.year
        }
        yearEditor.frame(isRTL ? 0 : leftView.width - leftView.width/3,
                         0,
                         leftView.width/3,
                         leftView.height)
        yearEditor.font(UIFont(Sahel, 21)!)
        yearEditor.placeholder(dateType == "jalali" ? "1363" : "1984")
        yearEditor.text(text)
        yearEditor.textColor(gray07)
        yearEditor.keyboardType(.numberPad)
        yearEditor.textAlignment(.center)
        yearEditor.delegate(self)
        yearEditor.tintColor(gray01)
        yearEditor.editingDidBegin(self, #selector(onFocusYear))
        yearEditor.editingChanged(self, #selector(onFocusYear))
        yearEditor.editingDidEnd(self, #selector(callingEndYear))
        leftView.addSubview(yearEditor)
    }
    
    func closeKeyboard(){
        yearEditor.resignFirstResponder()
    }
        
    var first = true
    //MARK: FOCUS YEAR
    @objc func onFocusYear(){
        feedback()
        focus(true)
        let newYear = yearEditor.text!.substring(to: 3).enNumber
        yearEditor.text(dateType == "jalali" ? newYear.faNumber : newYear.enNumber)
        yearEditor.opacity(1)
        closeDay()
        closeMonth()
        
        let nowChar03 = Date().year.substring(from: 2, to: 2)
        let nowChar04 = Date().year.substring(from: 3, to: 3)
        let char01 = newYear.substring(from: 0, to: 0)
        let char02 = newYear.substring(from: 1, to: 1)
        let char03 = newYear.substring(from: 2, to: 2)
        let char04 = newYear.substring(from: 3, to: 3)
        
        if yearEditor.text == yearTitle{
            if dateType == "jalali"{
                yearEditor.text("۱۳")
            }else{
                yearEditor.text("")
            }
        }
   
        if dateType == "jalali"{
            if yearEditor.text == "" || yearEditor.text == "۱" || char03 == "A"{
                yearEditor.text("۱۳")
            }
        }

        if dateType == "miladi"{
            if char01 != "1" && char01 != "2"{
                yearEditor.text("")
            }else if char01 == "2"{
                if char02 != "0"{
                    yearEditor.text(char01)
                }else if char03 != "0" &&
                    char03 != nowChar03 &&
                    char03 != "1"{
                    yearEditor.text(char01+char02)
                }else if char03 == nowChar03 && char04 == nowChar04{
                    yearEditor.text(char01+char02+char03)
                }
            }else{
                if char02 != "9"{
                    yearEditor.text(char01)
                }else if
                    char03 != "9" &&
                    char03 != "8" &&
                    char03 != "7" &&
                    char03 != "6" &&
                    char03 != "5" &&
                    char03 != "4" &&
                    char03 != "3" &&
                    char03 != "2"{
                    yearEditor.text(char01+char02)
                }
            }
        }
        
        isSelectedYear(yearEditor.text!.count == 4)
        yearEditor.textColor(gray00)
        convertDate()
        onFocusYearEditor()
        selectedColors()
    }
    
    
    func feedback(){
        if first {
            first = false
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            generator.impactOccurred()
        }
    }
    
    func onFocusYearEditor() {
        delegateDateEditor?.onFocusYearEditor()
    }
    
    @objc func callingEndYear(){
        first = true
        closeKeyboard()
        yearEditor.textColor(gray07)
        endEditingDateEditor()
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: NUMBER_CHARS).inverted
        return string.rangeOfCharacter(from: invalidCharacters,
                                       options: [],
                                       range: string.startIndex ..< string.endIndex) == nil
    }
    
    //MARK: STOP VIEW
    func setStopView(){
        rightMask.x(isRTL ? -(rightView.width/2+5) : rightView.width*1.5+5)
        rightView.x(isRTL ? width/3 * 2 : rightView.width)
        leftMask.x(isRTL ? leftView.width*1.5+5 : -(leftView.width/2+10))
        leftView.x(isRTL ? width/2 - leftView.width/2 : rightView.width*2+rightView.width/2)
        let height = rightView.height
        days.height(height)
        days.y(height/2)
        days.closeHeight(height)
        months.height(height)
        months.y(height/2)
        months.closeHeight(height)
    }
    
    //MARK: START VIEW
    func startView(delay: CFTimeInterval = 0){
        if !enable{
            enable(true)
            let duration: CFTimeInterval = 1.0
            hiddenTimer.invalidate()
            isHidden(false)
            days.isHidden(false)
            months.isHidden(false)
            if !isSelectedDay{
                monthEditor.animate(opacity: 0, 0.3, curve)
                yearEditor.animate(opacity: 0, 0.3, curve)
            }else {
                monthEditor.animate(opacity: 1, 0.3, curve)
                if !isSelectedMonth{
                    yearEditor.animate(opacity: 0, 0.3, curve)
                }
            }
            rightMask.animate(x: rightView.width/2, duration, curve, delay)
            rightView.animate(x: isRTL ? width/3 * 2 + rightView.width/2 : rightView.width/2,
                              duration, curve, delay)
            leftMask.animate(x: leftView.width/2, duration, curve, delay)
            leftView.animate(x: isRTL ? leftView.width/2 : leftView.width/2 + rightView.width-1,
                             duration, curve, delay)
            days.startView(delay)
            months.startView(delay)
            if !isSelectedMonth && isSelectedDay{
                var _ = Timer.schedule(1.2) { _ in self.openMonth() }
            }
        }
    }
    
    //MARK: CLOSE VIEW
    var hiddenTimer = Timer()
    func closeView(delay: CFTimeInterval = 0){
        if enable{
            enable(false)
            let duration: CFTimeInterval = 0.8
            rightMask.animate(x: isRTL ? -(rightView.width/2 + 5) : rightView.width*1.5,
                              duration, curve, delay)
            rightView.animate(x: isRTL ? width/3 * 2 : rightView.width,
                              duration, curve, delay)
            leftMask.animate(x: isRTL ? leftView.width + leftView.width/2 + 5 : -(leftView.width/2+10),
                             duration, curve, delay)
            leftView.animate(x: isRTL ? width/2 - leftView.width/2 : rightView.width*2 + rightView.width/2,
                             duration, curve, delay)
            days.closeView(delay)
            months.closeView(delay)
            
            if isOpenDay{ closeDay() }
            else{ days.isHidden(true) }
            
            if isOpenMonth{  closeMonth() }
            else{ months.isHidden(true) }
            hiddenTimer = Timer.schedule(duration + delay) { _ in
                self.isHidden(true)
            }
        }
    }
    
    //MARK: END EDITING
    func endEditingDateEditor() {
        convertDate()
        deSelectedColors()
        delegateDateEditor?.endEditingDateEditor()
    }
    
    //MARK: SELECT COLOR
    func selectedColors(){
        rightGradient.animate(colors: [gray01, gray0], 0.8, easeInOut)
        leftGradient.animate(colors: [selectedColor02, selectedColor01], 0.8, easeInOut)
    }
    
    //MARK: DESELECT COLOR
    func deSelectedColors(){
        rightGradient.animate(colors: [gray01, gray02], 0.7, easeInOut)
        leftGradient.animate(colors: [gray0, gray01], 0.7, easeInOut)
    }
    
    //MARK: CONVERT DATE
    func convertDate(){
        let year = yearEditor.text?.enNumber
        let month = monthNumber != "" ? monthNumber : monthResult.replace(monthReplaceCharacters)
        let day = dayResult.enNumber
        let date = "\(year!)-\(month)-\(day)"
        result(dateType == "jalali" ? date.persianDate : date.date)
    }
}
