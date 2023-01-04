//
//  PrescriptionsView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/26/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

protocol PrescriptionsViewDelegate {
    func selectPrescriptionsRow(color: UIColor, row: Int)
}

class PrescriptionsView: UIView, PrescriptionsViewDelegate, AVAudioPlayerDelegate{
    
    var selected: Bool = false

    var delegateSelectedPrescriptionsRow: PrescriptionsViewDelegate?
    func delegate(_ delegate: PrescriptionsViewDelegate){
        self.delegateSelectedPrescriptionsRow = delegate
    }
    
    var selectedRow = Int()
    func selectedRow(_ int: Int){
        self.selectedRow = int
    }
    
    let prescriptions = profile.prescriptions
    
    var titles: [String]{ [prescriptions.dietTitle,
                           prescriptions.activityTitle,
                           prescriptions.dairyTitle,
                           prescriptions.fruitTitle,
                           prescriptions.sweetenerTitle] }
    
    var descriptions: [String]{ [prescriptions.specialRecommendationCorrection,
                                 prescriptions.activityDescriptionCorrection,
                                 prescriptions.dairyDescriptionCorrection,
                                 prescriptions.fruitDescriptionCorrection,
                                 prescriptions.sweetenerDescriptionCorrection] }
    
    var amount: [NSMutableAttributedString] { [NSMutableAttributedString(),
                                               values.activityAmount,
                                               values.dairyAmount,
                                               values.fruitAmount,
                                               values.sweetenerAmount] }
    
    var colors: [UIColor] { [specialRecommendationColor, activityColor, dairyColor, fruitColor, sweetenerColor] }
    var images: [String] { [SPECIAL_IMG, ACTIVITY_IMG, DAIRY_IMG, FRUIT_IMG, SWEET_IMG]}
    
    var minHeight = CGFloat()
    var maxHeight: CGFloat = 0
    let values = PrescriptionsViewValues()
    
    //MARK: INIT VIEW
    func initView(){
        minHeight = is5 ? 60 : isiPad ? 100 : 70
        maxHeight = height - (minHeight*4)
        setPrescriptionCells()
        showView()
        select(int: selectedRow)
    }
    
    //MARK: PRESCRIPTION CELL'S
    var prescriptionCells = [Int : PrescriptionCell]()
    func setPrescriptionCells(){
        var i: Int = -1
        for baseTitle in values.baseTitles{
            i += 1
            prescriptionCells[i] = PrescriptionCell()
            prescriptionCells[i]?.frame(0, minHeight*i.toCGFloat, width, minHeight)
            prescriptionCells[i]?.maxHeight(maxHeight)
            prescriptionCells[i]?.minHeight(minHeight)
            prescriptionCells[i]?.baseTitle(baseTitle)
            prescriptionCells[i]?.amount(amount[i])
            prescriptionCells[i]?.title(titles[i])
            prescriptionCells[i]?.color(colors[i])
            prescriptionCells[i]?.descriptions(descriptions[i])
            prescriptionCells[i]?.image(images[i])
            prescriptionCells[i]?.corner(is5 ? 25 : 30)
            prescriptionCells[i]?.tag(i)
            prescriptionCells[i]?.initView()
            prescriptionCells[i]?.onTap(self, #selector(tapCell(tap:)))
            addSubview(prescriptionCells[i]!)
        }
    }
    
    //MARK: TAP
    @objc func tapCell(tap: UITapGestureRecognizer){
        let tag: Int = (tap.view?.tag)!
        if !prescriptionCells[tag]!.selected{
            playSound(DIET_CELL_SOUND)
            selectedRow = tag
            select(int: tag)
        }
    }
    
    func select(int: Int){
        
        for (i , cell)in prescriptionCells{
            if int == i{
                cell.select()
                let y = maxHeight/2 + minHeight * i.toCGFloat
                cell.animate(height: maxHeight, 0.6, curve)
                cell.animate(y: y, 0.6, curve)
                selectPrescriptionsRow(color: cell.color, row: i)
            }else{
                cell.deSelect()
                let y = (i < int ? minHeight : maxHeight) + (minHeight * (i-1).toCGFloat) + minHeight/2
                cell.animate(height: minHeight, 0.6, curve)
                cell.animate(y: y, 0.6, curve)
            }
        }
    }
    
    func selectPrescriptionsRow(color: UIColor, row: Int) {
        delegateSelectedPrescriptionsRow?.selectPrescriptionsRow(color: color, row: row)
    }
    
    //MARK: START VIEW
    func showView(){
        if !selected{
            selected = true
            let curve = curveEaseOut05
            let index = selectedRow
            for (i , cell) in prescriptionCells{
                let x = cell.x
                cell.x(x + (isRTL ? width : -width))
                cell.opacity(0.7)
                cell.animate(opacity: 1, 2, curve, delay[i+2])
                switch i {
                case index: cell.animate(x: x, 0.6, curve, delay[2])
                case index+1, index-1: cell.animate(x: x, 0.6, curve, delay[3])
                case index+2, index-2: cell.animate(x: x, 0.6, curve, delay[4])
                case index+3, index-3: cell.animate(x: x, 0.6, curve, delay[5])
                case index+4, index-4: cell.animate(x: x, 0.6, curve, delay[6])
                default: break
                }
            }
        }
    }
    
    //MARK: PLAYER
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
            for (i , cell) in prescriptionCells{
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
            var _ = Timer.schedule(delay[prescriptionCells.count]+2) { _ in self.remove() }
        }
    }
}
