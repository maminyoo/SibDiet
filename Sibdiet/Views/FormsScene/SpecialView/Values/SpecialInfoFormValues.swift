//
//  SpecialInfoFormValues.swift
//  Sibdiet
//
//  Created by Amin on 1/10/20.
//  Copyright © 2020 maminyoo. All rights reserved.
//

import Foundation

struct SpecialInfoFormValues{
     
    //MARK: - 00 خواب رفتگی دست و پا
    let feetsleep: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Numbness_in_hands_and_feet : KHABRAFTEGI_DAST_PA)
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Low, High] : [NADARAM, KAM, ZIAD])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 01 نفخ
    let bloat: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Bloat : NAFKH)
        q.audio(isFA ? BLOAT : "")
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Low, High] : [NADARAM, KAM, ZIAD])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 02 اسهال
    let diarrhea: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Diarrhea : ESHAL)
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Low, High] : [NADARAM, KAM, ZIAD])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 03 اشتها
    let appetite: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Appetite : ESHTEHA)
        q.mode(RADIO)
        q.answers(isEN ? [Normal, Low, High] : [MAMOLI, KAM, ZIAD])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 04 خونریزی دوره پریود
    let periodbleeding: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Bleeding_during_periods : KHONRIZI_PERIOD)
        q.mode(RADIO)
        q.answers(isEN ? [Normal, Low, High, Menopause, Not_Have] : [MAMOLI, KAM, ZIAD, YAESTEGI, NADARAM])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 05 درد دوره پریود
    let periodpain: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Menstrual_period_pain : DARD_PERIOD)
        q.mode(RADIO)
        q.answers(isEN ? [Normal, Low, High] : [MAMOLI, KAM, ZIAD])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 06 آیا باردار هستید؟
    let pregnant: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Are_you_currently_pregnant : BARDARI)
        q.audio(isFA ? PREGNANT : "")
        q.mode(RADIO_DES)
        q.answers(isEN ? [Yes , No] : [BALE, KHEYR])
        q.answerXrow(2)
        q.hodler(isEN ? How_many_weeks : HAFTE_CHANDOM)
        return q
    }()
    
    //MARK: - 07 زایمان
    let childbirth: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Childbirth : ZAYEMAN)
        q.mode(RADIO)
        q.answers(isEN ? [Not_Had, Had] : [DASHTAM, NADASHTAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 08 در حال حاضر شیردهی
    let breastfeeding: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Breastfeeding : SHIRDEHI)
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Have] : [DARAM, NADARAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 09 در شیردهی به لبنیات حساس هستید؟
    let dairySensitivity: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Are_you_allergic_to_dairy : HASASIYAT_SHIRDEHI)
        q.mode(RADIO)
        q.answers(isEN ? [Yes, No] : [BALE, KHEYR])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 10 مشکل فیبروم
    let fibroma: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Fibroma_problem : MOSHKEL_FIBROM)
        q.audio(isFA ? FIBROMA : "")
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, High, Low] : [NADARAM, ZIAD, KAM])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 11 مشکل سرطان پستان
    let breastCancer: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Breast_cancer_problem : SARATAN_PESTAN)
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Have, Had_Before, Not_Know] : [NADARAM, DARAM, GHABLAN_DASHTAM, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 12 مشکل کیست تخمدان
    let ovarianCyst: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Ovarian_cyst_problem : KIST_TOKHMDAN)
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Have, Had_Before, Not_Know] : [NADARAM, DARAM, GHABLAN_DASHTAM, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 13 طعم دهان
    let mouth: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Taste_of_your_mouth : TAME_DAHAN)
        q.mode(RADIO)
        q.answers(isEN ? [None, Bitter, Sweet, Sour, Saline] : [HICH, TALKH, SHIRIN, TORSH, SHOR])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 14 کف پا
    let metetarsus: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Metatarsus : KAF_PA)
        q.mode(CHECK)
        q.answers(isEN ? [Normal, Freeze, Hot, DRY_CRACKED] : [MAMOLI, YAKH, DAGH, KHOSHK])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 15 مشکلات غلظت خون
    let bloodConcentration: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Blood_concentration_problems : GHELZAT_KHON)
        q.audio(isFA ? BLOOD_CONCENTRATION_AUDIO : "")
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Have, Not_Know] : [NADARAM, DARAM, NEMIDANAM])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 16 مشکل پلاکت (plt)
    let platelet: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Platelets_problem : MOSHKEL_PLAKET)
        q.audio(isFA ? PLATELET : "")
        q.mode(RADIO)
        q.answers(isEN ? [NORMAL_150_400, DOWN_150, UP_400, Not_Know] : [MAMOLI_150_400, PAEIN_150, BALA_400, NEMIDANAM])
        q.answerXrow(1)
        return q
    }()
    
    //MARK: - 17 مشکلات مو
    let hairloss: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Hair_problems : MOSHKEL_MO)
        q.mode(CHECK)
        q.answers(isEN ?
            [High_Loss, Coins_Loss, Dry_Brittle, Oily, Has_trichoptilosis, Premature_graying, Normal] :
            [RIZESH_ZIAD, RIZESH_SEKEI, KHOSHK_SHEKANANDE, CHARB, MOKHORE, SEFIDI_ZOODRES, MAMOLI])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 18 محل ریزش مو
    let hairlossLocation: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Hair_loss_location : MAHAL_RIZESH_MO)
        q.mode(RADIO)
        q.answers(isEN ?
            [Front_head, Floor_head, Front_floor, all_parts, None] :
            [AZ_JOLO_SAR, AZ_KAF_SAR, AZ_JOLO_KAF, TAMAM_GHESMAT, HICHKODAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 19 یبوست
    let constipation: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Constipation : YOBOSAT)
        q.audio(isFA ? CONSTIPATION : "")
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, High, Low] : [NADARAM, ZIAD, KAM])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 20 پرش از خواب
    let sleepjump: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Sleep_jumping : PARESH_KHAB)
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, High, Low] : [NADARAM, ZIAD, KAM])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 21 فعالیت بدنی
    let activity: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Physical_activity : FAALIYAT_BADANI)
        q.mode(RADIO)
        q.answers(isEN ?
            [dont_activities, Simple_walking, Sometimes_recreation, professional_athlete] :
            [HICH_VARZESH, PADERAVI, GAHAN_VARZESH, VARZESHKAR])
        q.answerXrow(1)
        return q
    }()
    
    //MARK: - 22 نوع ورزش
    let activityType: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Sport_type : NOE_VARZESH)
        q.mode(RADIO_DES)
        q.answers(isEN ?
            [Bodybuilding, Zumba, TRX, Martial, Swim, Mountaineering, Aerboic, Lace_sports, Track_Field, Spinning, Gymnastics, Rock_climbing, Boating, Skate, Squash, Bike_riding, Horse_riding, Crossfit, Physical_readiness, Badminton, Tennis, Powerlifting, Baracell, Ballet, Pilates, Other_Sports] :
            [BADANSAZI, ZUMBAF, TRXF, RAZMI, SHENA, KOHNAVARDI, AROBIC, VARZESH_TORI, DO_MEYDANI, SpinningF, GIMNASTIC, SAKHRE_NAVARDI, GHAYEGHRANI, SKATEF, SKOASH, DOCHARKHE_SAVARI, ASB_SAVARI, KERASFIT, AMADEGI_JESMANI, BADMINTONF, TENIS, POWERLIFTINGF, BARACELLF, BALLE, PILATESF, VARZESH_DIGAR])
        q.answerXrow(3)
        q.hodler(isEN ? Enter_sport : VARZESH_NAME)
        return q
    }()
    
    //MARK: - 23 تعداد روزهای ورزش
    let activityDays: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Number_days_week : TEDAD_ROZ)
        q.mode(RADIO)
        q.answers(isEN ? [ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN] : [YEK, DO, SE, CHAR, PANJ, SISH, HAFT])
        q.answerXrow(4)
        return q
    }()
    
    //MARK: - 24 مدت زمان ورزش در هر روز
    let activityTime: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Duration_day : MODAT_VARZESH)
        q.mode(RADIO)
        q.answers(isEN ?
            [Half_hour, One_hour, One_half, Two, Three, Four] :
            [NIM_SAAT, YEK_SAAT, YEK_NIM, DO_SAAT, SE_SAAT, CHAR_SAAT])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 25 روزهای تمرین در هفته
    let activityWeekDays: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Activity_week_days : ROZHAYE_TAMRIN)
        q.mode(CHECK)
        q.answers(isEN ?
            [Saturday, Sunday, Monday, Tuesday, Wednesday, Thursday, Friday] :
            [SHANBE, YEKSHANBE, DOSHANBE, SESHANBE, CHARSHANBE, PANSHANBE, JOME])
        q.answerXrow(4)
        return q
    }()
    
    //MARK: - 26 ساعت شروع تمرین
    let activityStartTime: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Time_to_start_practicing : SAAT_SHORO_TAMRIN)
        q.mode(RADIO)
        q.answers(isEN ?
            [AM_7, AM_8, AM_9, AM_10, AM_11, PM_2, PM_3, PM_4, PM_5, PM_6, PM_8, PM_9, PM_10] :
            [HAFT_SOBH, HASHT_SOBH, NOH_SOBH, DAH_SOBH, YAZDAH_SOBH, DO_ZOHR, SE_ZOHR, CHAR_ZOHR, PANJ_ASR, SHISH_ASR, HASHT_SHAB, NOH_SHAB, DAH_SHAB])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 27 شدت تمرین در جلسات مختلف
    let activityIntensity: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Intensity_of_practice : SHEDAT_TAMRIN)
        q.mode(RADIO)
        q.answers(isEN ?
            [Intensity_40_60, Intensity_60_80, Intensity_70_100, Intensity_80_100] :
            [CHEHEL_SHAST_DARSAD, SHAST_HASHTAD_DARSAD, HAFTAD_SAD_DARSAD, HASHTAD_SAD_DARSAD])
        q.answerXrow(1)
        return q
    }()
    
    //MARK: - 28 تصویر کلی بدن
    let bodySize: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Body_size : TASVIR_BADAN)
        q.mode(RADIO)
        q.answers(isEN ? [Obese, Muscular, Thin] : [CHAGH, AZOLANI, LAGHAR])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 29 هدف از دریافت رژیم ورزشی
    let activityDietGoal: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Purpose_of_diet : REJIM_HADAF)
        q.mode(RADIO)
        q.answers(isEN ?
            [Weight_gain, Reduce_fat, Reduce_fat_increase_muscle, Weight_stabilization, Increase_muscle_mass, Increase_muscle_volume] :
            [AFZEYESH_VAZN_HAJM, KAHESH_CHARBI_HEFZ_HAJM, KAHESH_CHARBI_AFZAYESH_HAJM, TASBIT_AFZEYESH_HAJM, AFZAYESH_HAJM_ESTEGHAMAT, AFZAYESH_HAJM_GHODRAT])
        q.answerXrow(1)
        return q
    }()
    
    //MARK: - 30 کمبود ویتامین D
    let vitaminDeficiencyD: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Deficiency_D : KAMBOD_VIT_D)
        q.audio(isFA ? VIT_D_AUDIO : "")
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Have, Not_Know] : [NADARAM, DARAM, NEMIDANAM])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 31 سنگ کلیه
    let kidneyStone: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Kidney_stone : SANG_KOLIYE)
        q.audio(isFA ? kidneyStoneAudio : "")
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Have, Had_Before, Not_Know] : [NADARAM, DARAM, GHABLAN_DASHTAM, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 32 ام اس
    let ms: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? MSQ : EM_ES)
        q.audio(isFA ? MS : "")
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Have] : [NADARAM, DARAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 33 آرتروز
    let arthritis: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Arthritis : ARTOROZ)
        q.mode(RADIO_DES)
        q.answers(isEN ?
            [Not_Have, Have_Doctor, have_osteoarthritis, Had_Before, Not_Know] :
            [NADARAM, TASHKHIS_DOCTOR, FEKR_DARAM, GHABLAN_DASHTAM, NEMIDANAM])
        q.answerXrow(1)
        q.hodler(isEN ? Brief_explanation : TOZIH_KOTAH)
        return q
    }()
    
    //MARK: - 34 آرتریت روماتوئید (روماتیسم مفصلی)
    let rheumatoidArthritis: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Rheumatoid_arthritis : ROMATISM)
        q.audio(isFA ? rheumatoidArthritisAudio : "")
        q.mode(RADIO)
        q.answers(isEN ?
            [Not_Have, Have, Had_Before, Not_Know] :
            [NADARAM, DARAM, GHABLAN_DASHTAM, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 35 استفاده از داروهای رقیق کننده
    let thinningDrugs: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Use_drugs : DARO_RAGHIGH)
        q.mode(CHECK)
        q.answers(isEN ?
            [Plavix, Clopidogrel, Asvyks, Heparin, Slksan, Warfarin, Not_Use] :
            [PLAVIXF, CLOPIDOGRELF, ASVYKSF, HEPARINF, SLKSANF, WARFARIN, ESTEFADE_NEMIKONAM])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 36 مشکل صرع
    let epilepsy: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Epilepsy : MOSHKEL_SAR)
        q.audio(isFA ? EPILEPSY : "")
        q.mode(RADIO)
        q.answers(isEN ? [No, Have, Had_Before] : [NADARAM, DARAM, GHABLAN_DASHTAM])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 37 گرفتگی عضلات
    let cramp: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Cramp : GEREFTEGI_AZOLAT)
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Low, High] : [NADARAM, KAM, ZIAD])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 38 سردرد
    let headache: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Headache : SARDARD)
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Low, High, Migrane] : [NADARAM, KAM, ZIAD, MIGREN])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 39 قند خون
    let glucose: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Blood_Glucose : GHAND_KHON)
        q.audio(isFA ? GLUCOSE : "")
        q.mode(RADIO)
        q.answers(isEN ?
            [Normal, Up, Down, Border_100_115, Not_Know] :
            [MAMOLI, BALA, PAEIN, LAB_MARZ_100_115, NEMIDANAM])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 40 کیسه‌ صفرا
    let gallbladder: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Gall_bladder : KISE_SAFRA)
        q.audio(isFA ? GALLBLADDER : "")
        q.mode(RADIO)
        q.answers(isEN ?
            [Healthy, Has_Stone, removed_surgery, Not_Know] :
            [SALEM, SANG_DARAD, KISE_SAFRA_BARDASHT, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 41 فشار خون
    let pressure: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Blood_Pressure : FESHAR_KHON)
        q.audio(isEN ? "" : PRESSURE)
        q.mode(RADIO)
        q.answers(isEN ? [Normal, Up, Down, Not_Know] : [MAMOLI, BALA, PAEIN, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 42 وضعیت کبد
    let liver: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Liver_condition : VAZIYAT_KABED)
        q.audio(isFA ? LIVER : "")
        q.mode(RADIO)
        q.answers(isEN ? [Normal, Oily, Not_Know] : [SALEM, CHARB, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 43 کم خونی
    let anemia: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Anemia : KAM_KHONI)
        q.audio(isFA ? ANEMIA : "")
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Have, Thalassemia, Not_Know] : [NADARAM, DARAM, TALASEMI, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 44 درد یا سوزش معده
    let stomach: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Stomach_ache : DARD_MEDE)
        q.audio(isFA ? STOMACH : "")
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, High, Low] : [NADARAM, KAM, ZIAD])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 45 ارتباطی با مصرف سالاد و میوه جات دارد؟
    let stomachIncreasing: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? related_salad_fruit : ERTEBAT_MIVE_SALAD)
        q.mode(RADIO_DES)
        q.answers(isEN ? [No, Yes] : [BALE, KHEYR])
        q.hodler(isEN ? Brief_explanation : NAME_GHAZA)
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 46 ریفلاکس یا همان ترش کردن معده
    let mary: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Reflux_heartburn : REFLUX_MEDE)
        q.audio(isFA ? MARY : "")
        q.mode(RADIO)
        q.answers(isEN ? [No_problem, Sometimes, More_often] : [ASLAN, GAHI, BISHTAR_OGHAT])
        q.answerXrow(3)
        return q
    }()
    
    //MARK: - 47 چربی تری گلیسیرید
    let fat: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Triglycerides_fats : CHARBI_TRIGILISIRID)
        q.audio(isFA ? FAT : "")
        q.mode(RADIO)
        q.answers(isEN ?
            [Normal, Up, Border_195_205, Not_Know] :
            [MAMOLI, BALA, LAB_MARZ_195_205, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 48 چربی کلسترول
    let fatCholesterol: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Fat_Cholesterol : CHARBI_COLESTEROL)
        q.audio(isFA ? fatCholesterolAudio : "")
        q.mode(RADIO)
        q.answers(isEN ?
            [Normal, Up, Down, Border_195_230, Not_Know] :
            [MAMOLI, BALA, PAEIN, LAB_MARZ_195_230, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 49 تیروئید
    let thyroid: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Thyroid_condition : TIROEID)
        q.audio(isFA ? THYROID : "")
        q.mode(RADIO)
        q.answers(isEN ? [Normal, Low_work, Labor_intensive, Not_Know] : [MAMOLI, KAMKAR, PORKAR, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 50 اسید اوریک
    let uric: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Uric_Acid : ASID_URIC)
        q.audio(isFA ? URIC : "")
        q.mode(RADIO)
        q.answers(isEN ? [Not_Have, Have, Border_6_7, Not_Know] : [NADARAM, DARAM, LAB_MARZ_6_7, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 51 اوره بالای خون
    let bloodUrea: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? High_blood_urea : URE_KHON)
        q.mode(RADIO_DES)
        q.answers(isEN ? [Normal, Have, Not_Know] : [MAMOLI, DARAM, NEMIDANAM])
        q.answerXrow(3)
        q.hodler(isEN ? Brief_explanation : TOZIH_KOTAH)
        return q
    }()
    
    //MARK: - 52 کراتنین بالای خون
    let bloodCreatinine: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? High_blood_creatinine : CRATIN_KHON)
        q.mode(RADIO_DES)
        q.answers(isEN ? [Normal, Have, Not_Know] : [MAMOLI, DARAM, NEMIDANAM])
        q.answerXrow(3)
        q.hodler(isEN ? Brief_explanation : TOZIH_KOTAH)
        return q
    }()
    
    //MARK: - 53 وضعیت ناخن های
    let fingernail: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? How_nails : VAZIYAT_NAKHON)
        q.mode(CHECK)
        q.answers(isEN ?
            [Healthy, Breaks, Laminate, Low_Growth] :
            [SALEM, MISHEKANAD, ROSHD_KAM, VARAGHE])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 54 کوید ۱۹
    let covid19: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Covid_19 : VAZIAT_CORONA)
        q.mode(RADIO)
        q.answers(isEN ?
            [Have, Not_Have, Had_Before, Suspicious] :
            [DARAM, NADARAM, GHABLAN_DASHTAM, MASHKOK])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 55 هموروئید (بواسیر یا همان فیشر)
    let hemorrhoid: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Hemorrhoids : HEMOROEID)
        q.mode(RADIO)
        q.answers(isEN ?
            [Not_Have, Have, Had_Before, Not_Know] :
            [NADARAM, DARAM, GHABLAN_DASHTAM, NEMIDANAM])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 56 ناهار
    let lunch: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Lunch : NAHAR)
        q.mode(RADIO)
        q.answers(isEN ?
            [Eat_home_food, Eat_work_food, Eat_restaurant_food] :
            [GHAZA_MANZEL, GHAZA_KAR, GHAZA_RESTURAN])
        q.answerXrow(1)
        return q
    }()
    
    //MARK: - 57 نحوه اجرای پیاده روی طبق دستور
    let walkingStatus: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Walk_implementation : NAHVE_PIYADERAVI)
        q.mode(RADIO)
        q.answers(isEN ? [Done_100, Done_50, Done_0] : [SAD_DAR_SAD, KAM_BISH, ANJAM_NADADAM])
        q.answerXrow(1)
        return q
    }()
    
    //MARK: - 58 نحوه اجرای غذاها
    let foodsStatus: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Implementation_foods : NAHVE_GHAZA)
        q.mode(RADIO)
        q.answers(isEN ? [Done_100, Done_50, Done_0] : [SAD_DAR_SAD, KAM_BISH, ANJAM_NADADAM])
        q.answerXrow(1)
        return q
    }()
    
    //MARK: - 59 در حین رژیم در مورد تنقلات
    let refreshmentsStatus: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? During_snacks : NAHVE_TANAGHOLAT)
        q.mode(RADIO)
        q.answers(isEN ?
            [Observe_100, Observe_50, Observe_0] :
            [SAD_DAR_SAD_RAAYAT, KAM_BISH_RAAYAT, RAAYAT_NAKARDAM])
        q.answerXrow(1)
        return q
    }()
    
    //MARK: - 60 ویتامین و املاح تجویز شده در رژیم
    let vitaminsStatus: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Vitamins_minerals : NAHVE_VITAMIN)
        q.mode(RADIO)
        q.answers(isEN ? [Done_100, Done_50, Done_0] : [SAD_DAR_SAD, KAM_BISH, ANJAM_NADADAM])
        q.answerXrow(1)
        return q
    }()
    
    //MARK: - 61 از وزنتان چه خواسته ای دارید؟
    let weightGoal: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? What_weight : KHASTE_VAZN)
        q.mode(RADIO)
        q.answers(isEN ? [lose_weight, weigh_more, Dont_change] : [VAZN_KAM, VAZN_BISHTAR, TAGHIR_NAKONAD])
        q.answerXrow(1)
        return q
    }()
    
    //MARK: - 62 خانواده
    let family: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? SibDiet_family : SIBDIET_FAMILY)
        q.mode(RADIO)
        q.answers(isEN ? [HAS_IT, No_has] : [DARAD, NADARAD])
        q.answerXrow(2)
        return q
    }()
    
    //MARK: - 63 نام
    let name: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Name : NAM)
        q.mode(TEXT)
        q.hodler(isEN ? Name_Family : NAME_MOREDNAZAR)
        return q
    }()
    
    //MARK: - 64 شماره همراه
    let mobile: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Mobile : SHOMARE_HAMRAH)
        q.mode(TEXT)
        q.hodler(isEN ? Mobile_number : MOBILE_MOREDENAZAR)
        return q
    }()
    
    //MARK: - 65 علت اصلی درخواست شما
    let explanations: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Main_reason : ELAT_DARKHAST)
        q.mode(TEXT)
        q.hodler(isEN ? MAIMUM_15_WORD : HADEAKSAR_15_KALAME)
        return q
    }()
    
    //MARK: - 66 بیماری های دیگری که دارید؟
    let disease: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Disease_history : BIMARIHAYE_DIGAR)
        q.mode(TEXT)
        q.hodler(isEN ? MAIMUM_15_WORD : HADEAKSAR_15_KALAME)
        return q
    }()
    
    //MARK: - 67 غذاهای مورد تنفر
    let hatedfood: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Hated_Foods : GHAZA_MOREDETANAFOR)
        q.mode(TEXT)
        q.hodler(isEN ? Seporate : JODAJODA)
        return q
    }()
    
    //MARK: - 68 غذاهای مورد علاقه
    let favoritefood: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Favorite_Foods : GHAZA_MOREDEALAGHE)
        q.mode(TEXT)
        q.hodler(isEN ? Seporate : JODAJODA)
        return q
    }()
        
    //MARK: - 69 استفاده از مکمل ها
    let supplement: QuestionModel = {
        let q = QuestionModel()
        q.question(isEN ? Using_supplements_3_m : MOKAMEL_SE_MAH)
        q.mode(TEXT)
        q.hodler(isEN ? SUPP_HOLDER : MOKAMLEHA)
        return q
    }()
    
    //MARK: - QUESTIONS
    var questions: [QuestionModel]{ [feetsleep,
                                     bloat,
                                     diarrhea,
                                     appetite,
                                     periodbleeding,
                                     periodpain,
                                     pregnant,
                                     childbirth,
                                     breastfeeding,
                                     dairySensitivity,
                                     fibroma,
                                     breastCancer,
                                     ovarianCyst,
                                     mouth,
                                     metetarsus,
                                     bloodConcentration,
                                     platelet,
                                     hairloss,
                                     hairlossLocation,
                                     constipation,
                                     sleepjump,
                                     activity,
                                     activityType,
                                     activityDays,
                                     activityTime,
                                     activityWeekDays,
                                     activityStartTime,
                                     activityIntensity,
                                     bodySize,
                                     activityDietGoal,
                                     vitaminDeficiencyD,
                                     kidneyStone,
                                     ms,
                                     arthritis,
                                     rheumatoidArthritis,
                                     thinningDrugs,
                                     epilepsy,
                                     cramp,
                                     headache,
                                     glucose,
                                     gallbladder,
                                     pressure,
                                     liver,
                                     anemia,
                                     stomach,
                                     stomachIncreasing,
                                     mary,
                                     fat,
                                     fatCholesterol,
                                     thyroid,
                                     uric,
                                     bloodUrea,
                                     bloodCreatinine,
                                     fingernail,
                                     covid19,
                                     hemorrhoid,
                                     lunch,
                                     walkingStatus,
                                     foodsStatus,
                                     refreshmentsStatus,
                                     vitaminsStatus,
                                     weightGoal,
                                     family,
                                     name,
                                     mobile,
                                     explanations,
                                     disease,
                                     hatedfood,
                                     favoritefood,
                                     supplement] }
}
