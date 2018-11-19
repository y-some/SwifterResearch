//
//  AppDelegate.swift
//  SwifterResearch
//
//  Created by Yasuyuki Someya on 2018/11/18.
//  Copyright © 2018年 Yasuyuki Someya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /// Stubと本番でURLを動的に変更
    class var urlString: String {
        let stubInfo = StubServer.shared.getStubInfo()
        if stubInfo.needsStub {
            return stubInfo.url
        } else {
            return "https://www.apple.com/"
        }
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Stubサーバー(Swifter)の起動
        if StubServer.shared.getStubInfo().needsStub {
            StubServer.shared.startStubServer()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Stubサーバー(Swifter)の停止
        if StubServer.shared.getStubInfo().needsStub {
            StubServer.shared.stopStubServer()
        }
    }
}

