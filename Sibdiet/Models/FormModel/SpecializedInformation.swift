//
//  SpecializedInformation.swift
//  Sibdiet
//
//  Created by amin sadeghian on 2/25/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import Foundation

class SpecializedInformation{
    
    //MARK: - 00 FEET SLEEP  خواب رفتگی دست و پا
    var feetsleep: String{
        get{ standard.string(forKey: "feetsleepSI") ?? String() }
        set{ standard.set(newValue, forKey: "feetsleepSI") }
    }
    private var feetsleepResult: String{
        var result = String()
        switch feetsleep {
        case NADARAM, Not_Have: result = NOT_HAVE
        case KAM, Low: result = LOW
        case ZIAD, High: result = HIGH
        default: break
        }
        return result
    }
    
    //MARK: - 01 BLOAT نفخ
    var bloat: String{
        get{ standard.string(forKey: "bloatSI") ?? String() }
        set{ standard.set(newValue, forKey: "bloatSI") }
    }
    private var bloatResult: String{
        var result = String()
        switch bloat {
        case NADARAM, Not_Have: result = NOT_HAVE
        case KAM, Low: result = LOW
        case ZIAD, High: result = HIGH
        default: break
        }
        return result
    }
    
    //MARK: - 02 DIARRHEA اسهال
    var diarrhea: String{
        get{ standard.string(forKey: "diarrheaSI") ?? String() }
        set{ standard.set(newValue, forKey: "diarrheaSI") }
    }
    private var diarrheaResult: String{
        var result = String()
        switch diarrhea {
        case NADARAM, Not_Have: result = NOT_HAVE
        case KAM, Low: result = LOW
        case ZIAD, High: result = HIGH
        default: break
        }
        return result
    }
    
    //MARK: - 03 APPETITE اشتها
    var appetite: String{
        get{ standard.string(forKey: "appetiteSI") ?? String() }
        set{ standard.set(newValue, forKey: "appetiteSI") }
    }
    private var appetiteResult: String{
        var result = String()
        switch appetite {
        case MAMOLI, Normal: result = NORMAL
        case KAM, Low: result = LOW
        case ZIAD, High: result = HIGH
        default: break
        }
        return result
    }
    
    //MARK: - 04 PERIOD BLEEDING خونریزی دوره پریود
    var periodbleeding: String{
        get{ standard.string(forKey: "periodbleedingSI") ?? String() }
        set{ standard.set(newValue, forKey: "periodbleedingSI") }
    }
    private var periodbleedingResult: String{
        var result = String()
        switch periodbleeding {
        case MAMOLI, Normal: result = NORMAL
        case KAM, Low: result = LOW
        case ZIAD, High: result = HIGH
        case YAESTEGI, Menopause: result = MENOPAUSE
        case NADARAM, Not_Have: result = NOT_HAVE
        default: break
        }
        return result
    }
    var isMenopause: Bool{ periodbleedingResult == MENOPAUSE }
    
    //MARK: - 05 PERIODPAIN درد دوره پریود
    var periodpain: String{
        get{ standard.string(forKey: "periodpainSI") ?? String() }
        set{ standard.set(newValue, forKey: "periodpainSI") }
    }
    private var periodpainResult: String{
        var result = String()
        switch periodpain {
        case MAMOLI, Normal: result = NORMAL
        case KAM, Low: result = LOW
        case ZIAD, High: result = HIGH
        default: break
        }
        return result
    }
    
    //MARK: - 06 PREGNANT آیا باردار هستید؟
    var pregnant: String{
        get{ standard.string(forKey: "pregnantSI") ?? String() }
        set{ standard.set(newValue, forKey: "pregnantSI") }
    }
    var pregnantResult: String{
        var result = String()
        switch pregnant {
        case KHEYR, No: result = JNO
        case BALE, Yes: result = JYES
        default: break
        }
        return  result
    }
    var havePregnant: Bool{ pregnantResult == JYES }
    var pregnantMonths: String{
        get{ standard.string(forKey: "pregnantMonthsSI") ?? String() }
        set{ standard.set(newValue, forKey: "pregnantMonthsSI") }
    }
    
    //MARK: - 07 CHILD BIRTH زایمان
    var childbirth: String{
        get{ standard.string(forKey: "childbirthSI") ?? String() }
        set{ standard.set(newValue, forKey: "childbirthSI") }
    }
    private var childbirthResult: String{
        var result = String()
        switch childbirth {
        case NADASHTAM, Not_Had: result = HAD_NOT
        case DASHTAM, Had: result = HAD
        default: break
        }
        return result
    }
    var haveChild: Bool{ childbirthResult == HAD }
    
    //MARK: - 08 BREAST FEEDING در حال حاضر شیردهی
    var breastfeeding: String{
        get{ standard.string(forKey: "breastfeedingSI") ?? String() }
        set{ standard.set(newValue, forKey: "breastfeedingSI") }
    }
    var breastfeedingResult: String{
        var result = ""
        switch breastfeeding {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        default: break
        }
        return result
    }
    var haveBreastfeeding: Bool{ breastfeedingResult == HAVE }
    
    //MARK: - 09 DAIRY SENSITIVITY در شیردهی به لبنیات حساس هستید؟
    var dairySensitivity: String{
        get{ standard.string(forKey: "dairySensitivitySI") ?? String() }
        set{ standard.set(newValue, forKey: "dairySensitivitySI") }
    }
    private var dairySensitivityResult: String{
        var result = String()
        switch dairySensitivity {
        case KHEYR, No: result = JNO
        case BALE, Yes: result = JYES
        default: break
        }
        return  result
    }
    
    //MARK: - 10 FIBROMA مشکل فیبروم
    var fibroma: String{
        get{ standard.string(forKey: "fibromaSI") ?? String() }
        set{ standard.set(newValue, forKey: "fibromaSI") }
    }
    private var fibromaResult: String{
        var result = String()
        switch fibroma {
        case NADARAM, Not_Have: result = NOT_HAVE
        case ZIAD, High: result = HIGH
        case KAM, Low: result = LOW
        default: break
        }
        return  result
    }
    
    //MARK: - 11 BREAST CANCER مشکل سرطان پستان
    var breastCancer: String{
        get{ standard.string(forKey: "breastCancerSI") ?? String() }
        set{ standard.set(newValue, forKey: "breastCancerSI") }
    }
    private var breastCancerResult: String{
        var result = String()
        switch breastCancer {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        case GHABLAN_DASHTAM, Had_Before: result = HAD_BEFORE
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default:  break
        }
        return  result
    }
    
    //MARK: - 12 OVARIAN CYST مشکل کیست تخمدان
    var ovarianCyst: String{
        get{ standard.string(forKey: "ovarianCystSI") ?? String() }
        set{ standard.set(newValue, forKey: "ovarianCystSI") }
    }
    private var ovarianCystResult: String{
        var result = String()
        switch ovarianCyst {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        case GHABLAN_DASHTAM, Had_Before: result = HAD_BEFORE
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default:  break
        }
        return  result
    }
    
    //MARK: - 13 MOUTH طعم دهان
    var mouth: String{
        get{ standard.string(forKey: "mouthSI") ?? String() }
        set{ standard.set(newValue, forKey: "mouthSI") }
    }
    private var mouthResult: String{
        var result = String()
        switch mouth {
        case HICH, None: result = JNONE
        case TALKH, Bitter: result = BITTER
        case SHIRIN, Sweet: result = SWEET
        case TORSH, Sour: result = SOUR
        case SHOR, Saline: result = SALINE
        default: break
        }
        return result
    }
    
    //MARK: - 14 METETARSUS کف پا
    var metatarsus: [String]{
        get{ standard.array(forKey: "metatarsusSI") as? [String] ?? [String]() }
        set{ standard.set(newValue, forKey: "metatarsusSI") }
    }
    private var metetarsusAnswers: String{
        var result = String()
        let count = metatarsus.count
        for m in metatarsus{
            result += count>1 && metatarsus[count-1] != m ? "\(m)\(isRTL ? "،" : ",") " : m
        }
        return result
    }
    private var metatarsusResult: [String]{
        var result = [String]()
        for m in metatarsus{
            switch m {
            case MAMOLI, Normal: result.append(NOT_KNOW)
            case YAKH, Freeze: result.append(BE_FREEZE)
            case DAGH, Hot: result.append(BE_HOT)
            case KHOSHK, DRY_CRACKED : result.append(BE_DRY)
            default: break
            }
        }
        return result
    }
    
    //MARK: - 15 BLOOD CONCENTRATION مشکلات غلظت خون
    var bloodConcentration: String{
        get{ standard.string(forKey: "bloodConcentrationSI") ?? String() }
        set{ standard.set(newValue, forKey: "bloodConcentrationSI") }
    }
    private var bloodConcentrationResult: String{
        var result = String()
        switch bloodConcentration {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return  result
    }
    
    //MARK: - 16 PLATELET مشکل پلاکت (plt)
    var platelet: String{
        get{ standard.string(forKey: "plateletSI") ?? String() }
        set{ standard.set(newValue, forKey: "plateletSI") }
    }
    private var plateletResult: String{
        var result = String()
        switch platelet {
        case MAMOLI_150_400, NORMAL_150_400: result = NORMAL
        case PAEIN_150, DOWN_150: result = DOWN
        case BALA_400, UP_400: result = UP
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    
    //MARK: - 17 HAIR LOSS مشکلات مو
    var hairloss: [String]{
        get{ standard.array(forKey: "hairlossSI") as? [String] ?? [String]() }
        set{ standard.set(newValue, forKey: "hairlossSI") }
    }
    var hairlossAnswers: String{
        var result = String()
        let count = hairloss.count
        for m in hairloss{
            result += count>1 && hairloss[count-1] != m ? "\(m)\(isRTL ? "،" : ",") " : m
        }
        return result
    }
    var hairlossResult: [String]{
        var result = [String]()
        for h in hairloss{
            switch h {
            case RIZESH_ZIAD, High_Loss: result.append(HIGH_LOSS)
            case RIZESH_SEKEI, Coins_Loss: result.append(COINS_LOSS)
            case KHOSHK_SHEKANANDE, Dry_Brittle: result.append(DRY_BRITTLE)
            case CHARB, Oily: result.append(OILY)
            case MOKHORE, Has_trichoptilosis: result.append(TRICHOPTILOSIS)
            case SEFIDI_ZOODRES, Premature_graying: result.append(PREMATURE_GRAYING)
            case MAMOLI, Normal: result.append(Normal)
            default: break
            }
        }
        return result
    }
    var haveHairloos : Bool{
        var bool = false
        for h  in hairloss{
            if h == RIZESH_ZIAD ||
                h == RIZESH_SEKEI ||
                h == Coins_Loss ||
                h == High_Loss{
                bool = true
            }
        }
        return bool
    }
    
    //MARK: - 18 HAIR LOSS LOCATION محل ریزش مو
    var hairlossLocation: String{
        get{ standard.string(forKey: "hairlossLocationSI") ?? String() }
        set{ standard.set(newValue, forKey: "hairlossLocationSI") }
    }
    var hairlossLocationResult: String{
        var result = String()
        switch hairlossLocation {
        case AZ_JOLO_SAR, Front_head: result = FRONT
        case AZ_KAF_SAR, Floor_head: result = FLOOR
        case AZ_JOLO_KAF,  Front_floor: result = FRONT_FLOOR
        case TAMAM_GHESMAT, all_parts: result = ALL_PARTS
        case HICHKODAM, None: result = JNONE
        default:
            break
        }
        return result
    }
    
    //MARK: - 19 CONSTIPATION یبوست
    var constipation: String{
        get{ standard.string(forKey: "constipationSI") ?? String() }
        set{ standard.set(newValue, forKey: "constipationSI") }
    }
    private var constipationResult: String{
        var result = String()
        switch constipation {
        case NADARAM, Not_Have: result = NOT_HAVE
        case ZIAD, High: result = HIGH
        case KAM, Low: result = LOW
        default: break
        }
        return result
    }
    
    //MARK: - 20 SLEEP JUMP پرش از خواب
    var sleepjump: String{
        get{ standard.string(forKey: "sleepjumpSI") ?? String() }
        set{ standard.set(newValue, forKey: "sleepjumpSI") }
    }
    private var sleepjumpResult: String{
        var result = String()
        switch sleepjump {
        case NADARAM, Not_Have: result = NOT_HAVE
        case ZIAD, High: result = HIGH
        case KAM, Low: result = LOW
        default: break
        }
        return result
    }
    
    //MARK: - 21 ACTIVITY فعالیت بدنی
    var activity: String{
        get{ standard.string(forKey: "activitySI") ?? String() }
        set{ standard.set(newValue, forKey: "activitySI") }
    }
    var activityResult: String{
        var result = String()
        switch activity {
        case HICH_VARZESH, dont_activities: result = NOT_HAVE
        case PADERAVI, Simple_walking: result = NORMAL
        case GAHAN_VARZESH, Sometimes_recreation: result = SOMETIMES
        case VARZESHKAR, professional_athlete: result = PROFESSIONAL
        default: break
        }
        return result
    }
    var isActivePro: Bool{ activityResult == PROFESSIONAL }
    var isActive   : Bool{ activityResult == NORMAL || activityResult == SOMETIMES }
    
    //MARK: - 22 ACTIVITY TYPE نوع ورزش
    var activityType: String{
        get{ standard.string(forKey: "activityTypeSI") ?? String() }
        set{ standard.set(newValue, forKey: "activityTypeSI") }
    }
    private var activityTypeResult: String{
        var result = String()
        switch activityType {
        case BADANSAZI, Bodybuilding: result = BODYBUILDING
        case ZUMBAF, Zumba: result = ZUMBA
        case TRXF, TRX: result = TRX
        case RAZMI, Martial: result = MARTIAL
        case SHENA, Swim: result = SWIM
        case KOHNAVARDI, Mountaineering: result = MOUNTAINEERING
        case AROBIC, Aerboic: result = AEROBIC
        case VARZESH_TORI, Lace_sports: result = LACE_SPORTS
        case DO_MEYDANI, Track_Field: result = TRACK_AND_FIELD
        case SpinningF, Spinning: result = SPINNING
        case GIMNASTIC, Gymnastics: result = GYMNASTICS
        case SAKHRE_NAVARDI, Rock_climbing: result = ROCK_CLIMBING
        case GHAYEGHRANI, Boating: result = BOATING
        case SKATEF, Skate: result = SKATE
        case SKOASH, Squash: result = SQUASH
        case DOCHARKHE_SAVARI, Bike_riding: result = BIKE_RIDING
        case ASB_SAVARI, Horse_riding: result = HORSE_RIDING
        case KERASFIT, Crossfit: result = CROSSFIT
        case AMADEGI_JESMANI, Physical_readiness: result = PHYSICAL_READINESS
        case BADMINTONF, Badminton: result = BADMINTON
        case TENIS, Tennis: result = TENNIS
        case POWERLIFTINGF, Powerlifting: result = POWERLIFTING
        case BARACELLF, Baracell: result = BARACELL
        case BALLE, Ballet: result = BALLET
        case PILATESF, Pilates: result = PILATES
        case VARZESH_DIGAR, Other_Sports: result = OTHER_SPORTS
        default: break
        }
        return result
    }
    var hasOtherSport: Bool{ activityTypeResult == OTHER_SPORTS }
    var activityOther: String{
        get{ standard.string(forKey: "activityOtherSI") ?? String() }
        set{ standard.set(newValue, forKey: "activityOtherSI") }
    }
    
    //MARK: - 23 ACTIVITY DAYS تعداد روزهای ورزش
    var activityDays: String{
        get{ standard.string(forKey: "activityDaysSI") ?? String() }
        set{ standard.set(newValue, forKey: "activityDaysSI") }
    }
    
    //MARK: - 24 ACTIVITY TIME مدت زمان ورزش در هر روز
    var activityTime: String{
        get{ standard.string(forKey: "activityTimeSI") ?? String() }
        set{ standard.set(newValue, forKey: "activityTimeSI") }
    }
    var activityTimeResult: String{
        var result = String()
        switch activityTime {
        case NIM_SAAT, Half_hour: result = HALF
        case YEK_SAAT, One_hour: result = ONE
        case YEK_NIM, One_half: result = ONE_HALF
        case DO_SAAT, Two: result = TWO
        case SE_SAAT, Three : result = THREE
        case CHAR_SAAT, Four : result = FOUR
        default: break
        }
        return result
    }
    
    //MARK: - 25 ACTIVITY WEEK DAYS
    var activityWeekDays: [String]{
        get{ standard.array(forKey: "activityWeekDaysSI") as? [String] ?? [String]() }
        set{ standard.set(newValue, forKey: "activityWeekDaysSI") }
    }
    private var activityWeekDaysAnswers: String{
        var result = String()
        let count = activityWeekDays.count
        for m in activityWeekDays{
            result += count>1 && activityWeekDays[count-1] != m ? "\(m)\(isRTL ? "،" : ",") " : m
        }
        return result
    }
    var activityWeekDaysResult: [String]{
        var result = [String]()
        for p in activityWeekDays{
            switch p {
            case SHANBE, Saturday: result.append(SATURDAY)
            case YEKSHANBE, Sunday: result.append(SUNDAY)
            case DOSHANBE, Monday: result.append(MONDAY)
            case SESHANBE, Tuesday: result.append(TUESDAY)
            case CHARSHANBE, Wednesday : result.append(WEDNESDAY)
            case PANSHANBE, Thursday : result.append(THURSDAY)
            case JOME, Friday : result.append(FRIDAY)
            default: break
            }
        }
        return result
    }
    
    //MARK: - 26 ACTIVITY SATRT TIME
    var activityStartTime: String{
        get{ standard.string(forKey: "activityStartTimeSI") ?? String() }
        set{ standard.set(newValue, forKey: "activityStartTimeSI") }
    }
    var activityStartTimeResult: String{
        var result = String()
        switch activityStartTime {
        case HAFT_SOBH, AM_7: result = SEVEN
        case HASHT_SOBH, AM_8: result = EIGHT
        case NOH_SOBH, AM_9: result = NINE
        case DAH_SOBH, AM_10: result = TEN
        case YAZDAH_SOBH, AM_11: result = ELEVEN
        case DO_ZOHR, PM_2 : result = FOURTEEN
        case SE_ZOHR, PM_3 : result = FIFTEEN
        case CHAR_ZOHR, PM_4: result = SIXTEEN
        case PANJ_ASR, PM_5: result = SEVENTEEN
        case SHISH_ASR, PM_6: result = EIGHTEEN
        case HASHT_SHAB, PM_8: result = TWENTY
        case NOH_SHAB, PM_9 : result = TWENTY_ONE
        case DAH_SHAB, PM_10 : result = TWENTY_TWO
        default: break
        }
        return result
    }
    
    //MARK: - 27 ACTIVITY INTENSITY
    var activityIntensity: String{
        get{ standard.string(forKey: "activityIntensitySI") ?? String() }
        set{ standard.set(newValue, forKey: "activityIntensitySI") }
    }
    var activityIntensityResult: String{
        var result = String()
        switch activityIntensity {
        case CHEHEL_SHAST_DARSAD, Intensity_40_60: result = INTENSITY_40_60
        case SHAST_HASHTAD_DARSAD, Intensity_60_80: result = INTENSITY_60_80
        case HAFTAD_SAD_DARSAD, Intensity_70_100: result = INTENSITY_70_100
        case HASHTAD_SAD_DARSAD, Intensity_80_100: result = INTENSITY_80_100
        default: break
        }
        return result
    }
    
    //MARK: - 28 BODY SIZE
    var bodySize: String{
        get{ standard.string(forKey: "bodySizeSI") ?? String() }
        set{ standard.set(newValue, forKey: "bodySizeSI") }
    }
    var bodySizeResult: String{
        var result = String()
        switch bodySize {
        case CHAGH, Obese: result = OBESE
        case LAGHAR, Thin: result = THIN
        case AZOLANI, Muscular: result = MUSCLE
        default: break
        }
        return result
    }
    
    //MARK: - 29 ACTIVITY DIET GOAL
    var activityDietGoal: String{
        get{ standard.string(forKey: "activityDietGoalSI") ?? String() }
        set{ standard.set(newValue, forKey: "activityDietGoalSI") }
    }
    var activityDietGoalResult: String{
        var result = String()
        switch activityDietGoal {
        case AFZEYESH_VAZN_HAJM, Weight_gain: result = GOAL01
        case KAHESH_CHARBI_HEFZ_HAJM, Reduce_fat: result = GOAL02
        case KAHESH_CHARBI_AFZAYESH_HAJM, Reduce_fat_increase_muscle: result = GOAL03
        case TASBIT_AFZEYESH_HAJM, Weight_stabilization: result = GOAL04
        case AFZAYESH_HAJM_ESTEGHAMAT, Increase_muscle_mass: result = GOAL05
        case AFZAYESH_HAJM_GHODRAT, Increase_muscle_volume: result = GOAL06
        default: break
        }
        return result
    }
    
    //MARK: - 30 VITAMIN DEFICIENCY D کمبود ویتامین D
    var vitaminDeficiencyD: String{
        get{ standard.string(forKey: "vitaminDeficiencyDSI") ?? String() }
        set{ standard.set(newValue, forKey: "vitaminDeficiencyDSI") }
    }
    private var vitaminDeficiencyDResult: String{
        var result = String()
        switch vitaminDeficiencyD {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    
    //MARK: - 31 KIDNEY STONE سنگ کلیه
    var kidneyStone: String{
        get{ standard.string(forKey: "kidneyStoneSI") ?? String() }
        set{ standard.set(newValue, forKey: "kidneyStoneSI") }
    }
    private var kidneyStoneResult: String{
        var result = String()
        switch kidneyStone {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        case GHABLAN_DASHTAM, Had_Before: result = HAD_BEFORE
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return  result
    }
    
    //MARK: - 32 MS ام اس
    var ms: String{
        get{ standard.string(forKey: "msSI") ?? String() }
        set{ standard.set(newValue, forKey: "msSI") }
    }
    private var msResult: String{
        var result = String()
        switch ms {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        default: break
        }
        return result
    }
    var haveMs: Bool {msResult == HAVE}
    
    //MARK: - 33 ARTHRITIS آرتروز
    var arthritis: String{
        get{ standard.string(forKey: "arthritisSI") ?? String() }
        set{ standard.set(newValue, forKey: "arthritisSI") }
    }
    var arthritisDescription: String{
        get{ standard.string(forKey: "arthritisDescriptionSI") ?? String() }
        set{ standard.set(newValue, forKey: "arthritisDescriptionSI") }
    }
    private var arthritisResult:String{
        var result = String()
        switch arthritis {
        case NADARAM, Not_Have: result = NOT_HAVE
        case TASHKHIS_DOCTOR, Have_Doctor: result = HAVE_DOCTOR
        case FEKR_DARAM, have_osteoarthritis: result = HAVE_OWN
        case GHABLAN_DASHTAM, Had_Before: result = HAD_BEFORE
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return  result
    }
    var arthritisDescriptionEnable: Bool{ arthritisResult == HAVE ||  arthritisResult == HAD_BEFORE }
    
    //MARK: - 34 RHEUMATOID ARTHRITIS آرتریت روماتوئید (روماتیسم مفصلی)
    var rheumatoidArthritis: String{
        get{ standard.string(forKey: "rheumatoidArthritisSI") ?? String() }
        set{ standard.set(newValue, forKey: "rheumatoidArthritisSI") }
    }
    private var rheumatoidArthritisResult: String{
        var result = String()
        switch rheumatoidArthritis {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        case GHABLAN_DASHTAM, Had_Before: result = HAD_BEFORE
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return  result
    }
    
    //MARK: - 35 THINNING DRUGS استفاده از داروهای رقیق کننده
    var thinningDrugs: [String]{
        get{ standard.array(forKey: "thinningDrugsSI") as? [String] ?? [String]() }
        set{ standard.set(newValue, forKey: "thinningDrugsSI") }
    }
    private var thinningDrugsAnswers: String{
        var result = String()
        let count = thinningDrugs.count
        for m in thinningDrugs{
            result += count>1 && thinningDrugs[count-1] != m ? "\(m)\(isRTL ? "،" : ",") " : m
        }
        return result
    }
    private var thinningDrugsResult: [String]{
        var result = [String]()
        for thinningDrug in thinningDrugs{
            switch thinningDrug {
            case PLAVIXF, Plavix: result.append(PLAVIX)
            case CLOPIDOGRELF, Clopidogrel: result.append(CLOPIDOGREL)
            case ASVYKSF, Asvyks: result.append(ASVYKS)
            case HEPARINF, Heparin: result.append(HEPARIN)
            case SLKSANF, Slksan: result.append(SLKSAN)
            case WARFARIN, Warfarin: result.append(Warfarin)
            case ESTEFADE_NEMIKONAM, Not_Use: result.append(JNONE)
            default:
                break
            }
        }
        return  result
    }
    var useDrugs: Bool { thinningDrugsResult.count > 0 && !thinningDrugsResult.contains(JNONE) }
    
    //MARK: - 36 EPILEPSY مشکل صرع
    var epilepsy: String{
        get{ standard.string(forKey: "epilepsySI") ?? String() }
        set{ standard.set(newValue, forKey: "epilepsySI") }
    }
    private var epilepsyResult: String{
        var result = String()
        switch epilepsy {
        case NADARAM, No: result = JNO
        case DARAM, Have: result = JYES
        case GHABLAN_DASHTAM, Had_Before: result = JYES_BEFORE
        default: break
        }
        return  result
    }
    
    //MARK: - 37 CRAMP گرفتگی عضلات
    var cramp: String{
        get{ standard.string(forKey: "crampSI") ?? String() }
        set{ standard.set(newValue, forKey: "crampSI") }
    }
    private var crampResult: String{
        var result = String()
        switch cramp {
        case NADARAM, Not_Have: result = NOT_HAVE
        case KAM, Low: result = LOW
        case ZIAD, High: result = HIGH
        default: break
        }
        return result
    }
    
    //MARK: - 38 HEADACHE سردرد
    var headache: String{
        get{ standard.string(forKey: "headacheSI") ?? String() }
        set{ standard.set(newValue, forKey: "headacheSI") }
    }
    private var headacheResult: String{
        var result = String()
        switch headache {
        case NADARAM, Not_Have: result = NOT_HAVE
        case KAM, Low: result = LOW
        case ZIAD, High: result = HIGH
        case MIGREN, Migrane: result = MIGRANE
        default: break
        }
        return result
    }
    
    //MARK: - 39 GLUCOSE قند خون
    var glucose: String{
        get{ standard.string(forKey: "glucoseSI") ?? String() }
        set{ standard.set(newValue, forKey: "glucoseSI") }
    }
    private var glucoseResult: String{
        var result = String()
        switch glucose {
        case MAMOLI, Normal: result = NORMAL
        case BALA, Up: result = UP
        case PAEIN, Down: result = DOWN
        case LAB_MARZ_100_115, Border_100_115: result = BORDER
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    var haveGlucose: Bool {glucoseResult == UP}
    
    //MARK: - 40 GALLBLADDER کیسه‌ صفرا
    var gallbladder: String{
        get{ standard.string(forKey: "gallbladderSI") ?? String() }
        set{ standard.set(newValue, forKey: "gallbladderSI") }
    }
    private var gallbladderResult: String{
        var result = String()
        switch gallbladder {
        case SALEM, Healthy: result = HEALTHY
        case SANG_DARAD, Has_Stone: result = HAS_STONE
        case KISE_SAFRA_BARDASHT, removed_surgery: result = NO_GALLBLADDER_BY_OPERATION
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    
    //MARK: - 41 PRESSURE فشار خون
    var pressure: String{
        get{ standard.string(forKey: "pressureSI") ?? String() }
        set{ standard.set(newValue, forKey: "pressureSI") }
    }
    private var pressureResult: String{
        var result = String()
        switch pressure {
        case MAMOLI, Normal: result = NORMAL
        case BALA, Up: result = UP
        case PAEIN, Down: result = DOWN
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    var havePressure: Bool{ pressureResult == UP }
    
    //MARK: - 42 LIVER وضعیت کبد
    var liver: String{
        get{ standard.string(forKey: "liverSI") ?? String() }
        set{ standard.set(newValue, forKey: "liverSI") }
    }
    private var liverResult: String{
        var result = String()
        switch liver {
        case SALEM, Normal: result = NORMAL
        case CHARB, Oily: result = OILY
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    var haveLiver: Bool{ liverResult == OILY }
    
    //MARK: - 43 ANEMIA کم خونی
    var anemia: String{
        get{ standard.string(forKey: "anemiaSI") ?? String() }
        set{ standard.set(newValue, forKey: "anemiaSI") }
    }
    private var anemiaResult: String{
        var result = String()
        switch anemia {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        case TALASEMI, Thalassemia: result = THALASSEMIA
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return  result
    }
    
    //MARK: - 44 STOMACH درد یا سوزش معده
    var stomach: String{
        get{ standard.string(forKey: "stomachSI") ?? String() }
        set{ standard.set(newValue, forKey: "stomachSI") }
    }
    private var stomachResult: String{
        var result = String()
        switch stomach {
        case NADARAM, Not_Have: result = NOT_HAVE
        case ZIAD, High: result = HIGH
        case KAM, Low: result = LOW
        default: break
        }
        return result
    }
    var isHighStomch: Bool{ stomachResult == HIGH }
    
    //MARK: - 45 STOMACH INCREASING ارتباطی با مصرف سالاد و میوه جات دارد؟
    var stomachIncreasing: String{
        get{ standard.string(forKey: "stomachIncreasingSI") ?? String() }
        set{ standard.set(newValue, forKey: "stomachIncreasingSI") }
    }
    private var stomachIncreasingResult: String{
        var result = String()
        switch stomachIncreasing {
        case KHEYR, No: result = JNO
        case BALE, Yes: result = JYES
        default: break
        }
        return  result
    }
    var haveStomachIncreasing: Bool{ stomachIncreasingResult == JYES }
    var stomachIncreasingDescription: String{
        get{ standard.string(forKey: "stomachIncreasingDescriptionSI") ?? String() }
        set{ standard.set(newValue, forKey: "stomachIncreasingDescriptionSI") }
    }
    
    //MARK: - 46 MARY ریفلاکس یا همان ترش کردن معده
    var mary: String{
        get{ standard.string(forKey: "marySI") ?? String() }
        set{ standard.set(newValue, forKey: "marySI") }
    }
    private var maryResult: String{
        var result = String()
        switch mary {
        case ASLAN, No_problem: result = NO_PROBLEM
        case GAHI, Sometimes: result = SOMETIMES_PROBLEM
        case BISHTAR_OGHAT, More_often: result = OFTEN_PROBLEM
        default: break
        }
        return result
    }
    var haveMary: Bool {maryResult == OFTEN_PROBLEM}
    
    //MARK: - 47 FAT چربی تری گلیسیرید
    var fat: String{
        get{ standard.string(forKey: "fatSI") ?? String() }
        set{ standard.set(newValue, forKey: "fatSI") }
    }
    private var fatResult: String{
        var result = String()
        switch fat {
        case MAMOLI, Normal: result = NORMAL
        case BALA, Up: result = UP
        case LAB_MARZ_195_205, Border_195_205: result = BORDER
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    var haveFat: Bool{ fatResult == UP }
    
    //MARK: - 48 FAT CHOLESTEROL چربی کلسترول
    var fatCholesterol: String{
        get{ standard.string(forKey: "fatCholesterolSI") ?? String() }
        set{ standard.set(newValue, forKey: "fatCholesterolSI") }
    }
    private var fatCholesterolResult: String{
        var result = String()
        switch fatCholesterol {
        case MAMOLI, Normal: result = NORMAL
        case BALA, Up: result = UP
        case PAEIN, Down: result = DOWN
        case LAB_MARZ_195_230, Border_195_230: result = BORDER
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    var haveFatCholestrol: Bool{ fatCholesterolResult == UP }
    
    //MARK: - 49 THYROID تیروئید
    var thyroid: String{
        get{ standard.string(forKey: "thyroidSI") ?? String() }
        set{ standard.set(newValue, forKey: "thyroidSI") }
    }
    private var thyroidResult: String{
        var result = String()
        switch thyroid {
        case MAMOLI, Normal: result = NORMAL
        case KAMKAR, Low_work: result = LOW_WORK
        case PORKAR, Labor_intensive: result = LABORIOUS
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default:
            break
        }
        return result
    }
    
    //MARK: - 50 URIC اسید اوریک
    var uric: String{
        get{ standard.string(forKey: "uricSI") ?? String() }
        set{ standard.set(newValue, forKey: "uricSI") }
    }
    private var uricResult: String{
        var result = String()
        switch uric {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        case LAB_MARZ_6_7, Border_6_7: result = BORDER
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    var haveUric: Bool{ uricResult == HAVE }
    
    //MARK: - 51 BLOOD UREA اوره بالای خون
    var bloodUrea: String{
        get{ standard.string(forKey: "bloodUreaSI") ?? String() }
        set{ standard.set(newValue, forKey: "bloodUreaSI") }
    }
    private var bloodUreaResult: String{
        var result = String()
        switch bloodUrea {
        case MAMOLI, Normal: result = NORMAL
        case DARAM, Have: result = HAVE
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    var bloodUreaDescriptionEnable: Bool{ bloodUreaResult == HAVE }
    var bloodUreaDescription: String{
        get{ standard.string(forKey: "bloodUreaDescriptionSI") ?? String() }
        set{ standard.set(newValue, forKey: "bloodUreaDescriptionSI") }
    }
    
    //MARK: - 52 BLOOD CREATININE کراتنین بالای خون
    var bloodCreatinine: String{
        get{ standard.string(forKey: "bloodCreatinineSI") ?? String() }
        set{ standard.set(newValue, forKey: "bloodCreatinineSI") }
    }
    private var bloodCreatinineResult: String{
        var result = String()
        switch bloodCreatinine {
        case MAMOLI, Normal: result = NORMAL
        case DARAM, Have: result = HAVE
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return result
    }
    var bloodCreatinineDescription: String{
        get{ standard.string(forKey: "bloodCreatinineDescriptionSI") ?? String() }
        set{ standard.set(newValue, forKey: "bloodCreatinineDescriptionSI") }
    }
    var bloodCreatinineDescriptionEnable: Bool{ bloodCreatinineResult == HAVE }
    
    //MARK: - 53 FINGER NAIL وضعیت ناخن های
    var fingernail: [String]{
        get{ standard.array(forKey: "fingernailSI") as? [String] ?? [String]() }
        set{ standard.set(newValue, forKey: "fingernailSI") }
    }
    private var fingernailAnswers: String{
        var result = String()
        let count = fingernail.count
        for m in fingernail{
            result += count>1 && fingernail[count-1] != m ? "\(m)\(isRTL ? "،" : ",") " : m
        }
        return result
    }
    var fingernailResult: [String]{
        var result = [String]()
        for fingernail in fingernail{
            switch fingernail {
            case MISHEKANAD, Breaks: result.append(BREAKS)
            case VARAGHE, Laminate: result.append(LAMINATE)
            case ROSHD_KAM, Low_Growth: result.append(LOW_GROWTH)
            case SALEM, Healthy: result.append(JNONE)
            default: break
            }
        }
        return result
    }
    
    //MARK: - 54 COVID-19 کوید ۱۹
    var covid19: String{
        get{ standard.string(forKey: "covid19SI") ?? String() }
        set{ standard.set(newValue, forKey: "covid19SI") }
    }
    var covid19Result: String{
        var result = String()
        switch covid19 {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        case GHABLAN_DASHTAM, Had_Before: result = HAD_BEFORE
        case MASHKOK, Suspicious: result = HAVE
        default: break
        }
        return  result
    }
    var haveCovid: Bool{ covid19Result == HAVE }
    
//    //MARK: - 55 VEGETARIAN گیاهخوار vegetarian
//    var vegetarian: String{
//        get{ standard.string(forKey: "vegetarianSI") ?? String() }
//        set{ standard.set(newValue, forKey: "vegetarianSI") }
//    }
//    var vegetarianResult: String{
//        var result = String()
//        switch vegetarian {
//        case KHEYR, No: result = JNO
//        case BALE, Yes: result = JYES
//        default: break
//        }
//        return  result
//    }
//    var isVegetarian :Bool { vegetarianResult == JYES }
    
    //MARK: - 55 HEMORRHOID هموروئید (بواسیر یا همان فیشر)
    var hemorrhoid: String{
        get{ standard.string(forKey: "hemorrhoidSI") ?? String() }
        set{ standard.set(newValue, forKey: "hemorrhoidSI") }
    }
    var hemorrhoidResult: String{
        var result = String()
        switch hemorrhoid {
        case NADARAM, Not_Have: result = NOT_HAVE
        case DARAM, Have: result = HAVE
        case GHABLAN_DASHTAM, Had_Before: result = HAD_BEFORE
        case NEMIDANAM, Not_Know: result = NOT_KNOW
        default: break
        }
        return  result
    }
    var haveHemorrhoid: Bool { hemorrhoidResult == HAVE }
    
//    //MARK: - 57 ECONOMIC اقتصادی
//    var economic: String{
//        get{ standard.string(forKey: "economicSI") ?? String() }
//        set{ standard.set(newValue, forKey: "economicSI") }
//    }
//    var economicResult: String{
//        var result = String()
//        switch economic {
//        case KHEYR, No: result = JNO
//        case BALE, Yes: result = JYES
//        default: break
//        }
//        return  result
//    }
//    var cantEconomical: Bool { isBaby || (havePregnant && !isMan) || (haveBreastfeeding && !isMan) || haveCovid || isVegetarian || isActivePro  || haveMs || haveHemorrhoid || useDrugs || haveGlucose || havePressure || haveLiver || isHighStomch || haveMary || haveFatCholestrol || haveUric ||  bloodUreaDescriptionEnable || bloodCreatinineDescriptionEnable }
    
    //MARK: - 56 LUNCH ناهار
    var lunch: String{
        get{ standard.string(forKey: "lunchSI") ?? String() }
        set{ standard.set(newValue, forKey: "lunchSI") }
    }
    private var lunchResult:String{
        var result = String()
        switch lunch {
        case GHAZA_MANZEL, Eat_home_food: result = EAT_AT_HOME
        case GHAZA_KAR, Eat_work_food: result = EAT_AT_WORK
        case GHAZA_RESTURAN, Eat_restaurant_food: result = EAT_AT_RESTAURANT
        default: break
        }
        return result
    }
    var canChooseLunch: Bool  { !isHighStomch && !havePressure && !haveUric }

    
    //MARK: - 57 WALKING STATUS نحوه اجرای پیاده روی طبق دستور
    var walkingStatus: String{
        get{ standard.string(forKey: "walkingStatusSI") ?? String() }
        set{ standard.set(newValue, forKey: "walkingStatusSI") }
    }
    private var walkingStatusResult: String{
        var result = String()
        switch walkingStatus {
        case SAD_DAR_SAD, Done_100: result = DONE_100
        case KAM_BISH, Done_50: result = DONE_50
        case ANJAM_NADADAM, Done_0: result = DONE_0
        default: break
        }
        return result
    }
    
    //MARK: - 58 FOODS STATUS نحوه اجرای غذاها
    var foodsStatus: String{
        get{ standard.string(forKey: "foodsStatusSI") ?? String() }
        set{ standard.set(newValue, forKey: "foodsStatusSI") }
    }
    private var foodsStatusResult: String{
        var result = String()
        switch foodsStatus {
        case SAD_DAR_SAD, Done_100: result = DONE_100
        case KAM_BISH, Done_50: result = DONE_50
        case ANJAM_NADADAM, Done_0: result = DONE_0
        default: break
        }
        return result
    }
    
    //MARK: - 59 REFRESHMENTS STATUS در حین رژیم در مورد تنقلات
    var refreshmentsStatus: String{
        get{ standard.string(forKey: "refreshmentsStatusSI") ?? String() }
        set{ standard.set(newValue, forKey: "refreshmentsStatusSI") }
    }
    private var refreshmentsStatusResult: String{
        var result = String()
        switch refreshmentsStatus {
        case SAD_DAR_SAD_RAAYAT, Observe_100: result = OBSERVE_100
        case KAM_BISH_RAAYAT, Observe_50: result = OBSERVE_50
        case RAAYAT_NAKARDAM, Observe_0: result = OBSERVE_0
        default: break
        }
        return result
    }
    
    //MARK: - 60 VITAMINS STATUS ویتامین و املاح تجویز شده در رژیم
    var vitaminsStatus: String{
        get{ standard.string(forKey: "vitaminsStatusSI") ?? String() }
        set{ standard.set(newValue, forKey: "vitaminsStatusSI") }
    }
    private var vitaminsStatusResult: String{
        var result = ""
        switch vitaminsStatus {
        case SAD_DAR_SAD, Done_100: result = DONE_100
        case KAM_BISH, Done_50: result = DONE_50
        case ANJAM_NADADAM, Done_0: result = DONE_0
        default: break
        }
        return result
    }
    
    //MARK: - 61 WEIGHT GOAL  از وزنتان چه خواسته ای دارید؟
    var weightGoal: String{
        get{ standard.string(forKey: "weightGoalSI") ?? String() }
        set{ standard.set(newValue, forKey: "weightGoalSI") }
    }
    private var weightGoalResult: String{
        var result = String()
        switch weightGoal {
        case VAZN_KAM, lose_weight: result = WEIGHT_LOSS
        case VAZN_BISHTAR, weigh_more: result = WEIGHT_GAIN
        case TAGHIR_NAKONAD, Dont_change: result = WEIGHT_CONSTANT
        default: break
        }
        return result
    }
    
    //MARK: - 62 FAMILY
    var family: String{
        get{ standard.string(forKey: "familySI") ?? String() }
        set{ standard.set(newValue, forKey: "familySI") }
    }
    var hasFamily: Bool{ family == DARAD || family == HAS_IT }
    
    //MARK: - 63 SIMILAR
    var similar: String{
        get{ standard.string(forKey: "similarSI") ?? String() }
        set{ standard.set(newValue, forKey: "similarSI") }
    }
    
    //MARK: - 64 SIMILAR MOBILE
    var similarMobile: String{
        get{ standard.string(forKey: "similarMobileSI") ?? String() }
        set{ standard.set(newValue, forKey: "similarMobileSI") }
    }
    
    //MARK: - 65 EXPLANATIONS علت اصلی درخواست شما
    var explanations: String{
        get{ standard.string(forKey: "explanationsSI") ?? String() }
        set{ standard.set(newValue, forKey: "explanationsSI") }
    }
    
    //MARK: - 66 DISEASE بیماری های دیگری که دارید؟
    var disease: String{
        get{ standard.string(forKey: "diseaseSI") ?? String() }
        set{ standard.set(newValue, forKey: "diseaseSI") }
    }
    
    //MARK: - 67 HATED FOOD غذاهای مورد تنفر
    var hatedfood: String{
        get{ standard.string(forKey: "hatedfoodSI") ?? String() }
        set{ standard.set(newValue, forKey: "hatedfoodSI") }
    }
    var hatedfoodResult: String{ seporateWithHyphen(hatedfood) }
    
    //MARK: - 68 FAVORITE FOOD غذاهای مورد علاقه
    var favoritefood: String{
        get{ standard.string(forKey: "favoritefoodSI") ?? String() }
        set{ standard.set(newValue, forKey: "favoritefoodSI") }
    }
    var favoritefoodResult: String{ seporateWithHyphen(favoritefood) }
    var canChooseFood: Bool{ !havePressure && !haveLiver && !haveFat && !haveFatCholestrol && !haveUric }
    var avalibleFood: Bool{ canChooseFood && favoritefood != "" || !canChooseFood }

    
    //MARK: - 69 SUPPLEMENT  مکمل ها ورزشی
    var supplement: String{
        get{ standard.string(forKey: "supplementSI") ?? String() }
        set{ standard.set(newValue, forKey: "supplementSI") }
    }
    
    func seporateWithHyphen(_ string: String) -> String{
        var tempAray = [String]()
        var tempString = String()
        var i = -1
        for char in string{
            i += 1
            if char != "،" && char != "," ||
                i == string.count-1 && char != "،" && char != ","{
                tempString.append(char)
            }
            if char == "," ||
                char == "،" ||
                i == string.count-1{
                tempAray.append(tempString)
                tempString = String()
            }
        }
        var j = -1
        var result = String()
        for string in tempAray{
            j += 1
            var k = -1
            for char in string {
                k += 1
                if  k != 0 && char != " " ||
                        k != string.count-1 && char != " " ||
                        char == " " && k != 0 && k != string.count-1{
                    result = "\(result)\(char)"
                }
            }
            result = j != tempAray.count-1 && result != "" ? "\(result)-" : "\(result)"
        }
        return result != "" ? result : NADARAM
    }
    
    // MARK: CAN REQUEST
    var canGetDiet: Bool{ avalibleFood && explanations != "" }

    //MARK: - ANSWERS
    var answers:[String]{ [feetsleep,                // 00
                           bloat,                    // 01
                           diarrhea,                 // 02
                           appetite,                 // 03
                           periodbleeding,           // 04
                           periodpain,               // 05
                           pregnant,                 // 06
                           childbirth,               // 07
                           breastfeeding,            // 08
                           dairySensitivity,         // 09
                           fibroma,                  // 10
                           breastCancer,             // 11
                           ovarianCyst,              // 12
                           mouth,                    // 13
                           metetarsusAnswers,        // 14
                           bloodConcentration,       // 15
                           platelet,                 // 16
                           hairlossAnswers,          // 17
                           hairlossLocation,         // 18
                           constipation,             // 19
                           sleepjump,                // 20
                           activity,                 // 21
                           activityType,             // 22
                           activityDays,             // 23
                           activityTime,             // 24
                           activityWeekDaysAnswers,  // 25
                           activityStartTime,        // 26
                           activityIntensity,        // 27
                           bodySize,                 // 28
                           activityDietGoal,         // 29
                           vitaminDeficiencyD,       // 30
                           kidneyStone,              // 31
                           ms,                       // 32
                           arthritis,                // 33
                           rheumatoidArthritis,      // 34
                           thinningDrugsAnswers,     // 35
                           epilepsy,                 // 36
                           cramp,                    // 37
                           headache,                 // 38
                           glucose,                  // 39
                           gallbladder,              // 40
                           pressure,                 // 41
                           liver,                    // 42
                           anemia,                   // 43
                           stomach,                  // 44
                           stomachIncreasing,        // 45
                           mary,                     // 46
                           fat,                      // 47
                           fatCholesterol,           // 48
                           thyroid,                  // 49
                           uric,                     // 50
                           bloodUrea,                // 51
                           bloodCreatinine,          // 52
                           fingernailAnswers,        // 53
                           covid19,                  // 54
//                           vegetarian,               // 55
                           hemorrhoid,               // 55
//                           economic,                 // 57
                           lunch,                    // 56
                           walkingStatus,            // 57
                           foodsStatus,              // 58
                           refreshmentsStatus,       // 59
                           vitaminsStatus,           // 60
                           weightGoal,               // 61
                           family,                   // 62
                           similar,                  // 63
                           similarMobile,            // 64
                           explanations,             // 65
                           disease,                  // 66
                           hatedfood,                // 67
                           favoritefood,             // 68
                           supplement]               // 69
    }
    
    //MARK: CHECK ANSWERS
    var checkAnswers:[[String]]{ [[""],                 // 00
                                  [""],                 // 01
                                  [""],                 // 02
                                  [""],                 // 03
                                  [""],                 // 04
                                  [""],                 // 05
                                  [""],                 // 06
                                  [""],                 // 07
                                  [""],                 // 08
                                  [""],                 // 09
                                  [""],                 // 10
                                  [""],                 // 11
                                  [""],                 // 12
                                  [""],                 // 13
                                  metatarsus,           // 14
                                  [""],                 // 15
                                  [""],                 // 16
                                  hairloss,             // 17
                                  [""],                 // 18
                                  [""],                 // 19
                                  [""],                 // 20
                                  [""],                 // 21
                                  [""],                 // 22
                                  [""],                 // 23
                                  [""],                 // 24
                                  activityWeekDays,     // 25
                                  [""],                 // 26
                                  [""],                 // 27
                                  [""],                 // 28
                                  [""],                 // 29
                                  [""],                 // 30
                                  [""],                 // 31
                                  [""],                 // 32
                                  [""],                 // 33
                                  [""],                 // 34
                                  thinningDrugs,        // 35
                                  [""],                 // 36
                                  [""],                 // 37
                                  [""],                 // 38
                                  [""],                 // 39
                                  [""],                 // 40
                                  [""],                 // 41
                                  [""],                 // 42
                                  [""],                 // 43
                                  [""],                 // 44
                                  [""],                 // 45
                                  [""],                 // 46
                                  [""],                 // 47
                                  [""],                 // 48
                                  [""],                 // 49
                                  [""],                 // 50
                                  [""],                 // 51
                                  [""],                 // 52
                                  fingernail,           // 53
                                  [""],                 // 54
                                  [""],                 // 55
                                  [""],                 // 56
                                  [""],                 // 57
                                  [""],                 // 58
                                  [""],                 // 59
                                  [""],                 // 60
                                  [""],                 // 61
                                  [""],                 // 62
                                  [""],                 // 63
                                  [""],                 // 64
                                  [""],                 // 65
                                  [""],                 // 66
                                  [""],                 // 67
                                  [""],                 // 68
                                  [""]]                 // 69
    }
    
    //MARK: IS ANSWERED
    var isAnswered:[Bool]{
        var result = [Bool]()
        answers.forEach({ asr in result.append(asr != "") })
        return result
    }
    
    //MARK: ANSWERS DESCREPTION ENABLE
    var answersDescriptionsEnable:[ Bool]{ [false,                            // 00
                                            false,                            // 01
                                            false,                            // 02
                                            false,                            // 03
                                            false,                            // 04
                                            false,                            // 05
                                            havePregnant,                     // 06
                                            false,                            // 07
                                            false,                            // 08
                                            false,                            // 09
                                            false,                            // 10
                                            false,                            // 11
                                            false,                            // 12
                                            false,                            // 13
                                            false,                            // 14
                                            false,                            // 15
                                            false,                            // 16
                                            false,                            // 17
                                            false,                            // 18
                                            false,                            // 19
                                            false,                            // 20
                                            false,                            // 21
                                            hasOtherSport,                    // 22
                                            false,                            // 23
                                            false,                            // 24
                                            false,                            // 25
                                            false,                            // 26
                                            false,                            // 27
                                            false,                            // 28
                                            false,                            // 29
                                            false,                            // 30
                                            false,                            // 31
                                            false,                            // 32
                                            arthritisDescriptionEnable,       // 33
                                            false,                            // 34
                                            false,                            // 35
                                            false,                            // 36
                                            false,                            // 37
                                            false,                            // 38
                                            false,                            // 39
                                            false,                            // 40
                                            false,                            // 41
                                            false,                            // 42
                                            false,                            // 43
                                            false,                            // 44
                                            haveStomachIncreasing,            // 45
                                            false,                            // 46
                                            false,                            // 47
                                            false,                            // 48
                                            false,                            // 49
                                            false,                            // 50
                                            bloodUreaDescriptionEnable,       // 51
                                            bloodCreatinineDescriptionEnable, // 52
                                            false,                            // 53
                                            false,                            // 54
                                            false,                            // 55
                                            false,                            // 56
                                            false,                            // 57
                                            false,                            // 58
                                            false,                            // 59
                                            false,                            // 60
                                            false,                            // 61
                                            false,                            // 62
                                            true,                             // 63
                                            true,                             // 64
                                            true,                             // 65
                                            true,                             // 66
                                            true,                             // 67
                                            true,                             // 68
                                            true]                             // 69
    }
    
    //MARK: ANSWER DESCRIPTION
    var answersDescription: [String]{ ["",                          // 00
                                       "",                          // 01
                                       "",                          // 02
                                       "",                          // 03
                                       "",                          // 04
                                       "",                          // 05
                                       pregnantMonths,              // 06
                                       "",                          // 07
                                       "",                          // 08
                                       "",                          // 09
                                       "",                          // 10
                                       "",                          // 11
                                       "",                          // 12
                                       "",                          // 13
                                       "",                          // 14
                                       "",                          // 15
                                       "",                          // 16
                                       "",                          // 17
                                       "",                          // 18
                                       "",                          // 19
                                       "",                          // 20
                                       "",                          // 21
                                       activityOther,               // 22
                                       "",                          // 23
                                       "",                          // 24
                                       "",                          // 25
                                       "",                          // 26
                                       "",                          // 27
                                       "",                          // 28
                                       "",                          // 29
                                       "",                          // 30
                                       "",                          // 31
                                       "",                          // 32
                                       arthritisDescription,        // 33
                                       "",                          // 34
                                       "",                          // 35
                                       "",                          // 36
                                       "",                          // 37
                                       "",                          // 38
                                       "",                          // 39
                                       "",                          // 40
                                       "",                          // 41
                                       "",                          // 42
                                       "",                          // 43
                                       "",                          // 44
                                       stomachIncreasingDescription,// 45
                                       "",                          // 46
                                       "",                          // 47
                                       "",                          // 48
                                       "",                          // 49
                                       "",                          // 50
                                       bloodUreaDescription,        // 51
                                       bloodCreatinineDescription,  // 52
                                       "",                          // 53
                                       "",                          // 54
                                       "",                          // 55
                                       "",                          // 56
                                       "",                          // 57
                                       "",                          // 58
                                       "",                          // 59
                                       "",                          // 60
                                       "",                          // 61
                                       "",                          // 62
                                       similar,                     // 63
                                       similarMobile,               // 64
                                       explanations,                // 65
                                       disease,                     // 66
                                       hatedfood,                   // 67
                                       favoritefood,                // 68
                                       supplement]                  // 69
    }
    
    //MARK: SPCIAL PARAMETERS
    var specialParams: [String: Any] { [FEETSLEEP               : feetsleepResult,
                                        BLOAT                   : bloatResult,
                                        DIARRHEA                : diarrheaResult,
                                        APPETITE                : appetiteResult,
                                        PERIODBLEEDING          : periodbleedingResult,
                                        PERIODPAIN              : periodpainResult,
                                        PREGNANT                : pregnantResult,
                                        PREGNANT_MONTHS         : pregnantMonths.enNumber,
                                        CHILDBIRTH              : childbirthResult,
                                        BREASTFEEDING           : breastfeedingResult,
                                        DAIRY_SENSITIVITY       : dairySensitivityResult,
                                        FIBROMA                 : fibromaResult,
                                        BREAST_CANCER           : breastCancerResult,
                                        OVARIAN_CYST            : ovarianCystResult,
                                        MOUTH                   : mouthResult,
                                        METATARSUS              : metatarsusResult,
                                        BLOOD_CONCENTRATION     : bloodConcentrationResult,
                                        PLATELET                : plateletResult,
                                        HAIRLOSS                : hairlossResult,
                                        HAIRLOSS_LOCATION       : hairlossLocationResult,
                                        CONSTIPATION            : constipationResult,
                                        SLEEPJUMP               : sleepjumpResult,
                                        ACTIVITY                : activityResult,
                                        ACTIVITY_TYPE           : activityTypeResult,
                                        ACTIVITY_OTHER          : activityOther,
                                        ACTIVITY_DAYS           : activityDays.enNumber,
                                        ACTIVITY_TIME           : activityTimeResult,
                                        ACTIVITY_WEEK_DAYS      : activityWeekDaysResult,
                                        ACTIVITI_START_TIME     : activityStartTimeResult,
                                        ACTIVITY_INTENSITY      : activityIntensityResult,
                                        ACTIVITY_ATHLETE_BODY   : bodySizeResult,
                                        ACTIVITY_DIET_GOAL      : activityDietGoalResult,
                                        VITAMIN_DEFICIENCY_D    : vitaminDeficiencyDResult,
                                        KIDNEY_STONE            : kidneyStoneResult,
                                        MS                      : msResult,
                                        ARTHRITIS               : arthritisResult,
                                        ARTHRITIS_DESC          : arthritisDescription,
                                        RHEUMATOID_ARTHRITIS    : rheumatoidArthritisResult,
                                        THINNING_DRUGS          : thinningDrugsResult,
                                        EPILEPSY                : epilepsyResult,
                                        CRAMP                   : crampResult,
                                        HEADACHE                : headacheResult,
                                        GLUCOSE                 : glucoseResult,
                                        GALLBLADDER             : gallbladderResult,
                                        PRESSURE                : pressureResult,
                                        LIVER                   : liverResult,
                                        ANEMIA                  : anemiaResult,
                                        STOMACH                 : stomachResult,
                                        STOMACH_INCREASING      : stomachIncreasingResult,
                                        STOMACH_INCREASING_DESC : stomachIncreasingDescription,
                                        MARY                    : maryResult,
                                        FAT                     : fatResult,
                                        FAT_CHOLESTEROL         : fatCholesterolResult,
                                        THYROID                 : thyroidResult,
                                        URIC                    : uricResult,
                                        BLOOD_UREA              : bloodUreaResult,
                                        BLOOD_UREA_DESC         : bloodUreaDescription,
                                        BLOOD_CREATININE        : bloodCreatinineResult,
                                        BLOOD_CREATININE_DESC   : bloodCreatinineDescription,
                                        FINGERNAIL              : fingernailResult,
                                        COVID19                 : covid19Result,
                                        HEMORRHOID              : hemorrhoidResult,
                                        LUNCH                   : lunchResult,
                                        EXPLANATIONS            : explanations,
                                        DISEASE                 : disease,
                                        HATEDFOOD               : hatedfoodResult,
                                        FAVORITEFOOD            : favoritefoodResult,
                                        WALKING_STATUS          : walkingStatusResult,
                                        FOODS_STATUS            : foodsStatusResult,
                                        REFRESHMENTS_STATUS     : refreshmentsStatusResult,
                                        VITAMINS_STATUS         : vitaminsStatusResult,
                                        WEIGHT_GOAL             : weightGoalResult,
                                        SUPPLEMENT_HISTORY      : supplement]
    }
    
    //MARK: REGUEST PARAMETERS
    var request: [String: String]{ [ID: ZERO,
                                    CREATED_BY: CREATED_ID,
                                    SIMILAR_TEXT: similar,
                                    SIMILAR_MOBILE: similarMobile.enNumber] }
    
    //MARK: PAYMENT
    var trackingCode = String()
    var payment: [String: String]{ [TRACKING_CODE: trackingCode,
                                    PAYMENT_DATE: Date().toString,
//                                     inOtherBlud || !isFA
                                    PAYMENT_TYPE: isReviewer ? "WORLDPAY" : ""] }
    
    //MARK: RESET
    func reset(){
        feetsleep                    = String()
        bloat                        = String()
        diarrhea                     = String()
        appetite                     = String()
        periodbleeding               = String()
        periodpain                   = String()
        pregnant                     = String()
        pregnantMonths               = String()
        childbirth                   = String()
        breastfeeding                = String()
        dairySensitivity             = String()
        fibroma                      = String()
        breastCancer                 = String()
        ovarianCyst                  = String()
        mouth                        = String()
        metatarsus                   = [String]()
        bloodConcentration           = String()
        platelet                     = String()
        hairloss                     = [String]()
        hairlossLocation             = String()
        constipation                 = String()
        sleepjump                    = String()
        activity                     = String()
        activityType                 = String()
        activityOther                = String()
        activityDays                 = String()
        activityTime                 = String()
        activityWeekDays             = [String]()
        activityStartTime            = String()
        activityIntensity            = String()
        bodySize                     = String()
        activityDietGoal             = String()
        vitaminDeficiencyD           = String()
        kidneyStone                  = String()
        ms                           = String()
        arthritis                    = String()
        arthritisDescription         = String()
        rheumatoidArthritis          = String()
        thinningDrugs                = [String]()
        epilepsy                     = String()
        cramp                        = String()
        headache                     = String()
        glucose                      = String()
        gallbladder                  = String()
        pressure                     = String()
        liver                        = String()
        anemia                       = String()
        stomach                      = String()
        stomachIncreasing            = String()
        stomachIncreasingDescription = String()
        mary                         = String()
        fat                          = String()
        fatCholesterol               = String()
        thyroid                      = String()
        uric                         = String()
        bloodUrea                    = String()
        bloodUreaDescription         = String()
        bloodCreatinine              = String()
        bloodCreatinineDescription   = String()
        fingernail                   = [String]()
        covid19                      = String()
        hemorrhoid                   = String()
        lunch                        = String()
        walkingStatus                = String()
        foodsStatus                  = String()
        refreshmentsStatus           = String()
        vitaminsStatus               = String()
        weightGoal                   = String()
        family                       = String()
        explanations                 = String()
        disease                      = String()
        hatedfood                    = String()
        favoritefood                 = String()
        similar                      = String()
        similarMobile                = String()
        supplement                   = String()
        trackingCode                 = String()
    }
}
