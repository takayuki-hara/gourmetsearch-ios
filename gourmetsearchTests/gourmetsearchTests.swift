//
//  gourmetsearchTests.swift
//  gourmetsearchTests
//
//  Created by 原隆幸 on 2018/07/29.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import XCTest
import Nimble
@testable import _dev_gourmetsearch

class gourmetsearchTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func test_nimble() {
        expect(1 + 1).to(equal(2))
        expect(1.2).to(beCloseTo(1.1, within: 0.1))
        expect(3) > 2
        expect("seahorse").to(contain("sea"))
        expect(["Atlantic", "Pacific"]).toNot(contain("Mississippi"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
