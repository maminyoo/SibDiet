//
//  AnswerView.swift
//  Sibdiet
//
//  Created by Amin on 2/24/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class AnswerView: UIView, AVAudioPlayerDelegate{
    
    var answer = String()
    func answer(_ answer :String){
        self.answer = answer
    }
    
    var enable = false
    
    //MARK: INIT VIEW
    func initView(){
        setBg()
        startView()
    }
    
    //MARK: BG
    var bg = UIView()
    func setBg(){
        bg.frame(bounds)
        bg.shadow(CGSize(0, 1), gray09, 1, 0.7)
        bg.backgroundColor(mint01.opacity(0.75))
        setLabel()
        addSubview(bg)
    }
    
    //MARK: LABEL
    var label = UILabel()
    func setLabel(){
        label.frame(10, bg.height-60, width-20, 60)
        label.text(answer)
        label.font(Sahel, 18)
        label.backgroundColor(.clear)
        label.textAlignment(.center)
        label.numberOfLines(0)
        label.lineBreakMode(.byWordWrapping)
        label.textColor(white)
        bg.addSubview(label)
    }
    
    //MARK: START VIEW
    func startView(){
        if !enable{
            enable = true
            bg.transformY(-height)
            bg.animate(transform: .identity,  0.7, curve)
            playSound(source: ANSWER_HGH_SOUND)
            var _ = Timer.schedule(7) { _ in self.closeView() }
        }
    }
    
    //MARK: PLAYER
    var player: AVAudioPlayer?
    @objc func playSound(source: String){
        let url = Bundle.main.url(forResource: source, withExtension: CAF_EXTENSION)!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
            player.delegate = self
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    //MARK: CLOSE VIEW
    @objc func closeView(){
        if enable{
            enable = false
            bg.animate(transformY: -height,  0.7, curve)
            var _ = Timer.schedule(1.5) { _ in self.remove() }
        }
    }
}
