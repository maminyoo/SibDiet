//
//  FoodCell.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/18/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

protocol FoodCellDelegate{
    func requestDiet()
    func select(day: String)
}

class FoodCell: UIView, FoodCellDelegate, AVAudioPlayerDelegate{
   
    var delegateFoodCell: FoodCellDelegate?
    func delegate(_ delegate: FoodCellDelegate){
        self.delegateFoodCell = delegate
    }
    var selected = false
    var enable = true
    
    var imageSrc = UIImage()
    func imageSrc(_ image: UIImage){
        imageSrc = image
    }
    
    var corner = CGFloat()
    func corner(_ corner: CGFloat){
        self.corner = corner
    }
    
    var minHeight = CGFloat()
    func minHeight(_ height : CGFloat){
        minHeight = height
    }
    
    var maxHeight: CGFloat!
    func maxHeight(_ height: CGFloat){
        maxHeight = height
    }
    
    var color = UIColor()
    func color(_ color: UIColor){
        self.color = color
    }
    
    var meal = String()
    func meal(_ meal: String){
        self.meal = meal
    }
    
    var food = Food()
    func food(_ food: Food){
        self.food = food
    }
    
    var bread = NSMutableAttributedString()
    func bread(_ bread: NSMutableAttributedString){
        self.bread = bread
    }
    
    var rice = NSMutableAttributedString()
    func rice(_ rice: NSMutableAttributedString){
        self.rice = rice
    }
    
    var macaroni = NSMutableAttributedString()
    func macaroni(_ macaroni: NSMutableAttributedString){
        self.macaroni = macaroni
    }
    
    var weekDay = String()
    func weekDay(_ day: String){
        weekDay = day
    }
    
    var dayLabel = String()
    func dayLabel(_ day: String){
        dayLabel = day
    }

    var goOut = false
    
    var hasBread :Bool{ food.hasBread }
    var hasRice  :Bool{ food.hasRice }
    
    let backgroudPlusWidth: CGFloat = 55
    let duration : CFTimeInterval = 0.6
    
    let values = FoodCellValues()
    
    func dayResult(_ day : String) -> String{
        switch day {
        case MON: return Monday
        case TUE: return Thursday
        case WED: return Wednesday
        case THU: return Tuesday
        case FRI: return Friday
        case SAT: return Saturday
        case SUN: return Sunday
        default: return day
        }
    }
    
    var toShort: String{
        switch weekDay {
        case Monday : return MON
        case Tuesday: return TUE
        case Wednesday: return WED
        case Thursday: return THU
        case Friday: return FRI
        case Saturday: return SAT
        case Sunday: return SUN
        default: return weekDay
        }
    }
    
    //MARK: INIT VIEW
    func initView(){
        maxHeight = maxHeight - 6
        setBackground()
        if food.freeCompositions{
            descriptionText.opacity = 1
            descriptionBottom.opacity = 0
            compositionText.opacity = 0
        }
    }
    
    //MARK: BACKGROUND
    lazy var background = UIView()
    func setBackground(){
        background.frame(isRTL ? 5 : -(backgroudPlusWidth+5),
                         1,
                         width+backgroudPlusWidth,
                         minHeight-2)
        background.backgroundColor(color)
        background.shadow(CGSize(isRTL ? -2 : 2, 0), gray15, 3, 0)
        background.cornerRadius(corner)
        setForeground()
        setMealTitle()
        setTitleText()
        if hasRice || hasBread{
            setLine()
            setSupplementText()
        }
        addSubview(background)
    }
    
    //MARK: FOREGROUND
    lazy var foreground = UIView()
    func setForeground(){
        foreground.frame(isRTL ? 2 : -2, 0, background.width, background.height)
        foreground.backgroundColor(gray00)
        foreground.shadow(CGSize(isRTL ? -1 : 1, 0), gray08, 0.3, 1)
        foreground.cornerRadius(corner)
        setBetweenView()
        setUpView()
        setImage()
        if compeleteMeal { setDayText() }
        background.addSubview(foreground)
    }
    
    //MARK: UP VIEW
    lazy var upView = UIView()
    func setUpView(){
        upView.frame(0, 0, foreground.width, foreground.height+1)
        upView.cornerRadius(corner)
        upView.backgroundColor(gray01)
        upView.shadow(CGSize(isRTL ? 1 : -1, 1), gray08, 1, 0.6)
        foreground.addSubview(upView)
    }
    
    //MARK: IMAGE
    lazy var image = UIImageView()
    func setImage(){
        let height: CGFloat = self.height-15
        image.frame(isRTL ? 8 : width-8,
                    background.height/2-height/2,
                    height,
                    height)
        image.image(imageSrc)
        image.shadow(.zero, gray08, 3, 0.5)
        image.opacity(0.5)
        foreground.addSubview(image)
    }
    
    //MARK: DAY
    lazy var dayText = UILabel()
    func setDayText(){
        let font = UIFont(Sahel_Bold, is5 ? 14 : 16)!
        let width = dayLabel.width(height: 20, font: font)+10
        dayText.frame(isRTL ? foreground.width-backgroudPlusWidth-13-width : backgroudPlusWidth+11,
                      minHeight-25,
                      width,
                      20)
        dayText.font(font)
        dayText.text(dayLabel)
        dayText.textAlignment(.center)
        dayText.textColor(gray05)
        dayText.opacity(0)
        foreground.addSubview(dayText)
    }
    
    //MARK: MEAL TITLE
    lazy var mealTitle = UILabel()
    func setMealTitle(){
        let font = UIFont(Sahel_Bold, is5 ? 14 : 16)!
        let width = meal.width(height: 20, font: font)+6
        mealTitle.frame(isRTL ? self.width-width-5 : backgroudPlusWidth+3, 0, width, 20)
        mealTitle.font(font)
        mealTitle.textColor(color)
        mealTitle.text(meal)
        mealTitle.opacity(0.5)
        mealTitle.textAlignment(.center)
        mealTitle.shadow(.zero, gray07, 0.3, 0.8)
        mealTitle.clipsToBounds(true)
        background.addSubview(mealTitle)
    }
    
    //MARK: TITLE
    lazy var titleText = UILabel()
    func setTitleText(){
        let font = UIFont(Sahel, is5 ? 17 : 21)!
        let y: CGFloat = is5 ? 18 : 20
        var width = food.titleCorrection.width(height: 26, font: font) + 10
        if width>betweenView.width/5*3{
            width = betweenView.width/5*3
        }
        let x: CGFloat = isRTL ?
            background.width/2 - width/2 - backgroudPlusWidth/2 + image.width/4 :
            background.width/2 - width/2 + backgroudPlusWidth/2 - image.width/4,
        height: CGFloat = !is5 ? 29 : 22
        titleText.frame(x, y, width, height)
        titleText.font(font)
        titleText.textColor(gray07)
        titleText.textAlignment(.center)
        titleText.adjustsFontSizeToFitWidth(true)
        titleText.text(food.titleCorrection)
        titleText.opacity(0.5)
        background.addSubview(titleText)
    }
    
    //MARK: LINE
    lazy var line = CAGradientLayer()
    func setLine(){
        let width: CGFloat =  titleText.width + 100
        line.frame(titleText.x - width/2, minHeight/2, width, 0.5)
        line.colors([UIColor.clear, gray04, UIColor.clear])
        line.locations([0.499, 0.5, 0.501])
        line.startPoint(0, 0)
        line.endPoint(1, 0)
        line.opacity(0)
        background.addSublayer(line)
    }
    
    //MARK: SUPPLEMENT
    lazy var supplementText = UILabel()
    func setSupplementText(){
        supplementText.frame(line.x-(line.width*2)/2, titleText.y + 2, line.width*2, 28)
        supplementText.attributedText(food.hasBread ? bread : food.hasMacaroni ? macaroni : rice)
        supplementText.textAlignment(.center)
        supplementText.opacity(0)
        background.addSubview(supplementText)
    }
    
    //MARK: BETWEEN VIEW
    lazy var betweenView = UIView()
    func setBetweenView(){
        betweenView.frame(isRTL ? 0 : backgroudPlusWidth+11,
                          0,
                          background.width-backgroudPlusWidth-12,
                          background.height)
        betweenView.cornerRadius(corner)
        betweenView.clipsToBounds(true)
        setCompositionText()
        setDescriptionText()
        if profile.diet.dontHaveDiet && !isWaiting || profile.diet.lastDay.toString == Date().toString && !isWaiting{ setUpdateDiet() }
        if food.hasPreparation{ setDescriptionBottom() }
        if compeleteMeal { setDaysContainer() }
        setCloseDescription()
        foreground.addSubview(betweenView)
    }
    
    var compeleteMeal : Bool { meal != "Morning" && meal != "Evening" && meal != "میان وعده" && meal != "عصرانه" }
    
    //MARK: DAYS
    lazy var daysContainar = UIView()
    func setDaysContainer(){
        daysContainar.frame(5, 0, betweenView.width-10, 112)
        daysContainar.clipsToBounds(true)
        setWeekDays()
        todaySign()
        setLines()
        betweenView.addSubview(daysContainar)
    }
    
    let line1 = UIView()
    func setLines(){
        line1.frame(0, daysContainar.height-2, betweenView.width, 1)
        line1.backgroundColor(gray03)
        daysContainar.addSubview(line1)
        let line2 = UIView()
        line2.frame(0, daysContainar.height-1, betweenView.width, 1)
        line2.backgroundColor(gray0)
        daysContainar.addSubview(line2)
    }
    
    lazy var weekdays = [Int : Button]()
    func setWeekDays(){
        var i = -1
        for day in values.weekDays{
            let font = UIFont(Sahel, 15)!
            let width = day.width(height: 20, font: font) + 20
            i += 1
            weekdays[i] = Button()
            weekdays[i]?.frame(daysContainar.width/7 * i.toCGFloat + daysContainar.width/14 - width/2,
                               daysContainar.height - 43,
                               width,
                               is5 ? 38 : 40)
            weekdays[i]?.title(day)
            weekdays[i]?.font(font)
            weekdays[i]?.transformR(-45)
            weekdays[i]?.tag(i)
            weekdays[i]?.selected(toShort == day ? true : false)
            weekdays[i]?.initView()
            weekdays[i]?.onTap(self, #selector(tapDay(tap: )))
            daysContainar.addSubview(weekdays[i]!)
        }
    }
    
    func todaySign(){
        let sign = UILabel()
        sign.frame(daysContainar.width/7 * todayXRow + daysContainar.width/14,
                   daysContainar.height-12,
                   20,
                   20)
        sign.text("●")
        sign.textColor(mint01)
        sign.font(Sahel, 20)
        sign.textAlignment(.center)
        daysContainar.addSubview(sign)
    }
    
    var todayXRow: CGFloat{
        let now = Date().persianWeekDay
        let nowEN = Date().weekDay
        switch language {
        case FA:
            switch now {
            case JOME: return 0
            case PANSHANBE : return 1
            case CHARSHANBE : return 2
            case SESHANBE : return 3
            case DOSHANBE : return 4
            case YEKSHANBE : return 5
            case SHANBE : return 6
            default: return 0
            }
        case EN:
            switch nowEN {
            case Monday: return 0
            case Tuesday : return 1
            case Wednesday : return 2
            case Thursday : return 3
            case Friday : return 4
            case Saturday : return 5
            case Sunday : return 6
            default: return 0
            }
        default: return 0
        }
    }
    
    @objc func tapDay(tap: UITapGestureRecognizer){
        let tag: Int = (tap.view?.tag)!
        for (i, cell) in weekdays{
            if i == tag && !cell.selected && !goOut{
                goOut = true
                select(day: dayResult(cell.title))
            }
        }
    }
    
    func select(day: String) {
        delegateFoodCell?.select(day: day)
    }
    
    //MARK: COMPOSITION
    lazy var compositionText = UITextView()
    func setCompositionText(){
        let font = UIFont(Sahel, is5 ? 14 : hasSafeArea || isPlus ? 16 : 15)!
        let width: CGFloat = betweenView.width-20
        let height: CGFloat = food.composition.height(width: width, font: font)+20
        let remin = maxHeight - minHeight
        let h = maxHeight - line1.y - descriptionBottom.height*2
        compositionText.font(font)
        compositionText.text(food.composition)
        let ht = h > compositionText.paragraphHeight ? h : minHeight + remin/2 - height/2 + 10
        compositionText.frame(10,
                              minHeight + remin/2 - height/2 + 10,
                              width,
                              ht)
        compositionText.textColor(compositionColor)
        compositionText.textAlignment(.center)
        compositionText.backgroundColor(.clear)
        compositionText.isEditable(false)
        compositionText.isSelectable(false)
        betweenView.addSubview(compositionText)
    }
    
    //MARK: DESCREPTION
    lazy var descriptionText = UITextView()
    func setDescriptionText(){
        let isPersian = food.preparationCorrection.isPersianString
        descriptionText.frame(isRTL ? 20 : 5,
                              minHeight-1,
                              betweenView.width-25,
                              maxHeight-minHeight+2)
        descriptionText.isEditable(false)
        descriptionText.isSelectable(false)
        descriptionText.backgroundColor(.clear)
        descriptionText.text(food.preparationCorrection)
        descriptionText.font(Sahel, 18)
        descriptionText.textColor(gray07)
        descriptionText.textAlignment(isPersian ? .right : .left)
        descriptionText.transformY(descriptionText.height)
        betweenView.addSubview(descriptionText)
    }
    
    //MARK: DESCRIPTION BOTTOM
    lazy var descriptionBottom = UILabel()
    var showDes = false
    func setDescriptionBottom(){
        let font  = UIFont(Sahel, 16)!
        let width = values.description.width(height: 20, font: font)+15
        descriptionBottom.frame(isRTL ? 17 : betweenView.width-width-20,
                                maxHeight - 32,
                                width,
                                20)
        descriptionBottom.text(values.description)
        descriptionBottom.font(font)
        descriptionBottom.textColor(gray0)
        descriptionBottom.textAlignment(.center)
        descriptionBottom.backgroundColor(gray10)
        descriptionBottom.cornerRadius(5)
        descriptionBottom.clipsToBounds(true)
        descriptionBottom.onTap(self, #selector(showDescription))
        betweenView.addSubview(descriptionBottom)
    }
    
    //MARK: SHOW DESCRIPTION
    @objc func showDescription(){
        showDes = true
        daysContainar.animate(transformY: -daysContainar.height, duration, curve, 0.4)
        compositionText.animate(opacity: 0,  duration, curve)
        updateDiet.animate(transformY: 50,  duration, curve, 0.3)
        descriptionText.animate(transform: .identity, duration, curve, 0.3)
        descriptionBottom.animate(transformY:  -descriptionText.height, duration, curve, 0.3)
        closeDescription.animate(transformY: minHeight/2+15, duration, curveEaseOut04, 0.5)
    }
    
    //MARK: CLOSE DESCRIPTION
    lazy var closeDescription = UIImageView()
    func setCloseDescription(){
        closeDescription.frame(isRTL ? 5 : betweenView.width - 28, minHeight/2-10, 25, 20)
        closeDescription.image(UIImage(UP_IMG)!)
        closeDescription.onTap(self, #selector(closeDescriptionText))
        betweenView.addSubview(closeDescription)
    }
    
    @objc func closeDescriptionText(){
        showDes = false
        daysContainar.animate(transform: .identity, duration, curve)
        descriptionText.animate(transformY: descriptionText.height, duration, curve)
        descriptionBottom.animate(transform: .identity, duration, curve)
        closeDescription.animate(transform: .identity, duration, curve)
        updateDiet.animate(transform: .identity, duration, curve)
        compositionText.animate(opacity: 1, duration, curve, 0.3)
    }
    
    //MARK: UPDATE DIET
    lazy var updateDiet = UILabel()
    func setUpdateDiet(){
        let font = UIFont(Sahel_Bold, 16)!
        let width = values.request.width(height: 20, font: font)+20
        updateDiet.frame(isRTL ? betweenView.width - width - 10 : 15,
                         maxHeight - 35,
                         width,
                         25)
        updateDiet.backgroundColor(color)
        updateDiet.text(values.request)
        updateDiet.textColor(gray0)
        updateDiet.clipsToBounds(true)
        updateDiet.font(font)
        updateDiet.textAlignment(.center)
        updateDiet.cornerRadius(5)
        updateDiet.shadow(CGSize(0, 1), gray11, 0.5, 0.6)
        betweenView.addSubview(updateDiet)
        updateDiet.onTap(self, #selector(requestDiet))
    }
    
    @objc func requestDiet() {
        if !goOut{
            goOut = true
            delegateFoodCell?.requestDiet()
        }
    }

    //MARK: SELECT
    func select(){
        for (_ , cell) in weekdays{ cell.shadow(.zero, gray09, 2, 0.5) }
        selected = true
        enable = false
        background.layer.animate(shadowOpacity: 1, duration, easeInOut05)
        background.animate(transform: .identity, duration, curve)
        background.animate(height: maxHeight, duration, curve)
        background.animate(y: maxHeight/2 + 3, duration, curve)
        foreground.animate(height: maxHeight, duration, curve)
        foreground.animate(y: background.height/2, duration, curve)
        foreground.animate(transformX: isRTL ? 5 : -5, duration, curve)
        upView.animate(backgroundColor: gray0, duration, curve)
        betweenView.animate(height: maxHeight, duration, curve)
        betweenView.animate(y: background.height/2, duration, curve)
        daysContainar.animate(transform: .identity, duration, curve)
        descriptionBottom.animate(transform: .identity, duration, curve)
        mealTitle.animate(opacity: 1, 0.6, curve)
        mealTitle.animate(transform: CGAffineTransform(isRTL ? -2 : 2 , 2), duration, curve)
        dayText.animate(opacity: 1, duration, curve)
        image.animate(opacity: 1, duration, curve)
        titleText.animate(opacity: 1, duration, curve)
        titleText.animate(transform: hasRice || hasBread ? CGAffineTransform(y: -(titleText.height/2+3)) : .identity, duration, curve)
        line.animate(locations: [0.15, 0.5, 0.85], duration, easeInOut05, 0.2)
        line.animate(opacity: 1, 0.2, easeInOut05)
        supplementText.animate(opacity: 1, duration, curve)
        updateDiet.animate(opacity: 1, duration, curve, 1)
    }
    
    //MARK: DESELECT
    func deSelect(){
        selected = false
        let height = minHeight - 1
        background.layer.animate(shadowOpacity: 0, duration, easeInOut05)
        background.animate(transformX: isRTL ? 10 : -10, duration, curve)
        background.animate(height: height , duration, curve)
        background.animate(y: minHeight/2 , duration, curve)
        foreground.animate(height: height, duration, curve)
        foreground.animate(y: height/2, duration, curve)
        foreground.animate(transform: .identity, duration, curve)
        mealTitle.animate(opacity: 0.6, duration, curve)
        mealTitle.animate(transformX: isRTL ? -10 : 11, duration, curve)
        dayText.animate(opacity: 0, duration, curve)
        upView.animate(backgroundColor: gray01, duration, curve)
        betweenView.animate(height: height, duration, curve)
        betweenView.animate(y: height/2, duration, curve)
        daysContainar.animate(transformY:  -minHeight/2, duration, curve)
        descriptionBottom.animate(transformX: isRTL ?  betweenView.width/2 : -betweenView.width, duration, curve)
        image.animate(opacity: 0.5, duration, curve)
        titleText.animate(opacity: 0.5, duration, curve)
        titleText.animate(transform: .identity, duration, curve)
        line.animate(locations: [0.499, 0.5, 0.501], duration, easeInOut05)
        line.animate(opacity: 0, duration,  easeInOut05)
        supplementText.animate(opacity: 0, duration, curve)
        updateDiet.animate(opacity: 0, duration, curve)
        if showDes { closeDescriptionText() }
    }
}
