//  Created by Me on 10/3/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//
import UIKit

struct BodyFormValues {
    //MARK: STATURE
    var stature: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? GHAD : Stature
        model.unicode      = isRTL ? SANTIMETR : CM
        model.color        = green01
        model.mainTitle    = CM
        model.minMain      = 60
        model.defaultMain  = isBaby ? 130 : 160
        model.maxMain      = 220
        model.mainDiv      = 1
        model.decimalTitle = MM
        model.minDecimal   = 0
        model.maxDecimal   = 9
        model.decimalDiv   = 1
        return model
    }
    //MARK: WEIGHT
    var weight: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? VAZN : Weight
        model.unicode      = isRTL ? KILOGRAM : KG
        model.color        = mint01
        model.mainTitle    = KG
        model.minMain      = 9
        model.defaultMain  = isBaby ? 15 : 60
        model.maxMain      = 180
        model.mainDiv      = 1
        model.decimalTitle = GR
        model.minDecimal   = 0
        model.maxDecimal   = 950
        model.decimalDiv   = 50
        return model
    }
    //MARK: BIRTH SATURE
    var birthStature: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? GHAD_TAVALOD : Birth_stature
        model.unicode      = isRTL ? SANTIMETR : CM
        model.color        = lime01
        model.mainTitle    = CM
        model.minMain      = 40
        model.defaultMain  = 50
        model.maxMain      = 70
        model.mainDiv      = 1
        model.decimalTitle = MM
        model.minDecimal   = 0
        model.maxDecimal   = 9
        model.decimalDiv   = 1
        return model
    }
    //MARK: BIRTH WEIGHT
    var birthWeight: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? VAZN_TAVALOD : Birth_weight
        model.unicode      = isRTL ? KILOGRAM : KG
        model.color        = green
        model.mainTitle    = KG
        model.minMain      = 2
        model.defaultMain  = 3
        model.maxMain      = 10
        model.mainDiv      = 1
        model.decimalTitle = GR
        model.minDecimal   = 0
        model.maxDecimal   = 950
        model.decimalDiv   = 50
        return model
    }
    //MARK: FATHER STATURE
    var fatherStature: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? GHAD_PEDAR : Father_stature
        model.unicode      = isRTL ? SANTIMETR : CM
        model.mainTitle    = CM
        model.color        = lime02
        model.minMain      = 60
        model.defaultMain  = 170
        model.maxMain      = 220
        model.mainDiv      = 1
        model.decimalTitle = MM
        model.minDecimal   = 0
        model.maxDecimal   = 9
        model.decimalDiv   = 1
        return model
    }
    //MARK: MOTHER STATURE
    var motherStature: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? GHAD_MADAR : Mother_stature
        model.unicode      = isRTL ? SANTIMETR : CM
        model.mainTitle    = CM
        model.color        = green02
        model.minMain      = 60
        model.defaultMain  = 160
        model.maxMain      = 220
        model.mainDiv      = 1
        model.decimalTitle = MM
        model.minDecimal   = 0
        model.maxDecimal   = 9
        model.decimalDiv   = 1
        return model
    }
    //MARK: WRIST
    var wrist: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? DOR_MOCH : Wrist
        model.unicode      = isRTL ? SANTIMETR : CM
        model.color        = UIColor(0x00ACC1)
        model.mainTitle    = CM
        model.minMain      = 5
        model.defaultMain  = 15
        model.maxMain      = 29
        model.mainDiv      = 1
        model.decimalTitle = MM
        model.minDecimal   = 0
        model.maxDecimal   = 9
        model.decimalDiv   = 1
        return model
    }
    //MARK: ABDOMINAL
    var abdominal: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? DOR_SHEKAM : Abdominal
        model.unicode      = isRTL ? SANTIMETR : CM
        model.color        = UIColor(0x039BE5)
        model.mainTitle    = CM
        model.minMain      = 15
        model.defaultMain  = 70
        model.maxMain      = 170
        model.mainDiv      = 1
        model.decimalTitle = MM
        model.minDecimal   = 0
        model.maxDecimal   = 9
        model.decimalDiv   = 1
        model.optional     = true
        model.optionalStr  = isRTL ? EKHTIARI : OPTIONAL
        return model
    }
    //MARK: HIP
    var hip: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? DOR_BASAN : Hip
        model.unicode      = isRTL ? SANTIMETR : CM
        model.color        = skyBlue02
        model.mainTitle    = CM
        model.minMain      = 20
        model.defaultMain  = 50
        model.maxMain      = 150
        model.mainDiv      = 1
        model.decimalTitle = MM
        model.minDecimal   = 0
        model.maxDecimal   = 9
        model.decimalDiv   = 1
        model.optional     = true
        model.optionalStr  = isRTL ? EKHTIARI : OPTIONAL
        return model
    }
    //MARK: THIGH
    var thigh: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? DOR_RAN : Thigh
        model.unicode      = isRTL ? SANTIMETR : CM
        model.color        = UIColor(0xD500F9)
        model.mainTitle    = CM
        model.minMain      = 15
        model.defaultMain  = 30
        model.maxMain      = 90
        model.mainDiv      = 1
        model.decimalTitle = MM
        model.minDecimal   = 0
        model.maxDecimal   = 9
        model.decimalDiv   = 1
        model.optional     = true
        model.optionalStr  = isRTL ? EKHTIARI : OPTIONAL
        return model
    }
    //MARK: CHEST
    var chest: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? DOR_SINE : Chest
        model.unicode      = isRTL ? SANTIMETR : CM
        model.color        = UIColor(0xF50057)
        model.mainTitle    = CM
        model.minMain      = 25
        model.defaultMain  = 60
        model.maxMain      = 120
        model.mainDiv      = 1
        model.decimalTitle = MM
        model.minDecimal   = 0
        model.maxDecimal   = 9
        model.decimalDiv   = 1
        model.optional     = true
        model.optionalStr  = isRTL ? EKHTIARI : OPTIONAL
        return model
    }
    //MARK: SHOLDERS
    var shoulders: ValueSliderModel{
        let model          = ValueSliderModel()
        model.title        = isRTL ? TOL_SHANE : Shoulders
        model.unicode      = isRTL ? SANTIMETR : CM
        model.color        = orange01
        model.mainTitle    = CM
        model.minMain      = 20
        model.defaultMain  = 40
        model.maxMain      = 90
        model.mainDiv      = 1
        model.decimalTitle = MM
        model.minDecimal   = 0
        model.maxDecimal   = 9
        model.decimalDiv   = 1
        model.optional     = true
        model.optionalStr  = isRTL ? EKHTIARI : OPTIONAL
        return model
    }
    //MARK: BODY
    var body: [ValueSliderModel] { isBaby ? [stature,
                                             weight,
                                             birthStature,
                                             birthWeight,
                                             fatherStature,
                                             motherStature,
                                             wrist ,
                                             abdominal ,
                                             hip,
                                             thigh,
                                             chest,
                                             shoulders] : [stature,
                                                           weight,
                                                           wrist,
                                                           abdominal,
                                                           hip,
                                                           thigh,
                                                           chest,
                                                           shoulders] }
    var maxTitle: String{
        var title = String()
        for t in body{ title = t.title.count > title.count ? t.title : title }
        return title
    }
}
