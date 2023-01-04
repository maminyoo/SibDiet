//  Created by Amin on 5/20/19.
//  Copyright © 2019 maminyoo. All rights reserved.

import UIKit

class MainViewController: UIViewController, AppVersionDelegate, SrverStateDelegate {
    
    override func viewDidLoad() {
        if appVersion.outOfAppPayement{ settings.language = FA }
        appVersion.delegate(self)
        dietConnection.delegateServerState = self
        extraConnection.getExtra()
        if !hasUser {  versionConnection.checkVersion() }
        if hasDiet { dietSceneState.reRoud() }
    }
    //MARK: - STATUSBAR
    var statusBarShouldBeHidden = false
    override var prefersStatusBarHidden: Bool { statusBarShouldBeHidden }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { .slide }
    func hideStatus(_ bool: Bool, _ delay : CFTimeInterval = 0){
        statusBarShouldBeHidden = bool
        UIView.animate(withDuration: 0.4, delay: delay, options: [], animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent }
        else { return .default } }
    
    //MARK: - BACKGROUND COLOR
    func background(_ color: UIColor){
        view.animate(backgroundColor: color, 1, curve)
    }
    // MARK: - VERSION VIEW
    func updateApplication(){
        let versionView = VersionView(BOUNDS)
        versionView.initView()
        addSubview(versionView)
    }
    // MARK: - LOADING VIEW
    func setLoading(_ frame: CGRect){
        let loading = LoadingView(frame)
        loading.initView()
        addSubview(loading)
    }
    //MARK: - RETRY VIEW
    func retry(){
        let retryView = RetryView(topFrame)
        retryView.initView()
        addSubview(retryView)
    }
    //MARK: - SERVER ERROR
    func serverError(){
        let errorView = ErrorView(BOUNDS)
        errorView.initView()
        addSubview(errorView)
    }
    //MARK: - CONNECTION ERROR
    func connectionError(){
        let alarmView = AlarmView(topFrame)
        alarmView.initView()
        addSubview(alarmView)
    }
}
