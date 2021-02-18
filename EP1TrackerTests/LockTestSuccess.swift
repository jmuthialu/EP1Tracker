//
//  EP1TrackerTests.swift
//  EP1TrackerTests
//
//  Created by Jay Muthialu on 2/18/21.
//

import XCTest
@testable import EP1Tracker

class LockTestSuccess: XCTestCase {

    var pallet: Pallet?
    
    override func setUpWithError() throws {
        pallet = Pallet()
        pallet?.id = 100
    }

    override func tearDownWithError() throws {
        pallet = nil
    }

    func testLock() throws {
        let promise = expectation(description: "Testing Lock")
        
        pallet?.lock(isLocked: true, completion: { (error) in
            if let _ = error {
                XCTFail("Lock failed!!!")
            } else {
                promise.fulfill()
            }
        })
        wait(for: [promise], timeout: 5)
    }
}
