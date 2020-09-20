//
//  NIBMCOVID19Tests.swift
//  NIBMCOVID19Tests
//
//  Created by HASHAN on 9/19/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import XCTest
@testable import NIBM_COVID19

class NIBMCOVID19Tests: XCTestCase {

    func testAddNumbers() {
        let cal = Calculation()
        let result = cal.addNumbers(x: 2, y: 2)
        
        XCTAssertEqual(result, 4)
    }
    
    func testMultiplyNumbers() {
        let cal = Calculation()
        let result = cal.multiplyNumbers(x: 4, y: 2)
        
        XCTAssertEqual(result, 8)
    }
    
    func testDivideNumbers() {
        let cal = Calculation()
        let result = cal.divideNumbers(x: 16, y: 4)
        
        XCTAssertEqual(result, 4)
    }
    
}
