//  Created by amin sadeghian on 12/4/17.
//  Copyright © 2017 maminyoo. All rights reserved.

struct DataStruct{
    // CONNECTIONS
    let dietConnection           = DietConnection()
    let forgetConnection         = ForgetConnection()
    let registerConnection       = RegisterConnection()
    let paymentConnection        = PaymentConnection()
    let questionAnswerConnection = QuestionAnswerConnection()
    let extraConnection          = ExtraConnection()
    let repoConnection           = RepoConnection()
    let versionConnection        = VersionConnection()
    // MODELS
    let settings                 = Setting()
    let register                 = Register()
    let users                    = Users()
    let profile                  = Profile()
    let updateProfile            = UpdateProfile()
    let body                     = Body()
    let updateBody               = UpdateBody()
    let specialInformation       = SpecializedInformation()
    let questionAnswer           = QuestionAnswerList()
    let appVersion               = AppVersion()
    // STATE
    let dietSceneState           = DietSceneState()
}

let dataStruct = DataStruct()

var dietConnection            : DietConnection{ dataStruct.dietConnection }
var forgetConnection          : ForgetConnection{ dataStruct.forgetConnection }
var registerConnection        : RegisterConnection{ dataStruct.registerConnection }
var paymentConnection         : PaymentConnection{ dataStruct.paymentConnection }
var questionAnswerConnection  : QuestionAnswerConnection{ dataStruct.questionAnswerConnection }
var extraConnection           : ExtraConnection{ dataStruct.extraConnection }
var repoConnection            : RepoConnection{ dataStruct.repoConnection }
var versionConnection         : VersionConnection{ dataStruct.versionConnection }

var settings                  : Setting{ dataStruct.settings }
var register                  : Register{ dataStruct.register }
var users                     : Users{ dataStruct.users }
var profile                   : Profile{ dataStruct.profile }
var updateProfile             : UpdateProfile{ dataStruct.updateProfile }
var body                      : Body{ dataStruct.body }
var updateBody                : UpdateBody{ dataStruct.updateBody }
var specialInformation        : SpecializedInformation{ dataStruct.specialInformation }
var questionAnswer            : QuestionAnswerList{ dataStruct.questionAnswer }
var appVersion                : AppVersion{ dataStruct.appVersion }

var dietSceneState            : DietSceneState{ dataStruct.dietSceneState }
