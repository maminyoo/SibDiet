//
//  SpecialInfoForm.swift
//  Sibdiet
//
//  Created by amin sadeghian on 3/4/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol SpecialFormDelegate {
    func open()
    func focus()
}

class SpecialForm: UIView, QuestionerDelegate, SpecialFormDelegate{
    
    var delegateSpecialForm: SpecialFormDelegate?
    func delegate(_ delegate: SpecialFormDelegate){
        self.delegateSpecialForm = delegate
    }
    
    //MARK: QUESTION INDEX
    let feetsleep           : Int = 0     //     خواب رفتگی دست و پا
    let bloat               : Int = 1     //     نفخ
    let diarrhea            : Int = 2     //     اسهال
    let appetite            : Int = 3     //     اشتها
    let periodbleeding      : Int = 4     //     خونریزی دوره پریود
    let periodpain          : Int = 5     //     درد دوره پریود
    let pregnant            : Int = 6     //     آیا باردار هستید؟
    let childbirth          : Int = 7     //     زایمان
    let breastfeeding       : Int = 8     //     در حال حاضر شیردهی
    let dairySensitivity    : Int = 9     //     در شیردهی به لبنیات حساس هستید؟
    let fibroma             : Int = 10    //     مشکل فیبروم
    let breastCancer        : Int = 11    //     مشکل سرطان پستان
    let ovarianCyst         : Int = 12    //     مشکل کیست تخمدان
    let mouth               : Int = 13    //     طعم دهان
    let metetarsus          : Int = 14    //     کف پا
    let bloodConcentration  : Int = 15    //     مشکلات غلظت خون
    let platelet            : Int = 16    //     مشکل پلاکت (plt)
    let hairloss            : Int = 17    //     مشکلات مو
    let hairlossLocation    : Int = 18    //     محل ریزش مو
    let constipation        : Int = 19    //     یبوست
    let sleepjump           : Int = 20    //     پرش از خواب
    let activity            : Int = 21    //     فعالیت بدنی
    let activityType        : Int = 22    //     نوع ورزش
    let activityDays        : Int = 23    //     تعداد روزهای ورزش
    let activityTime        : Int = 24    //     مدت زمان ورزش در هر روز
    let activityWeekDays    : Int = 25    //     روزهای تمرین در هفته
    let activityStartTime   : Int = 26    //     ساعت شروع تمرین
    let activityIntensity   : Int = 27    //     شدت تمرین در جلسات مختلف
    let bodySize            : Int = 28    //     تصویر کلی بدن
    let activityDietGoal    : Int = 29    //     هدف از دریافت رژیم ورزشی
    let vitaminDeficiencyD  : Int = 30    //     کمبود ویتامین D
    let kidneyStone         : Int = 31    //     سنگ کلیه
    let ms                  : Int = 32    //     ام اس
    let arthritis           : Int = 33    //     آرتروز
    let rheumatoidArthritis : Int = 34    //     آرتریت روماتوئید (روماتیسم مفصلی)
    let thinningDrugs       : Int = 35    //     استفاده از داروهای رقیق کننده
    let epilepsy            : Int = 36    //     مشکل صرع
    let cramp               : Int = 37    //     گرفتگی عضلات
    let headache            : Int = 38    //     سردرد
    let glucose             : Int = 39    //     قند خون
    let gallbladder         : Int = 40    //     کیسه‌ صفرا
    let pressure            : Int = 41    //     فشار خون
    let liver               : Int = 42    //     وضعیت کبد
    let anemia              : Int = 43    //     کم خونی
    let stomach             : Int = 44    //     درد یا سوزش معده
    let stomachIncreasing   : Int = 45    //     ارتباطی با مصرف سالاد و میوه جات دارد؟
    let mary                : Int = 46    //     ریفلاکس یا همان ترش کردن معده
    let fat                 : Int = 47    //     چربی تری گلیسیرید
    let fatCholesterol      : Int = 48    //     چربی کلسترول
    let thyroid             : Int = 49    //     تیروئید
    let uric                : Int = 50    //     اسید اوریک
    let bloodUrea           : Int = 51    //     اوره بالای خون
    let bloodCreatinine     : Int = 52    //     کراتنین بالای خون
    let fingernail          : Int = 53    //     وضعیت ناخن های
    let covid19             : Int = 54    //     وضعیت ابتلا به کرونا
    let hemorrhoid          : Int = 55    //     هموروئید (بواسیر یا همان فیشر)
    let lunch               : Int = 56    //     ناهار
    let walkingStatus       : Int = 57    //     نحوه اجرای پیاده روی طبق دستور
    let foodsStatus         : Int = 58    //     نحوه اجرای غذاها
    let refreshmentsStatus  : Int = 59    //     در حین رژیم در مورد تنقلات
    let vitaminsStatus      : Int = 60    //     ویتامین و املاح تجویز شده در رژیم
    let weightGoal          : Int = 61    //     از وزنتان چه خواسته ای دارید؟
    let family              : Int = 62    //     خانواده
    let name                : Int = 63    //     نام
    let mobile              : Int = 64    //     شماره همراه
    let explanations        : Int = 65    //     علت اصلی درخواست شما
    let disease             : Int = 66    //     بیماری های دیگری که دارید؟
    let hatedfood           : Int = 67    //     غذاهای مورد تنفر
    let favoritefood        : Int = 68    //     غذاهای مورد علاقه
    let supplement          : Int = 69    //     استفاده از مکمل ها
    
    //MARK: PROFILE
    var isMarital                 : Bool       { profile.isMarital }
    var isFirstTime               : Bool       { profile.isFirstTime }
    
    //MARK: ANSWERS
    var answers                   : [String]   { specialInformation.answers }
    var checkAnswers              : [[String]] { specialInformation.checkAnswers }
    var isAnswered                : [Bool]     { specialInformation.isAnswered }
    var answersDescriptionsEnable : [Bool]     { specialInformation.answersDescriptionsEnable }
    var answersDescriptions       : [String]   { specialInformation.answersDescription }
    
    //MARK: ANSWER STATE
    var hasFamily               : Bool { specialInformation.hasFamily }                         //    خانواده
    var isMenopause             : Bool { specialInformation.isMenopause }                       //    یایستگی
    var havePregnant            : Bool { specialInformation.havePregnant }                      //    باردار
    var haveChild               : Bool { specialInformation.haveChild }                         //    زایمان
    var haveBreastfeeding       : Bool { specialInformation.haveBreastfeeding }                 //    در حال شیردهی
    var haveHairloos            : Bool { specialInformation.haveHairloos }                      //    مو ریزش
    var isActivePro             : Bool { specialInformation.isActivePro }                       //    ورزشکار
    var isActive                : Bool { specialInformation.isActive }                          //    ورزشکار معمولی
    var haveOtherSport          : Bool { specialInformation.hasOtherSport }                     //    نام ورزش
    var haveHighStomch          : Bool { specialInformation.isHighStomch }                      //    درد معده زیاد
    var haveStomachIncreasing   : Bool { specialInformation.haveStomachIncreasing }             //    ارتباط با سالاد
    var haveArthritis           : Bool { specialInformation.arthritisDescriptionEnable }        //    آرتروز
    var haveHighBloodUrea       : Bool { specialInformation.bloodUreaDescriptionEnable }        //    اوره بالای خون
    var haveHighBloodCreatinine : Bool { specialInformation.bloodCreatinineDescriptionEnable }  //    کراتنین بالای خون
    var canChooseLunch          : Bool { specialInformation.canChooseLunch }                    //    ناهار
    var canChooseFood           : Bool { specialInformation.canChooseFood }                     //    غذای مورد تنفر و علاقه

    let duration: CFTimeInterval = 0.7
    let values = SpecialInfoFormValues()
    
    //MARK: INIT VIEW
    func initView(){
        setFormContainer()
        answerQuestions()
        observerKeyboard()
    }
    
    lazy var formContainer = UIView()
    func setFormContainer(){
        formContainer.frame(0, 0, width, formHeight)
        setQuestionCells()
        formContainer.onPan(self, #selector(paning(pan:)))
        addSubview(formContainer)
    }
    
    var btmForm:   CGFloat { height - formHeight/2 - 5 }
    var topForm:   CGFloat { formHeight/2 + 10 }
    var isScrollable: Bool { formHeight > height }

    //MARK: PAN FORM
    var formY: CGFloat!
    @objc func paning(pan: UIPanGestureRecognizer){
        closeKeyboard()
        let translationY = pan.translation(in: self).y
        switch pan.state {
        case .began:
            formY = formContainer.y
        case .changed:
            formContainer.y(isScrollable ? formY+translationY : formY+translationY/5)
        case .ended:
            let velocity = pan.velocity(in: formContainer)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 300
            let slideFactor = 0.1 * slideMultiplier
            let y = formContainer.y + (velocity.y * slideFactor)
            let time = CFTimeInterval(slideFactor * 2)
            if isScrollable{
                if y < btmForm{ formContainer.animate(y: btmForm, 0.8, 0.8) }
                else if y > topForm{ formContainer.animate(y: topForm, 0.8, 0.8) }
                else{ formContainer.animate(y: y, time,  curveEaseOut03) } }
            else { formContainer.animate(y: height/2 , 0.8, 0.8) }
        default: break }
    }
    
    //MARK: QUESTION CELL'S
    var space: CGFloat = 4
    let cellHeight: CGFloat = 100
    lazy var questions = [Questioner]()
    func setQuestionCells(){
        var i = -1
        for question in values.questions{
            i += 1
            let q = Questioner()
            questions.append(q)
            questions[i].frame(10,
                               cellHeight + space * i.toCGFloat,
                               width - 20,
                               cellHeight)
            questions[i].q(i)
            questions[i].model(question)
            questions[i].minHeight(cellHeight)
            questions[i].answer(answers[i])
            questions[i].answers(checkAnswers[i])
            questions[i].isAnswered(isAnswered[i])
            questions[i].answerDescription(answersDescriptions[i])
            questions[i].answerDescriptionEnable(answersDescriptionsEnable[i])
            questions[i].delegate(self)
        }
    }
    
    //MARK: ANSWERED
    func answeredQuestion() {
        save()
        answerQuestions()
        clearNeeded()
        openUnAnswered()
        questionsDimPos()
    }
    
    //MARK: ANSWER QUESTIONS
    func answerQuestions(){
        answer(feetsleep)
        if isAnswered[feetsleep]{ answer(bloat) }
        if isAnswered[bloat]{ answer(diarrhea) }
        if isAnswered[diarrhea]{ answer(appetite) }
        if isAnswered[appetite]{
            if !isMan && !isBaby{
                answer(periodbleeding)
                if !isMenopause && isAnswered[periodbleeding]{
                    answer(periodpain)
                    if isAnswered[periodpain]{
                        if isMarital{ answer(pregnant)
                            if isAnswered[pregnant]{ answer(childbirth)
                                if havePregnant && questions[pregnant].noDescrioption{
                                    questions[pregnant].writeDescription()
                                }else if !havePregnant {
                                    questions[pregnant].disableDescription()
                                }
                                if isAnswered[childbirth]{
                                    if haveChild{ answer(breastfeeding)
                                        if isAnswered[breastfeeding]{
                                            if haveBreastfeeding{ answer(dairySensitivity)
                                                if isAnswered[dairySensitivity]{ answer(fibroma) }
                                            }else{ answer(fibroma) }
                                        }
                                    }else{ answer(fibroma) }
                                }
                            }
                        }else{ answer(fibroma) }
                    }
                    if isAnswered[fibroma]{ answer(breastCancer) }
                    if isAnswered[breastCancer]{ answer(ovarianCyst) }
                    if isAnswered[ovarianCyst]{ answer(mouth) }
                }else if isAnswered[periodbleeding]{
                    if isMarital{ answer(pregnant)
                        if isAnswered[pregnant]{ answer(fibroma)
                            if havePregnant && questions[pregnant].noDescrioption{
                                questions[pregnant].writeDescription()
                            }else if !havePregnant{
                                questions[pregnant].disableDescription()
                            }
                        }
                    }else{ answer(fibroma) }
                }
                if isAnswered[fibroma]{ answer(breastCancer) }
                if isAnswered[breastCancer]{ answer(ovarianCyst) }
                if isAnswered[ovarianCyst]{ answer(mouth) }
            }else{ answer(mouth) }
        }
        if isAnswered[mouth]{ answer(metetarsus) }
        if isAnswered[metetarsus]{ answer(bloodConcentration) }
        if isAnswered[bloodConcentration]{ answer(platelet) }
        if isAnswered[platelet]{ answer(hairloss) }
        if isAnswered[hairloss]{
            if haveHairloos{ answer(hairlossLocation)
                if isAnswered[hairlossLocation]{ answer(constipation) }
            }else{ answer(constipation) }
        }
        if isAnswered[constipation]{ answer(sleepjump) }
        if isAnswered[sleepjump]{ answer(activity) }
        if isAnswered[activity]{
            if isActive{
                answer(activityDays)
                if isAnswered[activityDays]{ answer(activityTime) }
                if isAnswered[activityTime]{ answer(vitaminDeficiencyD) }
            }else if isActivePro {
                answer(activityType)
                if isAnswered[activityType]{ answer(activityDays)
                    if haveOtherSport && questions[activityType].noDescrioption{
                        questions[activityType].writeDescription()
                    }else if !haveOtherSport{
                        questions[activityType].disableDescription()
                    }
                }
                if isAnswered[activityDays]{ answer(activityTime) }
                if isAnswered[activityTime]{ answer(activityWeekDays) }
                if isAnswered[activityWeekDays]{ answer(activityStartTime) }
                if isAnswered[activityStartTime]{ answer(activityIntensity) }
                if isAnswered[activityIntensity]{ answer(bodySize) }
                if isAnswered[bodySize]{ answer(activityDietGoal) }
                if isAnswered[activityDietGoal]{ answer(vitaminDeficiencyD) }
            }else{ answer(vitaminDeficiencyD) }
        }
        if isAnswered[vitaminDeficiencyD]{ answer(kidneyStone) }
        if isAnswered[kidneyStone]{ answer(ms) }
        if isAnswered[ms]{ answer(arthritis) }
        if isAnswered[arthritis]{ answer(rheumatoidArthritis)
            if haveArthritis && questions[arthritis].noDescrioption {
                questions[arthritis].writeDescription()
            }else if !haveArthritis{
                questions[arthritis].disableDescription()
            }
        }
        if isAnswered[rheumatoidArthritis]{ answer(thinningDrugs) }
        if isAnswered[thinningDrugs]{ answer(epilepsy) }
        if isAnswered[epilepsy]{ answer(cramp) }
        if isAnswered[cramp]{ answer(headache) }
        if isAnswered[headache]{ answer(glucose) }
        if isAnswered[glucose]{ answer(gallbladder) }
        if isAnswered[gallbladder]{ answer(pressure) }
        if isAnswered[pressure]{ answer(liver) }
        if isAnswered[liver]{ answer(anemia) }
        if isAnswered[anemia]{ answer(stomach) }
        if isAnswered[stomach]{
            if haveHighStomch{ answer(stomachIncreasing)
                if isAnswered[stomachIncreasing]{ answer(mary)
                    if haveStomachIncreasing && questions[stomachIncreasing].noDescrioption{
                        questions[stomachIncreasing].writeDescription()
                    }else if !haveStomachIncreasing{
                        questions[stomachIncreasing].disableDescription()
                    }
                }
            }else{ answer(mary) }
        }
        if isAnswered[mary]{ answer(fat) }
        if isAnswered[fat]{ answer(fatCholesterol) }
        if isAnswered[fatCholesterol]{ answer(thyroid) }
        if isAnswered[thyroid]{ answer(uric) }
        if isAnswered[uric]{ answer(bloodUrea) }
        if isAnswered[bloodUrea]{ answer(bloodCreatinine)
            if haveHighBloodUrea && questions[bloodUrea].noDescrioption{
                questions[bloodUrea].writeDescription()
            }else if !haveHighBloodUrea{
                questions[bloodUrea].disableDescription()
            }
        }
        if isAnswered[bloodCreatinine]{ answer(fingernail)
            if haveHighBloodCreatinine && questions[bloodCreatinine].noDescrioption{
                questions[bloodCreatinine].writeDescription()
            }else if !haveHighBloodCreatinine{
                questions[bloodCreatinine].disableDescription()
            }
        }
        if isAnswered[fingernail]{ answer(covid19) }
        if isAnswered[covid19]{ answer(hemorrhoid) }
        if isAnswered[hemorrhoid] {
            if canChooseLunch{
                answer(lunch)
                if isAnswered[lunch]{
                    if !isFirstTime{
                        answer(walkingStatus)
                        if isAnswered[walkingStatus]{ answer(foodsStatus) }
                        if isAnswered[foodsStatus]{ answer(refreshmentsStatus) }
                        if isAnswered[refreshmentsStatus]{ answer(vitaminsStatus) }
                        if isAnswered[vitaminsStatus]{ if !havePregnant { answer(weightGoal) } }
                    }else{ if !havePregnant { answer(weightGoal) } }
                }
            }else{
                if !isFirstTime{
                    answer(walkingStatus)
                    if isAnswered[walkingStatus]{ answer(foodsStatus) }
                    if isAnswered[foodsStatus]{ answer(refreshmentsStatus) }
                    if isAnswered[refreshmentsStatus]{ answer(vitaminsStatus) }
                    if isAnswered[vitaminsStatus]{ if !havePregnant { answer(weightGoal) } }
                }else{ if !havePregnant { answer(weightGoal) } }
            }
        }
        if isAnswered[weightGoal] ||
            !isFirstTime && isAnswered[vitaminsStatus] && havePregnant ||
            isFirstTime && isAnswered[lunch] && havePregnant ||
            isFirstTime && havePregnant && isAnswered[hemorrhoid] { answer(family) }
        if isAnswered[family]{
            if hasFamily{
                answer(name)
                answer(mobile)
            }
            answer(explanations)
            answer(disease)
            if canChooseFood {
                answer(hatedfood)
                answer(favoritefood)
            }
            if isActivePro{ answer(supplement) }
        }
    }
    
    //MARK: START
    func start(question: Int) {
        questions[question].shadow(.zero, gray04, 2, 0.6)
        questions[question].initView()
        formContainer.addSubview(questions[question])
        questions[question].y(preY(question: question))
    }
    
    //MARK: ANSWER
    func answer(_ question: Int){
        questions[question].startView()
    }
    
    //MARK: OPEN UN ANSWERED
    func openUnAnswered(){
        var question = [Int]()
        for q in questions{
            if q.enable && !isAnswered[q.q] && q.model.mode != TEXT {
                question.append(q.q)
            }
        }
        if question.count>0{
            if !questions[question[0]].isOpen {
                questions[question[0]].openAnswers()
                questions[question[0]].selectedColors()
            }
        }
        
    }
    
    //MARK: QUESTION POSITION
    func questionsDimPos(){
        for q in questions{
            if q.enable{
                q.animate(y: y(question: q.q), duration, curve)
                q.animate(height: q.cellHeight, duration, curve)
            }
        }
        formContainer.animate(height: formHeight, duration, curve)
    }
    
    //MARK: FOCUS
    func onFocus(question: Int) {
        inEditting = true
        questionsDimPos()
        saveText()
        centered(question: question)
        for q in questions{ if q.isOpen{ q.closeAnswers() } }
        focus()
    }
    
    func focus(){
        delegateSpecialForm?.focus()
    }
        
    var inEditting = false
    //MARK: CENTERED QUESTION
    func centered(question: Int){
        inEditting = true
        let reminingDown = questions.reduce(into: CGFloat(), { total, q in
            total += q.q > question && q.enable ? q.cellHeight : 0
        })
        let cellHeight = questions[question].cellHeight
        let btm        = btmForm - keyHeight/2
        let center     = btm + reminingDown - height/2 + cellHeight/2
        let isFocus    = questions[question].isFocus
        let haveNext   = reminingDown > 0
        let isDown     = center < topForm
        let isUp       = center > btmForm
        let y = !isScrollable ? height/2 : isDown ? haveNext && isUp || isFocus ? center : btm : topForm
        formContainer.animate(height: formHeight, duration, curve)
        formContainer.animate(y: y, duration, curve)
    }
    
    //MARK: OBSERVER KEYBOARD
    func observerKeyboard(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardMovements(notification:)),
                                               name: UIApplication.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    var keyHeight = CGFloat()
    @objc func handleKeyboardMovements(notification: Notification) {
        let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect).height
        if keyHeight != height { keyHeight = height - btmFrame.height - cellHeight*2 }
    }
    
    //MARK: FORM HEIGHT
    var formHeight: CGFloat{
        var result = CGFloat()
        questions.forEach({ q in if q.enable { result += q.cellHeight } })
        return result
    }
    
    //MARK: ROW
    func row(question: Int)-> Int{
        var result = 1
        var i = question
        while i != 0{
            i -= 1
            if isAnswered[i]{ result += 1 }
        }
        return result
    }
    
    //MARK: PREVIOUS QUESTION Y
      func preY(question: Int) -> CGFloat{
          var result: CGFloat = questions[question].cellHeight/2
          var j = question
          while j != 0{
              j -= 1
              if questions[j].enable{
                result += questions[j].y + questions[j].minHeight + questions[j].answerHeight/2
                  break
              }
          }
          return result
      }
    
    //MARK: QUESTION Y
    func y(question: Int) -> CGFloat{
        var result: CGFloat = questions[question].cellHeight/2
        var j = question
        while j != 0{
            j -= 1
            if questions[j].enable{
                result += questions[j].y + questions[j].height/2
                break
            }
        }
        return result
    }
    
    func closeKeyboard(){
        for question in questions{ if question.isFocus{ question.closeKeyboard() } }
    }
    
    func stopSound(){
        for question in questions{ question.player?.stop() }
    }
    
    //MARK: REMOVE
    func remove(question: Int) {
        questions[question].remove()
    }
    
    //MARK: OPEN
    func open(question: Int) {
        for qs in questions{
            if qs.isFocus{ qs.closeAnswers() }
            if qs.q != question &&
                qs.enable &&
                qs.isOpen{ qs.closeAnswers() }
        }
        questionsDimPos()
        centered(question: question)
        open()
    }
    
    func open() {
        delegateSpecialForm?.open()
    }
    
    //MARK: CLOSE
    func closeAnswers(){
        questionsDimPos()
    }
    
    //MARK: END EDDITING
    func endEditting() {
        keyHeight = 0
        inEditting = false
        if isAnswered[pregnant] && !isAnswered[childbirth] && !isMenopause { answer(childbirth) }
        if isAnswered[pregnant] && isMenopause && !isAnswered[fibroma] { answer(fibroma) }
        if isAnswered[activityType] && !isAnswered[activityDays] { answer(activityDays) }
        if isAnswered[arthritis] && !isAnswered[rheumatoidArthritis] { answer(rheumatoidArthritis) }
        if isAnswered[stomachIncreasing] && !isAnswered[mary] { answer(mary) }
        if isAnswered[bloodUrea] && !isAnswered[bloodCreatinine] { answer(bloodCreatinine) }
        if isAnswered[bloodCreatinine] && !isAnswered[fingernail] { answer(fingernail) }
        questionsDimPos()
        openUnAnswered()
        var _ = Timer.schedule(0.1) { _ in self.fixPos() }
    }
    
    //MARK: ON KEYBOARD DISMISS
    @objc func fixPos(){
        if formContainer.y < btmForm && !inEditting{
            formContainer.animate(y: btmForm, 1, curve)
        }
    }
    
    //MARK: SAVE
    func save(){
        specialInformation.feetsleep           = questions[feetsleep].result
        specialInformation.bloat               = questions[bloat].result
        specialInformation.diarrhea            = questions[diarrhea].result
        specialInformation.appetite            = questions[appetite].result
        specialInformation.periodbleeding      = questions[periodbleeding].result
        specialInformation.periodpain          = questions[periodpain].result
        specialInformation.pregnant            = questions[pregnant].result
        specialInformation.childbirth          = questions[childbirth].result
        specialInformation.breastfeeding       = questions[breastfeeding].result
        specialInformation.dairySensitivity    = questions[dairySensitivity].result
        specialInformation.fibroma             = questions[fibroma].result
        specialInformation.breastCancer        = questions[breastCancer].result
        specialInformation.ovarianCyst         = questions[ovarianCyst].result
        specialInformation.mouth               = questions[mouth].result
        specialInformation.metatarsus          = questions[metetarsus].results
        specialInformation.bloodConcentration  = questions[bloodConcentration].result
        specialInformation.platelet            = questions[platelet].result
        specialInformation.hairloss            = questions[hairloss].results
        specialInformation.hairlossLocation    = questions[hairlossLocation].result
        specialInformation.constipation        = questions[constipation].result
        specialInformation.sleepjump           = questions[sleepjump].result
        specialInformation.activity            = questions[activity].result
        specialInformation.activityType        = questions[activityType].result
        specialInformation.activityDays        = questions[activityDays].result
        specialInformation.activityTime        = questions[activityTime].result
        specialInformation.activityWeekDays    = questions[activityWeekDays].results
        specialInformation.activityStartTime   = questions[activityStartTime].result
        specialInformation.activityIntensity   = questions[activityIntensity].result
        specialInformation.bodySize            = questions[bodySize].result
        specialInformation.activityDietGoal    = questions[activityDietGoal].result
        specialInformation.vitaminDeficiencyD  = questions[vitaminDeficiencyD].result
        specialInformation.kidneyStone         = questions[kidneyStone].result
        specialInformation.ms                  = questions[ms].result
        specialInformation.arthritis           = questions[arthritis].result
        specialInformation.rheumatoidArthritis = questions[rheumatoidArthritis].result
        specialInformation.thinningDrugs       = questions[thinningDrugs].results
        specialInformation.epilepsy            = questions[epilepsy].result
        specialInformation.cramp               = questions[cramp].result
        specialInformation.headache            = questions[headache].result
        specialInformation.glucose             = questions[glucose].result
        specialInformation.gallbladder         = questions[gallbladder].result
        specialInformation.pressure            = questions[pressure].result
        specialInformation.liver               = questions[liver].result
        specialInformation.anemia              = questions[anemia].result
        specialInformation.stomach             = questions[stomach].result
        specialInformation.stomachIncreasing   = questions[stomachIncreasing].result
        specialInformation.mary                = questions[mary].result
        specialInformation.fat                 = questions[fat].result
        specialInformation.fatCholesterol      = questions[fatCholesterol].result
        specialInformation.thyroid             = questions[thyroid].result
        specialInformation.uric                = questions[uric].result
        specialInformation.bloodUrea           = questions[bloodUrea].result
        specialInformation.bloodCreatinine     = questions[bloodCreatinine].result
        specialInformation.fingernail          = questions[fingernail].results
        specialInformation.covid19             = questions[covid19].result
        specialInformation.hemorrhoid          = questions[hemorrhoid].result
        specialInformation.lunch               = questions[lunch].result
        specialInformation.walkingStatus       = questions[walkingStatus].result
        specialInformation.foodsStatus         = questions[foodsStatus].result
        specialInformation.refreshmentsStatus  = questions[refreshmentsStatus].result
        specialInformation.vitaminsStatus      = questions[vitaminsStatus].result
        specialInformation.weightGoal          = questions[weightGoal].result
        specialInformation.family              = questions[family].result
    }
    
    //MARK: SAVE TEXT
    func saveText(){
        specialInformation.pregnantMonths               = questions[pregnant].text
        specialInformation.activityOther                = questions[activityType].text
        specialInformation.arthritisDescription         = questions[arthritis].text
        specialInformation.bloodUreaDescription         = questions[bloodUrea].text
        specialInformation.bloodCreatinineDescription   = questions[bloodCreatinine].text
        specialInformation.stomachIncreasingDescription = questions[stomachIncreasing].text
        specialInformation.similar                      = questions[name].text
        specialInformation.similarMobile                = questions[mobile].text
        specialInformation.explanations                 = questions[explanations].text
        specialInformation.disease                      = questions[disease].text
        specialInformation.hatedfood                    = questions[hatedfood].text
        specialInformation.favoritefood                 = questions[favoritefood].text
        specialInformation.supplement                   = questions[supplement].text
    }
    
    //MARK: CELEAR
    func clearNeeded(){
        if !haveChild{
            specialInformation.breastfeeding = String()
            clear(breastfeeding)
            specialInformation.dairySensitivity = String()
            clear(dairySensitivity)
        }
        if !haveBreastfeeding{
            specialInformation.dairySensitivity = String()
            clear(dairySensitivity)
        }
        if !haveHairloos{
            specialInformation.hairlossLocation = String()
            clear(hairlossLocation)
        }
        if isMenopause{
            specialInformation.periodpain = String()
            clear(periodpain)
            specialInformation.childbirth = String()
            clear(childbirth)
            specialInformation.breastfeeding = String()
            clear(breastfeeding)
            specialInformation.dairySensitivity = String()
            clear(dairySensitivity)
        }
        if !isMan && !isBaby{
            if !isMarital{
                specialInformation.pregnant = String()
                clear(pregnant)
                specialInformation.childbirth = String()
                clear(childbirth)
                specialInformation.breastfeeding = String()
                clear(breastfeeding)
                specialInformation.dairySensitivity = String()
                clear(dairySensitivity)
            }
        }else{
            specialInformation.periodbleeding = String()
            clear(periodbleeding)
            specialInformation.pregnant = String()
            clear(pregnant)
            specialInformation.childbirth = String()
            clear(childbirth)
            specialInformation.breastfeeding = String()
            clear(breastfeeding)
            specialInformation.dairySensitivity = String()
            clear(dairySensitivity)
            specialInformation.fibroma = String()
            clear(fibroma)
            specialInformation.breastCancer = String()
            clear(breastCancer)
            specialInformation.ovarianCyst = String()
            clear(ovarianCyst)
        }
        if !isActive && !isActivePro{
            specialInformation.activityDays = String()
            clear(activityDays)
            specialInformation.activityTime = String()
            clear(activityTime)
        }
        
        if !isActivePro{
            specialInformation.activityType = String()
            clear(activityType)
            specialInformation.activityWeekDays = [String]()
            clear(activityWeekDays)
            specialInformation.activityStartTime = String()
            clear(activityStartTime)
            specialInformation.activityIntensity = String()
            clear(activityIntensity)
            specialInformation.bodySize = String()
            clear(bodySize)
            specialInformation.activityDietGoal = String()
            clear(activityDietGoal)
            specialInformation.supplement = String()
            clear(supplement)
        }
        
        if !haveHighStomch{
            specialInformation.stomachIncreasing = String()
            clear(stomachIncreasing)
        }
        if !haveStomachIncreasing{
            specialInformation.stomachIncreasingDescription = String()
        }
        if !canChooseLunch{
            specialInformation.lunch = String()
            clear(lunch)
        }
        if isFirstTime{
            specialInformation.walkingStatus = String()
            clear(walkingStatus)
            specialInformation.foodsStatus = String()
            clear(foodsStatus)
            specialInformation.refreshmentsStatus = String()
            clear(refreshmentsStatus)
            specialInformation.vitaminsStatus = String()
            clear(vitaminsStatus)
        }
        if !canChooseFood{
            specialInformation.favoritefood = String()
            clear(favoritefood)
            specialInformation.hatedfood = String()
            clear(hatedfood)
        }
        if !hasFamily{
            specialInformation.similar = String()
            clear(name)
            specialInformation.similarMobile = String()
            clear(mobile)
        }
        if havePregnant{
            specialInformation.weightGoal = String()
            clear(weightGoal)
        }
    }
    
    
    //MARK: CLEAR QUESIONER
    func clear(_ question: Int){
        if questions[question].enable{ questions[question].closeView() }
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        formContainer.animate(y: formHeight/2+height+btmFrame.height, 1, curve)
    }
}
