//
//  LocktestFail.swift
//  EP1TrackerTests
//
//  Created by Jay Muthialu on 2/18/21.
//

import XCTest
@testable import EP1Tracker

class LockTestFail: XCTestCase {

    var pallet: Pallet?
    
    override func setUpWithError() throws {
        pallet = Pallet()
        pallet?.id = 110 // There is no pallet ID 110 
    }

    override func tearDownWithError() throws {
        pallet = nil
    }

    func testLock() throws {
        let promise = expectation(description: "Testing Lock")
        
        pallet?.lock(isLocked: true, completion: { (error) in
            if let _ = error {
                promise.fulfill()
            } else {
                XCTFail("Lock failed!!!")
            }
        })
        wait(for: [promise], timeout: 5)
    }
}
