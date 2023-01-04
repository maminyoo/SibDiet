//
//  DietView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/18/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

protocol DietViewDelegate {
    func selectedDietRow(color: UIColor, row: Int)
    func selectWeed(day: String)
    func updateDiet()
}

class DietView: UIView, DietViewDelegate, FoodCellDelegate, AVAudioPlayerDelegate{
    
    var selected: Bool = false
    
    var delegateDietView: DietViewDelegate?
    func delegate(_ delegate: DietViewDelegate){
        self.delegateDietView = delegate
    }
    
    let diet = profile.diet
    
    var minHeight = CGFloat()
    var maxHeight = CGFloat()
    
    var weekDay = String()
    func weekDay(_ day: String){
        weekDay = day
    }
    
    var selectedRow = Int()
    func selectedRow(_ int : Int){
        selectedRow = int
    }
    
    var breakfast = Food()
    var morningSnack = Food()
    var lunch = Food()
    var eveningSnack = Food()
    var dinner = Food()
    
    let values = DietViewValues()
    
    //MARK: INIT VIEW
    func initView(){
        switch weekDay {
        case SHANBE , Saturday:
            breakfast = diet.breakfast01
            lunch = diet.lunch01
            dinner = diet.dinner01
        case YEKSHANBE , Sunday:
            breakfast = diet.breakfast02
            lunch = diet.lunch02
            dinner = diet.dinner02
        case DOSHANBE , Monday:
            breakfast = diet.breakfast03
            lunch = diet.lunch03
            dinner = diet.dinner03
        case SESHANBE , Tuesday:
            breakfast = diet.breakfast04
            lunch = diet.lunch04
            dinner = diet.dinner04
        case CHARSHANBE , Wednesday:
            breakfast = diet.breakfast05
            lunch = diet.lunch05
            dinner = diet.dinner05
        case PANSHANBE , Thursday:
            breakfast = diet.breakfast06
            lunch = diet.lunch06
            dinner = diet.dinner06
        case JOME , Friday:
            breakfast = diet.breakfast07
            lunch = diet.lunch07
            dinner = diet.dinner07
        default: break
        }
        morningSnack = diet.morningSnack
        eveningSnack = diet.eveningSnack
        
        minHeight = is5 ? 60 : 70
        maxHeight = height - (minHeight * (foods.count-1).toCGFloat)
        setFoodsCells()
        showView()
        select(int: selectedRow)
    }
    
    //MARK: DAY
    var dayLabel:String{
        let now = Date()
        switch weekDay {
        case now.getDay(after: -2).persianWeekDay : return values.beforeYesterday
        case now.getDay(after: -1).persianWeekDay, now.getDay(after: -1).weekDay : return values.yesterday
        case now.weekDay , now.persianWeekDay: return values.today
        case now.getDay(after: 1).persianWeekDay, now.getDay(after: 1).weekDay : return values.tomorrow
        case now.getDay(after: 2).persianWeekDay: return values.afterTomorrow
        default: return weekDay
        }
    }
    
    //MARK: FOODS
    var foods: [Food]{
       var foods = [Food]()
        foods.append(breakfast)
        if diet.hasMorningSnack{ foods.append(diet.morningSnack) }
        foods.append(lunch)
        if diet.hasEveningSnack{ foods.append(diet.eveningSnack) }
        foods.append(dinner)
        return foods
    }
    
    //MARK: IAMGES
    var images:[UIImage]{
        var images = [UIImage]()
        images.append(UIImage(BREAKFAST_IMG)!)
        if diet.hasMorningSnack { images.append(UIImage(MORNINGSNACK_IMG)!) }
        images.append(UIImage(LUNCH_IMG)!)
        if diet.hasEveningSnack { images.append(UIImage(EVENINGSNACK_IMG)!) }
        images.append(UIImage(DINNER_IMG)!)
        return images
    }
    
    //MARK: COLORS
    var colors: [UIColor]{
        var colors = [UIColor]()
        colors.append(breakfastColor)
        if diet.hasMorningSnack { colors.append(morningSnackColor) }
        colors.append(turboColor)
        if diet.hasEveningSnack { colors.append(eveningSnackColor) }
        colors.append(dinnerColor)
        return colors
    }
    
    //MARK: BREADS
    let emtyMutable = NSMutableAttributedString()
    var breads : [NSMutableAttributedString]{
        var breads = [NSMutableAttributedString]()
        breads.append(breakfast.hasBread ? values.breakfastBread : emtyMutable)
        if diet.hasMorningSnack { breads.append(morningSnack.hasBread ? values.morningSnackBread : emtyMutable) }
        breads.append(lunch.hasBread ? values.lunchBread : emtyMutable)
        if diet.hasEveningSnack{ breads.append(eveningSnack.hasBread ? values.eveningBread : emtyMutable) }
        breads.append(dinner.hasBread ? values.dinnerBread : emtyMutable)
        return breads
    }
    
    //MARK: RICES
    var rices : [NSMutableAttributedString]{
        var rices = [NSMutableAttributedString]()
        rices.append(emtyMutable)
        if diet.hasMorningSnack { rices.append(emtyMutable) }
        rices.append(lunch.hasRice ? values.lunchRice : emtyMutable)
        if diet.hasEveningSnack{ rices.append(emtyMutable) }
        rices.append(dinner.hasRice ? values.dinnerRice : emtyMutable)
        return rices
    }
    
    //MARK: MACARONIS
    var macaronis : [NSMutableAttributedString]{
        var macaronies = [NSMutableAttributedString]()
        macaronies.append(emtyMutable)
        if diet.hasMorningSnack { macaronies.append(emtyMutable) }
        macaronies.append(lunch.hasMacaroni ? values.lunchMacaroni : emtyMutable)
        if diet.hasEveningSnack{ macaronies.append(emtyMutable) }
        macaronies.append(dinner.hasMacaroni ? values.dinnerMacaroni : emtyMutable)
        return macaronies
    }
    
    //MARK: FOOD CELL'S
    lazy var foodsCells = [Int: FoodCell]()
    func setFoodsCells(){
        var i = -1
        for food in foods{
            i += 1
            foodsCells[i] = FoodCell()
            foodsCells[i]?.frame(0, minHeight*i.toCGFloat, width, minHeight)
            foodsCells[i]?.imageSrc(images[i])
            foodsCells[i]?.corner(is5 ? 25 : 30)
            foodsCells[i]?.minHeight(minHeight)
            foodsCells[i]?.maxHeight(maxHeight)
            foodsCells[i]?.color(colors[i])
            foodsCells[i]?.meal(values.meals[i])
            foodsCells[i]?.food(food)
            foodsCells[i]?.bread(breads[i])
            foodsCells[i]?.rice(rices[i])
            foodsCells[i]?.macaroni(macaronis[i])
            foodsCells[i]?.weekDay(weekDay)
            foodsCells[i]?.tag(i)
            foodsCells[i]?.dayLabel(dayLabel)
            foodsCells[i]?.onTap(self, #selector(tapCell(tap:)))
            foodsCells[i]?.delegate(self)
            foodsCells[i]?.initView()
            addSubview(foodsCells[i]!)
        }
    }
    
    func select(day: String) {
        closeView()
        selectWeed(day: day)
    }
    
    func selectWeed(day: String){
        delegateDietView?.selectWeed(day: day)
    }
    
    //MARK: TAP CELL
    @objc func tapCell(tap: UITapGestureRecognizer){
        let tag: Int = (tap.view?.tag)!
        if !foodsCells[tag]!.selected{
            playSound(DIET_CELL_SOUND)
            selectedRow = tag
            select(int: tag)
        }
    }
    
    func select(int: Int){
        let duration: CFTimeInterval = 0.6
        for (i , cell)in foodsCells{
            if int == i{
                cell.select()
                let y = maxHeight/2 + minHeight * i.toCGFloat
                cell.animate(height: maxHeight, duration, curve)
                cell.animate(y: y, duration, curve)
                selectedDietRow(color: cell.color, row: int)
            }else{
                cell.deSelect()
                let y = (i < int ? minHeight : maxHeight) + (minHeight * (i-1).toCGFloat) + minHeight/2
                cell.animate(height: minHeight, duration, curve)
                cell.animate(y: y, duration, curve)
            }
        }
    }
    
    func selectedDietRow(color: UIColor, row: Int) {
        delegateDietView?.selectedDietRow(color: color, row: row)
    }
    
    func requestDiet() {
        updateDiet()
    }
    
    func updateDiet() {
        delegateDietView?.updateDiet()
    }
    
    //MARK: SATRT VIEW
    func showView(){
        if !selected{
            selected = true
            let curve = curveEaseOut05
            let index = selectedRow
            for (i , cell) in foodsCells{
                let x = cell.x
                cell.x(x + (isRTL ? width : -width))
                switch i {
                case index           : cell.animate(x: x, 0.6, curve, delay[2])
                case index+1, index-1: cell.animate(x: x, 0.6, curve, delay[3])
                case index+2, index-2: cell.animate(x: x, 0.6, curve, delay[4])
                case index+3, index-3: cell.animate(x: x, 0.6, curve, delay[5])
                case index+4, index-4: cell.animate(x: x, 0.6, curve, delay[6])
                default: break
                }
            }
        }
    }
    
    //MARK: PALYER
    var player: AVAudioPlayer?
    @objc func playSound(_ source: String){
        let generator = UIImpactFeedbackGenerator(style: .light)
             generator.prepare()
             generator.impactOccurred()
        let url = Bundle.main.url(forResource: source, withExtension: CAF_EXTENSION)!
        do {
            let b = AVAudioSession.sharedInstance().isOtherAudioPlaying
            player = try AVAudioPlayer(contentsOf: url)
            if !b{ player?.play() }
        } catch _ as NSError {
        }
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        if selected{
            selected = false
            let curve = curveEaseIn02
            let index = selectedRow
            for (i , cell) in foodsCells{
                let x = isRTL ? width : -width
                switch i {
                case index           : cell.animate(transformX: x, 0.8, curve, delay[0])
                case index+1, index-1: cell.animate(transformX: x, 0.8, curve, delay[1])
                case index+2, index-2: cell.animate(transformX: x, 0.8, curve, delay[2])
                case index+3, index-3: cell.animate(transformX: x, 0.8, curve, delay[3])
                case index+4, index-4: cell.animate(transformX: x, 0.8, curve, delay[4])
                case index+5, index-5: cell.animate(transformX: x, 0.8, curve, delay[5])
                default: break
                }
            }
            var _ = Timer.schedule(delay[foods.count]+2) { _ in self.remove() }
        }
    }
}
