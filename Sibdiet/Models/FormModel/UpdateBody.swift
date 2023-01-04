//
//  UpdateBody.swift
//  Sibdiet
//
//  Created by amin sadeghian on 09/22/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Foundation

class UpdateBody{
    var stature       = ValueSliderResult("statureUB")
    var weight        = ValueSliderResult("weightUB")
    var birthWeight   = ValueSliderResult("birthWeightUB")
    var birthStature  = ValueSliderResult("birthStatureUB")
    var fatherStature = ValueSliderResult("fatherStatureUB")
    var motherStature = ValueSliderResult("motherStatureUB")
    var wrist         = ValueSliderResult("wristUB")
    var abdominal     = ValueSliderResult("abdominalUB")
    var hip           = ValueSliderResult("hipUB")
    var thigh         = ValueSliderResult("thighUB")
    var chest         = ValueSliderResult("chestUB")
    var shoulders     = ValueSliderResult("shouldersUB")
    
    //MARK: BODY FORM RESULT
    var body: [ValueSliderResult]{ isBaby ? [stature,
                                             weight,
                                             birthStature,
                                             birthWeight,
                                             fatherStature,
                                             motherStature,
                                             wrist,
                                             abdominal,
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
    
    //MARK: BODY PARAMETERS
    var bodyParams: [String : String]{ [STATURE        : stature.result,
                                        WEIGHT         : weight.result,
                                        BIRTH_WEIGHT   : birthWeight.result,
                                        BIRTH_STATURE  : birthStature.result,
                                        FATHER_STATURE : fatherStature.result,
                                        MOTHER_STATURE : motherStature.result,
                                        WRIST          : wrist.result,
                                        ABDOMINAL      : abdominal.result,
                                        HIP            : hip.result,
                                        THIGH          : thigh.result,
                                        CHEST          : chest.result,
                                        SHOULDERS      : shoulders.result] }
    //MARK: RESET
    func reset(){
        stature       .reset()
        weight        .reset()
        birthWeight   .reset()
        birthStature  .reset()
        fatherStature .reset()
        motherStature .reset()
        wrist         .reset()
        abdominal     .reset()
        hip           .reset()
        thigh         .reset()
        chest         .reset()
        shoulders     .reset()
    }
}
