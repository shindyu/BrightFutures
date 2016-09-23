//
//  FutureDebugTests.swift
//  BrightFutures
//
//  Created by Oleksii on 23/09/2016.
//  Copyright © 2016 Thomas Visser. All rights reserved.
//

import XCTest
import Result
@testable import BrightFutures

class TestLogger: LoggerType {
    var lastLoggedMessage: String?
    
    func log(message: String) {
        lastLoggedMessage = message
    }
}

class FutureDebugTests: XCTestCase {
    let testIdentifier = "testFutureIdentifier"
    
    func testStringLastPathComponent() {
        XCTAssertEqual("/tmp/scratch.tiff".lastPathComponent, "scratch.tiff")
        XCTAssertEqual("/tmp/scratch".lastPathComponent, "scratch")
        XCTAssertEqual("/tmp/".lastPathComponent, "tmp")
        XCTAssertEqual("scratch///".lastPathComponent, "scratch")
        XCTAssertEqual("/".lastPathComponent, "/")
    }
    
    func testDebugFutureSuccessWithIdentifier() {
        let logger = TestLogger()
        
        let f = Future<Void, NoError>(value: ()).debug(testIdentifier, logger: logger)
        let debugExpectation = self.expectation(description: "debugLogged")
        
        f.onSuccess {
            XCTAssertEqual(logger.lastLoggedMessage, "Future \(self.testIdentifier) succeeded")
            debugExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
