//
//  Questioner.swift
//  Sibdiet
//
//  Created by amin sadeghian on 3/5/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

protocol QuestionerDelegate{
    func start(question: Int)
    func open(question: Int)
    func closeAnswers()
    func answeredQuestion()
    func onFocus(question: Int)
    func endEditting()
    func remove(question: Int)
}

class QuestionModel{
    var question = String()
    func question(_ string: String){
        question = string
    }
    var audio = String()
    func audio(_ string: String){
        audio = string
    }
    var mode = String()
    func mode(_ string: String){
        mode = string
    }
    var answers = [String]()
    func answers(_ strings: [String]){
        answers = strings
    }
    var answerXrow = Int()
    func answerXrow(_ int: Int){
        answerXrow = int
    }
    var hodler = String()
    func hodler(_ string: String){
        hodler = string
    }
}

class Questioner: UIView, QuestionerDelegate, UITextFieldDelegate, AVAudioPlayerDelegate{
    
    var delegateQuestioner: QuestionerDelegate?
    func delegate(_ delegate: QuestionerDelegate){
        self.delegateQuestioner = delegate
    }
    
    var q = Int()
    func q(_ int : Int){
        self.q = int
    }
    
    var model = QuestionModel()
    func model(_ model: QuestionModel){
        self.model = model
    }
    
    var answer = String()
    func answer(_ answer: String){
        self.answer = answer
    }
    
    var answers = [String]()
    func answers(_ answers: [String]){
        self.answers = answers
    }
    
    var isAnswered = Bool()
    func isAnswered(_ bool: Bool){
        self.isAnswered = bool
    }
    
    var text = String()
    func answerDescription(_ string: String){
        self.text = string
    }
    
    var answerDescriptionEnable = Bool()
    func answerDescriptionEnable(_ bool: Bool){
        self.answerDescriptionEnable = bool
    }
    
    var enable = false
    func enable(_ bool: Bool){
        self.enable = bool
    }
    
    var isOpen = false
    func isOpen(_ bool:Bool){
        self.isOpen = bool
    }
    
    var isFocus = false
    func isFocus(_ bool: Bool){
        self.isFocus = bool
    }
    
    var minHeight: CGFloat = 100
    func minHeight(_ height: CGFloat){
        self.minHeight = height
    }
    
    var corner: CGFloat = 20
    
    var yRow = 0
    var reminingCell: Int = 0
    var answerCellHeight: CGFloat = 54
    var answerHeight: CGFloat = 0
    let duration: CFTimeInterval = 0.7
    
    var hasAudio: Bool{ model.audio != "" }
    var enableDescription: Bool{ text != "" }
    var cellHeight: CGFloat{ isOpen ? minHeight+answerHeight : minHeight }
    var noDescrioption : Bool{ text == "" }
    
    var result: String{
        var result = String()
        for (_, answer) in answersCells{
            if answer.selected{ result = answer.title }
        }
        return result
    }
    
    var results:[String]{
        var result = [String]()
        for (_, answer) in answersCells{
            if answer.selected{ result.append(answer.title) }
        }
        return result
    }
    
    //MARK: INIT VIEW
    func initView(){
        setBottomView()
        setTopView()
        if model.mode != TEXT{
            optionHeightRow()
            setAnswersViewholder()
            if model.mode == CHECK{
                for answer in answers{
                    for (_, cell) in answersCells{
                        if answer == cell.title{ cell.select() }
                        else{ cell.deSelect() }
                    }
                }
            }
        }
        if model.mode == RADIO_DES{
            inputText.isHidden(true)
            if answerDescriptionEnable{
                inputText.isHidden(false)
            }
        }
        setSelectQ()
        setStop()
    }
    
    //MARK: ROW HEIGHT
    func optionHeightRow(){
        yRow = 0
        if model.answers.count > model.answerXrow{
            let row = model.answers.count / model.answerXrow
            yRow += row
            reminingCell = model.answers.count % model.answerXrow
            if reminingCell > 0{ yRow += 1 }
        }else{ yRow = 1 }
        answerHeight = yRow.toCGFloat*answerCellHeight
    }
    
    //MARK: TAP
    var selectQ = UIView()
    func setSelectQ(){
        selectQ.frame(bounds)
        selectQ.onTap(self, #selector(tapQuestion), 1)
        addSubview(selectQ)
    }
    
    @objc func tapQuestion(){
        selectedColors()
        if model.mode != TEXT{ openAnswers() }
        else{ focusKeyboard() }
    }
    
    //MARK: TOP VIEW
    let topView = UIView()
    func setTopView(){
        topView.frame(0, 0, width, height/2 - 2)
        setTopGradient()
        topView.clipsToBounds(true)
        setTopMask()
        setTitleText()
        setTitleTextOver()
        addSubview(topView, 1)
        if hasAudio{
            setPlayButton()
            setStopBottom()
        }
    }
    
    let topMask = UIView()
    let topLineShape = CAShapeLayer()
    func setTopMask(){
        topMask.frame(topView.bounds)
        let topShape = CAShapeLayer()
        topShape.frame(topMask.bounds)
        topShape.path(topShape.roundCorner(rt: corner, lt: corner, lb: 0, rb: 0))
        topLineShape.frame(0, 0, topShape.width, topShape.height+10)
        topLineShape.path(topLineShape.roundCorner(rt: corner, lt: corner, lb: 0, rb: 0))
        topLineShape.fillColor(.clear)
        topLineShape.strokeColor(white01)
        topLineShape.lineWidth(4)
        topView.addSublayer(topLineShape)
        topView.mask(topMask)
        topMask.addSublayer(topShape)
    }
    
    //MARK: PLAY BUTTON
    var playButton = UIImageView()
    func setPlayButton(){
        playButton.frame = CGRect(5, 5, 30, 30)
        playButton.image(UIImage(PLAY_IMG)!)
        playButton.opacity(0)
        playButton.onTap(self, #selector(playVoice))
        topView.addSubview(playButton)
    }
    
    //MARK: PLAYER
    var player: AVAudioPlayer?
    @objc func playVoice(){
        let url = Bundle.main.url(forResource: model.audio, withExtension: MP3_EXTENSION)!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
            player.delegate = self
            playButton.animate(opacity: 0, 0.5, curveEaseOut)
            stopButton.animate(opacity: 1, 0.5, curveEaseOut)
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag{
            playButton.animate(opacity: 1, 0.5, curveEaseOut)
            stopButton.animate(opacity: 0, 0.5, curveEaseOut)
        }
    }
    
    //MARK: STOP BUTTON
    var stopButton = UIImageView()
    func setStopBottom(){
        stopButton.frame(playButton.frame)
        stopButton.image(UIImage(STOP_IMG)!)
        stopButton.opacity(0)
        stopButton.onTap(self, #selector(stopVoice))
        topView.addSubview(stopButton)
    }
    
    @objc func stopVoice(){
        player?.stop()
        playButton.animate(opacity: 1, 0.5, curveEaseOut)
        stopButton.animate(opacity: 0, 0.5, curveEaseOut)
    }
    
    //MARK: TOP GRADIENT
    var topGradient = CAGradientLayer()
    func setTopGradient(){
        topGradient.frame(topView.bounds)
        topGradient.colors([gray0, gray01])
        topGradient.startPoint(0, 0)
        topGradient.endPoint(0, 1)
        topView.addSublayer(topGradient)
    }
    
    //MARK: TITLE
    var titleText = UILabel()
    func setTitleText(){
        let font = UIFont(Sahel_Bold, 17)!
        let width: CGFloat = model.question.width(height: 20, font: font) + 10
        titleText.frame(self.width/2 - width/2,
                        topView.height/2 - 5,
                        width,
                        22)
        titleText.textColor(model.mode != TEXT ? gray06 : skyBlue01)
        titleText.font(font)
        titleText.textAlignment(.center)
        titleText.text(model.question)
        topView.addSubview(titleText)
    }
    
    //MARK: TITLE OVER
    var titleTextOver = UILabel()
    func setTitleTextOver(){
        titleTextOver.frame(titleText.frame)
        titleTextOver.textColor(selectedColor01)
        titleTextOver.font(titleText.font)
        titleTextOver.textAlignment(.center)
        titleTextOver.text(model.question)
        titleTextOver.opacity(0)
        topView.addSubview(titleTextOver)
    }
    
    //MARK: OPTIONS HOLDER
    var answersViewHolder = UIView()
    func setAnswersViewholder(){
        answersViewHolder.frame(0,
                               topView.y + topView.height/2 - 10,
                               width,
                               answerHeight + 20)
        answersViewHolder.clipsToBounds(true)
        addSubview(answersViewHolder, 0)
        setOptionsView()
    }
    
    //MARK: OPTION
    var answersView = UIView()
    let overView = UIView()
    func setOptionsView(){
        answersView.frame(0, 10, answersViewHolder.width, answersViewHolder.height-20)
        answersView.backgroundColor(white01)
        overView.frame(2, 0, answersViewHolder.width-4, answersViewHolder.height)
        overView.backgroundColor(gray00)
        answersView.addSubview(overView)
        answersView.clipsToBounds(true)
        setAnswersCells()
        answersViewHolder.addSubview(answersView)
    }
    
    //MARK: CELL'S
    var answersCells = [Int: RadioCheckCell]()
    func setAnswersCells(){
        var j = -1
        var row =  model.answerXrow
        var ys = 1
        var y: CGFloat = 0
        var cells =  model.answerXrow
        for option in model.answers{
            j += 1
            answersCells[j] = RadioCheckCell()
            row -= 1
            if row == -1{
                ys += 1
                row = model.answerXrow-1
                if ys == yRow && model.answers.count % model.answerXrow != 0 {
                    cells = model.answers.count % model.answerXrow
                    row = cells-1
                }
                y += answerCellHeight
            }
            answersCells[j]?.frame(overView.width/CGFloat(cells) * CGFloat(row),
                                   y,
                                   overView.width/CGFloat(cells),
                                   answerCellHeight)
            answersCells[j]?.title(option)
            answersCells[j]?.mode(model.mode)
            answersCells[j]?.initView()
            answersCells[j]?.tag(j)
            if option == answer{ answersCells[j]?.select() }
            else{ answersCells[j]?.deSelect() }
            answersCells[j]?.onTap(self, #selector(tapAnswer(tap:)))
            overView.addSubview(answersCells[j]!)
        }
    }
    
    //MARK: TAP ANSWER
    var checkTimer = Timer()
    @objc func tapAnswer(tap: UITapGestureRecognizer){
        let tag: Int = (tap.view?.tag)!
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        if canSelect{
            for (i, answer) in answersCells{
                switch model.mode {
                case RADIO, RADIO_DES:
                    if i == tag{
                        if !answer.selected{
                            answer.select()
                            answerText.animate(opacity: 0.5, 0.4, curveEaseIn05)
                        }
                        var _ = Timer.schedule(0.4) { _ in self.answered() }
                    }else{
                        answer.deSelect()
                    }
                case CHECK:
                    if i == tag{
                        checkTimer.invalidate()
                        if answer.selected{ answer.deSelect() }
                        else{ answer.select() }
                        answerText.animate(opacity: 0.5, 0.4, curveEaseIn05)
                        var _ = Timer.schedule(0.4) { _ in self.answered() }
                    }
                default: break
                }
            }
        }
    }
    
    //MARK: ANSWERED
    @objc func answered(){
        let font = UIFont(Sahel, 20)!
        if model.mode == RADIO || model.mode == RADIO_DES{
            let answerWidth: CGFloat = result.width(height: 20, font: font) + 10
            let w = width-10<answerWidth ? width-30 : answerWidth
            answerText.width(w)
            answerText.text(result)
            answerTextOver.width(w)
            answerTextOver.text(result)
            if result != ""{ var _ = Timer.schedule(0.3) { _ in self.answeredQuestion() } }
        }else{
            let count: Int = results.count
            var result: String = ""
            var i = 0
            for r in results{
                i += 1
                if count == 1 { result = r }
                else if i != count { result += "\(r)\(isRTL ? "،" : ",") " }
                else if i == count { result += "\(r)" }
            }
            let answerWidth: CGFloat = result.width(height: 20, font: font) + 10
            let w = width-10<answerWidth ? width-30 : answerWidth
            answerText.width(w)
            answerText.text(result)
            answerTextOver.width(w)
            answerTextOver.text(result)
            if result != ""{ checkTimer = Timer.schedule(1.7) { _ in self.answeredQuestion() } }
        }
        answerText.animate(opacity: 1, duration, curveEaseOut05)
    }
    
    @objc func answeredQuestion() {
        closeAnswers()
        delegateQuestioner?.answeredQuestion()
    }
    
    //MARK: BOTTOM VIEW
    var bottomView = UIView()
    func setBottomView(){
        bottomView.frame(0,
                         height/2-2,
                         width,
                         height/2-2)
        setBottomGradient()
        setBottomMask()
        if model.mode != TEXT{
            setAnswerText()
            setAnswerTextOver()
        }
        setInputText()
        addSubview(bottomView, 2)
    }
    
    //MARK: BOTTOM GRADIENT
    var bottomGradient = CAGradientLayer()
    func setBottomGradient(){
        bottomGradient.frame(bottomView.bounds)
        bottomGradient.colors([gray01, gray0])
        bottomView.addSublayer(bottomGradient)
    }
    
    //MARK: BOTTOM MASK
    var bottomMask = UIView()
    let bottomLineShape = CAShapeLayer()
    func setBottomMask(){
        bottomMask.frame(bottomView.bounds)
        let bottomShape = CAShapeLayer()
        bottomShape.frame(bottomMask.bounds)
        bottomShape.path(bottomShape.roundCorner(rt: 0, lt: 0, lb: corner, rb: corner))
        bottomLineShape.frame(0, -8, bottomView.width, bottomView.height+4)
        bottomLineShape.path(bottomLineShape.roundCorner(rt: 0, lt: 0, lb: corner, rb: corner))
        bottomLineShape.fillColor(.clear)
        bottomLineShape.strokeColor(white01)
        bottomLineShape.lineWidth(4)
        bottomMask.addSublayer(bottomShape)
        bottomView.addSublayer(bottomLineShape)
        bottomView.mask(bottomMask)
    }
    
    //MARK: ANSWER TEXT
    var answerText = UILabel()
    func setAnswerText(){
        let font = UIFont(Sahel, 20)!
        let answerWidth: CGFloat = answer.width(height: 20, font: font) + 10
        let w = width-10<answerWidth ? width-20 : answerWidth
        answerText.frame(width/2 - w/2,
                         bottomView.height/2 - 18,
                         width-10<w ? width-30 : w,
                         25)
        answerText.textColor(gray07)
        answerText.font(font)
        answerText.textAlignment(.center)
        answerText.adjustsFontSizeToFitWidth(true)
        answerText.text(answer)
        bottomView.addSubview(answerText)
    }
    
    //MARK: ANSWER OVER
    var answerTextOver = UILabel()
    func setAnswerTextOver(){
        answerTextOver.frame(answerText.frame)
        answerTextOver.textColor(gray0)
        answerTextOver.font(answerText.font)
        answerTextOver.adjustsFontSizeToFitWidth(true)
        answerTextOver.textAlignment(.center)
        answerTextOver.text(answer)
        answerTextOver.opacity(0)
        bottomView.addSubview(answerTextOver)
    }
    
    //MARK: INPUT TEXT
    var inputText = UITextField()
    func setInputText(){
        let width: CGFloat = model.mode == TEXT ? self.width - 40 : self.width - answerText.width
        inputText.frame(self.width/2 - width/2,
                        bottomView.height/2 - 18,
                        width,
                        25)
        inputText.font(Sahel, 20)
        inputText.placeholder(model.hodler)
        inputText.textColor(gray07)
        inputText.text(text)
        inputText.textAlignment(isRTL ? .right : .left)
        inputText.autocorrectionType(.no)
        inputText.delegate(self)
        inputText.tintColor(white)
        inputText.adjustsFontSizeToFitWidth(true)
        inputText.editingChanged(self, #selector(focus))
        inputText.editingDidBegin(self, #selector(focus))
        inputText.editingDidEnd(self, #selector(endEditting))
        bottomView.addSubview(inputText)
    }
    
    func closeKeyboard(){
        inputText.resignFirstResponder()
    }
    
    func focusKeyboard(){
        inputText.becomeFirstResponder()
    }
    
    var canFeedback = true
    
    //MARK: FOCUS
    @objc func focus(){
        if canFeedback{ feedback() }
        isFocus(true)
        closeAnswers()
        selectedColors()
        let count = inputText.text?.count
        if count! <= 100{
            answerDescription(inputText.text!)
            inputText.text(text)
        }else{
            inputText.text(text)
        }
        selectQ.isHidden(true)
        onFocus(question: q)
    }
    
    @objc func onFocus(question: Int){
        delegateQuestioner?.onFocus(question: question)
    }
    
    @objc func endEditting(){
        canFeedback = true
        isFocus(false)
        deSelectedColors()
        selectQ.isHidden(false)
        delegateQuestioner?.endEditting()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        endEditting()
        return true
    }
    
    //MARK: STOP
    func setStop(){
        isHidden(true)
//        topMask.y(topView.y + topView.height + 10)
        answersView.y(topView.y - topView.height/2 - answerHeight/2 + 10)
//        bottomMask.y(-(bottomView.y + bottomView.height + 10))
        let titleY = topView.y + topView.height/2 - titleText.height
        titleText.y(titleY)
        titleTextOver.y(titleY)
        answersView.isHidden(true)
        opacity(0)
        inputText.width(0)
    }
    
    //MARK: START VIEW
    func startView(delay: CFTimeInterval = 0){
        if !enable{
            start(question: q)
            enable = true
            hiddenTimer.invalidate()
            isHidden(false)
            answersView.isHidden(true)
            animate(opacity: 1, duration, curve, delay)
//            topMask.animate(y: topView.y, duration, curve, delay)
            bottomMask.y(bottomView.y - bottomView.height - 4)

            let titleX = isRTL ? width - titleText.width/2 - 10 : titleText.width/2 + 10
            titleText.animate(x: titleX, duration, curve)
            titleTextOver.animate(x: titleX, duration, curve)
            
            let answerTextX = isRTL ? width - answerText.width/2 - 20 : isAnswered ? answerText.width/2 + 20 : 20
            answerText.animate(x: answerTextX, 0.7, curve, 0.2)
            answerTextOver.animate(x: answerTextX, 0.7, curve, 0.2)
            
            if !isAnswered && model.mode != TEXT{
                openAnswers(delay: delay+0.7)
            }
            if model.mode == TEXT {
                open(question: q)
                inputText.width(width - 40)
                inputText.x(width/2)
            }
            if enableDescription{
                inputText.animate(width: width - answerText.width - 40, duration, curve, 0.2)
                let x: CGFloat = isRTL ?
                    inputText.width/2 + 10 :
                    inputText.width/2 + answerText.width + 20
                inputText.animate(x: x, duration, curve, 0.2)
            }
        }
    }
    
    func start(question: Int) {
        delegateQuestioner?.start(question: question)
    }
    
    //MARK: OPEN ANSWERS
    var canSelect = false
    func openAnswers(delay: CFTimeInterval = 0){
        if !isOpen{
            selectedColors(delay: delay)
            selectQ.isHidden(true)
            isOpen(true)
            answersView.isHidden(false)
            optionViewHiddenTimer.invalidate()
            answersView.animate(y: topView.y - topView.height/2 + answerHeight/2 + 9, 0.7, curve, delay)
            bottomView.animate(y: topView.y + topView.height/2 + answerHeight + bottomView.height/2, 0.7, curve, delay)
            titleText.animate(x: width/2, duration, curve, delay)
            titleTextOver.animate(x: width/2, duration, curve, delay)
            answerText.animate(x: width/2, duration, curve, 0.2)
            answerTextOver.animate(x: width/2, duration, curve, 0.2)
            playButton.animate(opacity: 1, duration, curve, delay)
            if enableDescription{ inputText.animate(opacity: 0, duration, curve) }
            open(question: q)
            var _ = Timer.schedule(delay+0.2) { _ in self.feedback() }
        }
    }
    
    @objc func feedback(){
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        canSelect = true
        canFeedback = false
    }
    
    @objc func open(question: Int) {
        delegateQuestioner?.open(question: question)
    }
    
    //MARK: CLOSE ANSWERS
    var optionViewHiddenTimer = Timer()
    @objc func closeAnswers(){
        if isOpen{
            isOpen(false)
            canSelect = false
            selectQ.isHidden(false)
            player?.stop()
            
            let optionY = topView.y - topView.height/2 - answerHeight/2 + 10
            answersView.animate(y: optionY, duration, curve)
            
            let bottomY = topView.y  + topView.height/2 + bottomView.height/2
            bottomView.animate(y: bottomY, duration, curve)
            
            let titleTextX = isRTL ? width - titleText.width/2 - 10 : titleText.width/2 + 10
            titleText.animate(x: titleTextX,  duration, curve)
            titleTextOver.animate(x: titleTextX,  duration, curve)
            
            let answerTextX = isRTL ? width - answerText.width/2 - 20 : answerText.width/2 + 20
            answerText.animate(x: answerTextX, 0.7, curve, 0.2)
            answerTextOver.animate(x: answerTextX, 0.7, curve, 0.2)
            
            playButton.animate(opacity: 0, duration, curve)
            stopButton.animate(opacity: 0, duration, curve)
            if enableDescription{ fixInputFrame() }
            deSelectedColors()
            delegateQuestioner?.closeAnswers()
            optionViewHiddenTimer = Timer.schedule(0.7) { _ in
                self.answersView.isHidden(true)
            }
        }
    }
    
    //MARK: SELECT COLOR
    func selectedColors(delay: CFTimeInterval = 0){
        topLineShape.animate(strokeColor: white, 1, easeInOut05)
        bottomLineShape.animate(strokeColor: white, 1, easeInOut05)
        answerText.animate(opacity: 0, duration, curve)
        answerTextOver.animate(opacity: 1, duration, curve)
        titleText.animate(opacity: 0, duration, curve)
        titleTextOver.animate(opacity: 1, duration, curve)
        topGradient.animate(colors: [gray0, gray00], duration, easeInOut05, delay)
        bottomGradient.animate(colors: [selectedColor02, selectedColor01], duration, easeInOut05, delay)
        inputText.textColor(gray00)
    }
    
    //MARK: DESELECT COLOR
    func deSelectedColors(){
        let delay: CFTimeInterval = 0.3
        answerText.animate(opacity: 1, duration+delay, curve, delay)
        answerTextOver.animate(opacity: 0, duration+delay, curve, delay)
        titleText.animate(opacity: 1, duration+delay, curve, delay)
        titleTextOver.animate(opacity: 0, duration+delay, curve, delay)
        topGradient.animate(colors: [gray0, gray01], duration+delay, easeInOut05, delay)
        bottomGradient.animate(colors: [gray01, gray0], duration+delay, easeInOut05, delay)
        inputText.textColor(gray07)
    }
    
    //MARK: WRITE DESCRIPTION
    func writeDescription(){
        selectedColors()
        answerDescriptionEnable(true)
        inputText.isHidden(false)
        fixInputFrame()
        var _ = Timer.schedule(0.7) { _ in self.focusKeyboard() }
    }
    
    //MARK: INPUT FRAME
    func fixInputFrame(){
        inputText.animate(opacity: 1, duration, curve)
        inputText.animate(width: width - answerText.width - 30, duration, curve, 0.2)
        let x: CGFloat = isRTL ?
            10 + inputText.width/2 :
            answerText.width + inputText.width/2 + 20
        inputText.animate(x: x, duration, curve, 0.2)
    }
    
    //MARK: DISABLE DESCRIPTION
    func disableDescription(){
        answerDescriptionEnable(false)
        inputText.isHidden(true)
        inputText.animate(opacity: 0, 0.3, curve)
        inputText.text(String())
        answerDescription(String())
    }
    
    //MARK: CLOSE VIEW
    var hiddenTimer = Timer()
    func closeView(delay: CFTimeInterval = 0){
        enable = false
        player?.stop()
        animate(opacity: 0, 0.7, curve, delay)
//        topMask.animate(y: topView.height+2, duration, curve, delay)
//        bottomMask.animate(y: -bottomView.height-2, duration, curve, delay)
        hiddenTimer = Timer.schedule(0.7 + delay) { _ in
            self.isHidden(true)
            self.remove(question: self.q)
        }
    }
    
    func remove(question: Int) {
        delegateQuestioner?.remove(question: question)
        reset()
    }
    
    //MARK: RESET
    func reset(){
        for (_, answer) in answersCells{ answer.deSelect() }
        isOpen(false)
        enable(false)
        isAnswered(false)
        answer(String())
        answers([String]())
        inputText.text(String())
        answerText.text(String())
        answerTextOver.text(String())
        answerDescription(String())
    }
}
