//
//  NIBMCOVID19UITests.swift
//  NIBMCOVID19UITests
//
//  Created by HASHAN on 9/19/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import XCTest

class NIBMCOVID19UITests: XCTestCase {
    
    func testSignIn() throws {
        
        let validEmail = "shalithavidanapathirana@gmail.com"
        let validPassword = "123456"
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Already have an account?"].tap()
        
        let emailField = app.textFields["Email"]
        XCTAssertTrue(emailField.exists)
        
        emailField.tap()
        emailField.typeText(validEmail)
        
        let passwordField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordField.exists)
        
        passwordField.tap()
        passwordField.typeText(validPassword)
        
        app.buttons["Sign In"].tap()
        
    }
    
    func testLoginValidations() throws {
        
        let validEmail = "shalithavidanapathirana@gmail.com"
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Already have an account?"].tap()
        
        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)
        
        let signInButton = app.buttons["Sign In"]
        signInButton.tap()
        
        app.alerts["Email is Required!"].scrollViews.otherElements.buttons["Ok"].tap()
        
        emailTextField.tap()
        emailTextField.typeText(validEmail)
        
        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        
        signInButton.tap()
        
        app.alerts["Password is Required!"].scrollViews.otherElements.buttons["Ok"].tap()
        
    }
    
}


//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//

//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
