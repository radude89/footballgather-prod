//
//  GatherUITests.swift.swift
//  UITests
//
//  Created by Radu Dan on 23.11.2021.
//

import XCTest
import CoreModels

final class GatherUITests: UITestCase {
    
    private var navigator: AppNavigator!
    
    override func setUp() {
        super.setUp()
        
        navigator = .init(app: app, testCase: self)
        
        launchApp(populatingStorage: true)
        navigator.presentGatherView()
    }
    
}
