//  Created by amin sadeghian on 12/15/17.
//  Copyright © 2017 maminyoo. All rights reserved.

import UIKit
import QuartzCore
import AVFoundation

protocol DietTableViewDelegate {
    func setDietScene()
    func setFormsScene(_ fromView: String)
    func hideStatus(_ bool: Bool, _ delay: CFTimeInterval)
    func background(_ color: UIColor)
    func setDietTableView()
}

class DietTableView: UIView, AVAudioPlayerDelegate, DietTableViewDelegate, DietTableDelegate, LunchDietDelegate, LoginCloseDelegate, DietTableClose{
    
    var language = settings.language
    
    var helper: String{
        switch language {
        case EN: return "Swipe out the window"
        default: return "پنجره را به بیرون بکشید"
        }
    }
    
    var delegateDietTableView: DietTableViewDelegate?
    
    var enable = false
    func enable(_ bool: Bool){
        self.enable = bool
    }
    
    var closed = false
    func closed(_ bool: Bool){
        self.closed = bool
    }
    
    var originPosition = CGPoint()
    func originPosition(_ point: CGPoint){
        originPosition = point
    }
    
    var tablePosition: CGPoint{
        get{
            let x = standard.object(forKey: "tablePosition.x") as? CGFloat ?? CGFloat()
            let y = standard.object(forKey: "tablePosition.y") as? CGFloat ?? CGFloat()
            return CGPoint(x, y)
        }
        set{
            standard.set(newValue.x, forKey: "tablePosition.x")
            standard.set(newValue.y, forKey: "tablePosition.y")
        }
    }
    
    let SWIPECOUNT = "SWIPECNTR"
    var swipeCount: Int{ standard.integer(forKey: SWIPECOUNT) }
    
    //MARK: INIT VIEW
    func initView(_ delegate: DietTableViewDelegate){
        delegateDietTableView = delegate
        dietConnection.delegateLunchDiet = self
        dietConnection.delegateLoginClose = self
        dietConnection.delegateTableClose = self
        hideStatus(true, 0.1)
        background(ironGrayColor)
        setDietTable()
        startView()
        if swipeCount<14 || swipeCount>14 && swipeCount<21 && swipeCount%2 == 0 { setCalenderHelper() }
        if isWaiting{ dietConnection.loadBackground() }
    }
    
    func background(_ color: UIColor){
        delegateDietTableView?.background(color)
    }
    
    func hideStatus(_ bool: Bool, _ delay: CFTimeInterval){
        delegateDietTableView?.hideStatus(bool, delay)
    }
    
    //MARK: DIET TABLE
    var dietTable = DietTable()
    func setDietTable(){
        let height: CGFloat = 365
        let w: CGFloat = is5 ?  width-10 : height
        dietTable.frame(width/2 - w/2, self.height/2 - w/2, w, height)
        dietTable.cornerRadius(45)  
        dietTable.shadow(.zero, gray14, 5, 1)
        dietTable.backgroundColor(gray01)
        dietTable.delegate(self)
        dietTable.initView()
        originPosition(dietTable.position)
        dietTable.onPan(self, #selector(pan(pan:)))
        addSubview(dietTable)
    }
    
    //MARK: HELPER
    var dietTableHelper = UIView()
    func setCalenderHelper(){
        let font = UIFont(Sahel_Bold, 19)!
        let width = helper.width(height: 50, font: font)+30
        dietTableHelper.frame(self.width/2-width/2, height-90, width, 55)
        let gradient = CAGradientLayer()
        gradient.frame(dietTableHelper.bounds)
        gradient.colors([gray09, gray07])
        gradient.animate(colors: [gray07, gray09], 1, easeOut05, 0.7)
        gradient.cornerRadius(10)
        dietTableHelper.addSublayer(gradient)
        let txt = UILabel()
        txt.frame(dietTableHelper.bounds)
        txt.text(helper)
        txt.textColor(gray02)
        txt.font(Sahel_Bold, 19)
        txt.textAlignment(.center)
        dietTableHelper.addSubview(txt)
        dietTableHelper.shadow(.zero, gray12, 5, 1)
        dietTableHelper.opacity(0)
        dietTableHelper.animate(opacity: 1, 1, curveEaseOut05, 0.7)
        addSubview(dietTableHelper)
    }
    
    //MARK: PAN
    var diteTablePostion: CGPoint!
    @objc func pan(pan: UIPanGestureRecognizer){
        let translation = pan.translation(in: dietTable)
        if !closed{
            switch pan.state {
            case .began:
                diteTablePostion = dietTable.position
            case .changed:
                dietTable.y = diteTablePostion.y + translation.y
                dietTable.x = diteTablePostion.x + translation.x
            case .ended:
                let velocity = pan.velocity(in: dietTable)
                let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
                let slideMultiplier = magnitude / 50
                let slideFactor = 0.1 * slideMultiplier
                let y = dietTable.y + (velocity.y * slideFactor)
                let x = dietTable.x + (velocity.x + slideFactor)
                let position = CGPoint(x, y)
                let time = CFTimeInterval(slideFactor * 2)
                
                let rihgt  = diteTablePostion.x + width
                let left   = diteTablePostion.x - width
                let top    = diteTablePostion.y - height/2 - dietTable.height/2
                let bottom = diteTablePostion.y + height/2 + dietTable.height/2
                
                if position.x > rihgt || position.x < left ||
                    position.y < top || position.y > bottom{
                    dietTable.animate(position: position, time, curveEaseOut04)
                    tablePosition = position
                    UserDefaults.standard.set(swipeCount+1, forKey: SWIPECOUNT)
                    _ = Timer.schedule(0.1) { _ in self.setDietScene() }
                }else{
                    dietTable.animate(position: diteTablePostion, 0.5, 0.6)
                }
            default: break
            }
        }
    }
    
    func lunchNewDiet() {
        closeView()
        setDietTableView()
    }
    
    func setDietTableView(){
        delegateDietTableView?.setDietTableView()
    }
    
    func loginClose() {
        tablePosition = .zero
        closeView()
    }
    
    func closeTable() {
        closeView()
    }
    
    //MARK: CLOSE POSITION
    @objc func setDietScene(){
        dietTableHelper.animate(opacity: 0, 0.5, curveEaseOut05)
        if !closed{
            closed(true)
            enable(false)
            _ = Timer.schedule(1.2) { _ in self.remove() }
            delegateDietTableView?.setDietScene()
        }
    }
    
    //MARK: START VIEW
    func startView(){
        enable(true)
        if tablePosition == .zero{
            dietTable.y -= height/2+dietTable.height/2+10
            dietTable.animate(y: height/2, 1, curveEaseOut05, 0.2)
        }else{
            dietTable.position(tablePosition)
            dietTable.animate(position: originPosition, 1, curveEaseOut05, 0.2)
        }
        var _ = Timer.schedule(0.2) { _ in self.playSound() }
    }
    
    //MARK: PLAYER
    var player: AVAudioPlayer?
    @objc func playSound(){
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        let url = Bundle.main.url(forResource: DIET_TABLE_SOUND,
                                  withExtension: CAF_EXTENSION)!
        do {
            let b = AVAudioSession.sharedInstance().isOtherAudioPlaying
            player = try AVAudioPlayer(contentsOf: url)
            if !b{ player?.play() }
        } catch _ as NSError { }
    }
    
    func requestDiet() {
        setFormsScene(DIET_TABLE_VIEW)
    }
    
    //MARK: REQUEST DIET
    func setFormsScene(_ fromView: String) {
        if !closed{
            dietTableHelper.animate(opacity: 0, 0.5, curveEaseOut)
            closeView()
            _ = Timer.schedule(0.5) { _ in self.delegateDietTableView?.setFormsScene(fromView)
            }
        }
    }
    
    //MARK: CLOSE VIEW
    @objc func closeView(){
        if enable{
            enable(false)
            closed(true)
            let curve = curveEaseInOut04
            dietTableHelper.animate(opacity: 0, 0.5, curveEaseOut)
            if tablePosition == .zero{ dietTable.animate(y: -(height/2+dietTable.height/2+10), 1.2, curve, 0.2) }
            else{ dietTable.animate(position: tablePosition, 1.2, curve, 0.2) }
            _ = Timer.schedule(1.2) { _ in self.remove() }
        }
    }
}
