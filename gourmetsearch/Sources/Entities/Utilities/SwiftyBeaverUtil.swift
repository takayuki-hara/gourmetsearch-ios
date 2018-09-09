//
//  SwiftyBeaverUtil.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/07/29.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import Foundation
import SwiftyBeaver

// Memo: Terminal Command
// $ tail -f /tmp/swiftybeaver/gourmetsearch.log

// Log Instance
let log = SwiftyBeaver.self

class SwiftyBeaverUtil {

    // MARK: - Properties
    static let fileDir = "/tmp/swiftybeaver/"
    static let filePath = fileDir + "gourmetsearch.log"

    // MARK: - Public Methods
    class func initialize() {
        // destinations
        let console = ConsoleDestination()
        let file = FileDestination()
        let cloud = SBPlatformDestination(appID: "JXQlm7",
                                      appSecret: "o7fnxUunwZmib1rleIzhStofdvnewekt",
                                  encryptionKey: "myslSnwaWqMeLvGUPqpxuZjt6zuvjykx")

        // setup file path
        createLogFile()
        file.logFileURL = URL(string: filePath)

        // add the destinations to SwiftyBeaver
        log.addDestination(console)
        log.addDestination(file)
        log.addDestination(cloud)
    }

    class func logfilePath() -> String {
        return SwiftyBeaverUtil.filePath
    }

    // MARK: - Private Methods
    private class func createLogFile() {
        if FileManager.default.fileExists(atPath: filePath) { return }

        do {
            try FileManager.default.createDirectory(atPath: fileDir, withIntermediateDirectories: false, attributes: nil)
        } catch {
            print("create directory error!")
        }
        do {
            try "".write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("create file error!")
        }
    }

}
