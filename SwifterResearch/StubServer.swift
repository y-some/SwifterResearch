//
//  StubServer.swift
//  SwifterResearch
//
//  Created by Yasuyuki Someya on 2018/11/18.
//  Copyright © 2018年 Yasuyuki Someya. All rights reserved.
//

import Foundation
import Swifter

class StubServer {
    static let shared = StubServer()
    private init() {}
    
    /// Stubサーバー(Swifter)のインスタンス
    let server = HttpServer()
    
    /// Stubサーバーを必要としているかの判定と、必要とする場合はStubのURLを取得する
    func getStubInfo() -> (needsStub: Bool, url: String) {
        let env = ProcessInfo.processInfo.environment
        if let value = env["STUB"] {
            // 環境変数に"STUB"というkeyがある場合、STUBサーバーを使う
            return (needsStub: true, url: value)
        }
        return (needsStub: false, url: "")
    }
    
    /// Stubサーバー(Swifter)を起動する
    func startStubServer() {
        guard let resourcePath = Bundle.main.resourcePath else {
            fatalError("ResourcePath could not get!!")
        }
        server["/:path"] = shareFilesFromDirectory(resourcePath)
        do {
            try server.start(9080)
        } catch {
            fatalError("Swifter could not start!!")
        }
    }
    
    /// Stubサーバー(Swifter)を停止する
    func stopStubServer() {
        server.stop()
    }
}
