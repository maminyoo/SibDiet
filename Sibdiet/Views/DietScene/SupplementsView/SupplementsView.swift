//
//  SupplementsView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/1/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

protocol SupplementsViewDelegate {
    func selectedSupplementsRow(color: UIColor, row: Int)
}

class SupplementsView: UIView, SupplementsViewDelegate, AVAudioPlayerDelegate{

    var delegateSelectedSupplementRow: SupplementsViewDelegate?
    func delegate(_ delegate: SupplementsViewDelegate){
        self.delegateSelectedSupplementRow = delegate
    }
    
    var selectedRow = Int()
    func selectedRow(_ int : Int){
        self.selectedRow = int
    }
    
    var supplements = profile.supplements
    var colors: [UIColor] = [purple01, coffee02, teal01, waterMelon01,
                             skyBlue02, cinnabarColor, yellow02,
                             green02, sunColor, magenta01, plum01, sand01,
                             green, orange01, sand02, red01]
    var selected: Bool = false

    var minHeight: CGFloat = 60
    var maxHeight: CGFloat = 0
    var corner: CGFloat = 30
    
    //MARK: INIT VIEW
    func initView(){
        let row = supplements.count
        if row <= 6 {
            minHeight = 70
            if is5{
                minHeight = 60
                corner = 20
            }
        }else if row > 6 {
            if row >= 8{ minHeight = hasSafeArea || isPlus  || isiPad ? 55 : 50 }
            corner = 25
            if is5{
                minHeight = 40
                corner = 15
            }
        }

        if isiPad{
            minHeight = 100
        }
        maxHeight = height - (minHeight * (row-1).toCGFloat)
        setPrescriptionCells()
        showView()
        select(int: selectedRow)
    }
   
    //MARK: SUPPLEMENT CELL'S
    var supplementCells = [Int : SupplementCell]()
    var i: Int = -1
    func setPrescriptionCells(){
        for supplement in supplements{
            i += 1
            supplementCells[i] = SupplementCell()
            supplementCells[i]?.frame(0, minHeight * i.toCGFloat, width, minHeight)
            supplementCells[i]?.maxHeight(maxHeight)
            supplementCells[i]?.minHeight(minHeight)
            supplementCells[i]?.baseTitle(supplement.title)
            supplementCells[i]?.title(supplement.printTitleCorrection)
            supplementCells[i]?.titleInP(supplement.printTitleInParentheses)
            supplementCells[i]?.corner(corner)
            supplementCells[i]?.color(colors[i])
            supplementCells[i]?.descriptions(supplement.usage)
            supplementCells[i]?.tag(i)
            supplementCells[i]?.initView()
            supplementCells[i]?.onTap(self, #selector(tapCell(tap:)))
            addSubview(supplementCells[i]!)
        }
    }
    
    //MARK: TAP
    @objc func tapCell(tap: UITapGestureRecognizer){
        let tag: Int = (tap.view?.tag)!
        if !supplementCells[tag]!.selected{
            playSound(DIET_CELL_SOUND)
            selectedRow = tag
            select(int: tag)
        }
    }
    
    func select(int: Int){
        for (i , cell)in supplementCells{
            if int == i{
                cell.select()
                let y = maxHeight/2 + minHeight * i.toCGFloat
                cell.animate(height: maxHeight, 0.6, curve)
                cell.animate(y: y, 0.6, curve)
                selectedSupplementsRow(color: cell.color, row: i)
            }else{
                cell.deSelect()
                let y = (i < int ? minHeight : maxHeight) + (minHeight * (i-1).toCGFloat) + minHeight/2
                cell.animate(height: minHeight, 0.6, curve)
                cell.animate(y: y, 0.6, curve)
            }
        }
    }
    
    func selectedSupplementsRow(color: UIColor, row: Int) {
        delegateSelectedSupplementRow?.selectedSupplementsRow(color: color, row: row)
    }
    
    //MARK: START VIEW
    func showView(){
        if !selected{
            selected = true
            let curve = curveEaseOut05
            let index = selectedRow
            for (i , cell) in supplementCells{
                let x = cell.x
                cell.x(x + (isRTL ? width : -width))
                cell.opacity(0.7)
                cell.animate(opacity: 1, 2, curve, delay[i+2])
                switch i {
                case index: cell.animate(x: x, 0.6, curve, delay[2])
                case index+1, index-1  : cell.animate(x: x, 0.6, curve, delay[3])
                case index+2, index-2  : cell.animate(x: x, 0.6, curve, delay[4])
                case index+3, index-3  : cell.animate(x: x, 0.6, curve, delay[5])
                case index+4, index-4  : cell.animate(x: x, 0.6, curve, delay[6])
                case index+5, index-5  : cell.animate(x: x, 0.6, curve, delay[7])
                case index+6, index-6  : cell.animate(x: x, 0.6, curve, delay[8])
                case index+7, index-7  : cell.animate(x: x, 0.6, curve, delay[9])
                case index+8, index-8  : cell.animate(x: x, 0.6, curve, delay[10])
                case index+9, index-9  : cell.animate(x: x, 0.6, curve, delay[11])
                case index+10, index-10: cell.animate(x: x, 0.6, curve, delay[12])
                case index+11, index-11: cell.animate(x: x, 0.6, curve, delay[13])
                case index+12, index-12: cell.animate(x: x, 0.6, curve, delay[14])
                case index+13, index-13: cell.animate(x: x, 0.6, curve, delay[15])
                case index+14, index-14: cell.animate(x: x, 0.6, curve, delay[16])
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
            for (i , cell) in supplementCells{
                let x = isRTL ? width : -width
                switch i {
                case index             : cell.animate(transformX: x, 0.8, curve, delay[0])
                case index+1, index-1  : cell.animate(transformX: x, 0.8, curve, delay[1])
                case index+2, index-2  : cell.animate(transformX: x, 0.8, curve, delay[2])
                case index+3, index-3  : cell.animate(transformX: x, 0.8, curve, delay[3])
                case index+4, index-4  : cell.animate(transformX: x, 0.8, curve, delay[4])
                case index+5, index-5  : cell.animate(transformX: x, 0.8, curve, delay[5])
                case index+6, index-6  : cell.animate(transformX: x, 0.8, curve, delay[6])
                case index+7, index-7  : cell.animate(transformX: x, 0.8, curve, delay[7])
                case index+8, index-8  : cell.animate(transformX: x, 0.8, curve, delay[8])
                case index+9, index-9  : cell.animate(transformX: x, 0.8, curve, delay[9])
                case index+10, index-10: cell.animate(transformX: x, 0.8, curve, delay[10])
                case index+11, index-11: cell.animate(transformX: x, 0.8, curve, delay[11])
                case index+12, index-12: cell.animate(transformX: x, 0.8, curve, delay[12])
                case index+13, index-13: cell.animate(transformX: x, 0.8, curve, delay[13])
                case index+14, index-14: cell.animate(transformX: x, 0.8, curve, delay[14])
                default: break
                }
            }
            var _ = Timer.schedule(delay[supplementCells.count]+2) { _ in self.remove() }
        }
    }
}
