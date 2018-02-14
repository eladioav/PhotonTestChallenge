//
//  PathOfLowestCostTests.swift
//  PathOfLowestCostTests
//
//  Created by Eladio Alvarez Valle on 2/7/18.
//  Copyright © 2018 Eladio Alvarez Valle. All rights reserved.
//

import XCTest
@testable import PathOfLowestCost

class PathOfLowestCostTests: XCTestCase {
    
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test1() {
        
        //(6X5 matrix normal flow)
        if let findPath = PathOfLowestCost(rows : 5, columns: 6, [3,4,1,2,8,6,6,1,8,2,7,4,5,9,3,9,9,5,8,4,1,3,2,6,3,7,2,8,6,4]) {
            
            print("Result 1: \(findPath.findLowestCost())")
        }
    }
    
    func test2() {
        
       //(6X5 matrix normal flow)
        if let findPath = PathOfLowestCost(rows : 5, columns: 6, [3,4,1,2,8,6,6,1,8,2,7,4,5,9,3,9,9,5,8,4,1,3,2,6,3,7,2,1,2,3]) {
            
            print("Result 2: \(findPath.findLowestCost())")
        }
    }
    
    func test3() {
        
        //(5X3 matrix with no path <50)
        if let findPath = PathOfLowestCost(rows : 3, columns: 5, [19,10,19,10,19,21,23,20,19,12,20,12,20,11,10]) {
            
            print("Result 3: \(findPath.findLowestCost())")
            
        } else {
            
            print("Result 3: Error creating matrix")
        }
    }
    
    func test4() {
        
        //(1X5 matrix)
        if let findPath = PathOfLowestCost(rows : 1, columns: 5, [5,8,5,3,5]) {
            
            print("Result 4: \(findPath.findLowestCost())")
            
        } else {
            
            print("Result 4: Error creating matrix")
        }
        
    }
    
    func test5() {
        
        //(5X1 matrix)
        if let findPath = PathOfLowestCost(rows : 5, columns: 1, [5,8,5,3,5]) {
            
            print("Result 5: \(findPath.findLowestCost())")
            
        } else {
            
            print("Result 5: Error creating matrix")
        }
    }
    
    func test6() {
        //(Non numeric input, Optional)
    /*
        if let findPath = PathOfLowestCost(rows : 3, columns: 3, [5,4,"H",8,"M",7,5,7,5]) {
            
        }
 */
    }
    
    func test7() {
     
        //(No input - Optional)
        if let findPath = PathOfLowestCost(rows : 0, columns: 0, []) {
            print("Result 7: \(findPath.findLowestCost())")
            
        } else {
            
            print("Result 7: Error creating matrix")
        }
    }
    
    func test8() {
        
        //(Starting with >50)
        if let findPath = PathOfLowestCost(rows : 3, columns: 5, [69,10,19,10,19,51,23,20,19,12,60,12,20,11,10]) {
            
            print("Result 8: \(findPath.findLowestCost())")
            
        } else {
            
            print("Result 8: Error creating matrix")
        }
    }
    
    func test9() {
        
        //(One value >50)
        if let findPath = PathOfLowestCost(rows : 3, columns: 4, [60,3,3,6,6,3,7,9,5,6,8,3]) {
            print("Result 9: \(findPath.findLowestCost())")
            
        } else {
            
            print("Result 9: Error creating matrix")
        }
    }
    
    func test10() {

        //(Negative values)
        if let findPath = PathOfLowestCost(rows : 4, columns: 4,[6,3,-5,9,-5,2,4,10,3,-2,6,10,6,-1,-2,10]) {
            print("Result 10: \(findPath.findLowestCost())")
            
        } else {
            
            print("Result 10: Error creating matrix")
        }
    }
    
    func test11() {
        
        //Complete path vs. lower cost incomplete path
        if let findPath = PathOfLowestCost(rows : 4, columns: 2, [51,51,0,51,51,51,5,5]) {
            print("Result 11: \(findPath.findLowestCost())")
            
        } else {
            
            print("Result 11: Error creating matrix")
        }
    }
    
    func test12() {

        //Longer incomplete path vs. shorter lower cost incomplete path
        if let findPath = PathOfLowestCost(rows : 4, columns: 3, [51,51,51,0,51,51,51,51,51,5,5,51]) {
            print("Result 12: \(findPath.findLowestCost())")
            
        } else {
            
            print("Result 12: Error creating matrix")
        }
    }
    
    func test13() {
        
        //Large number of columns
        if let findPath = PathOfLowestCost(rows : 2, columns: 20, [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]) {
            print("Result 13: \(findPath.findLowestCost())")
            
        } else {
            
            print("Result 13: Error creating matrix")
        }
    }
}
