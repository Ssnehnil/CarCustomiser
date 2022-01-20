//
//  Car_CustomiserTests.swift
//  Car CustomiserTests
//
//  Created by Ssnehnil Ghosh on 19/01/2022.
//

import XCTest
@testable import Car_Customiser

class Car_CustomiserTests: XCTestCase {

    func testNewCarGivesMeACarWithAllAttributesSet() {
        //arrange
        //act
        let car = Car(make: "Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
        //assert
        XCTAssertEqual(car.make, "Mazda")
        XCTAssertEqual(car.model, "MX-5")
        XCTAssertEqual(car.topSpeed, 125)
        XCTAssertEqual(car.acceleration, 7.7)
        XCTAssertEqual(car.handling, 5)
    }
    
    func testDisplayStatsOfCar() {
        //arrange
        let car = Car(make: "Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
        let expected = """
                            Make: Mazda
                            Model: MX-5
                            Top Speed: 125mph
                            Acceleration (0-60): 7.7s
                            Handling: 5
                            """
        let actual = car.displayStats()
        //assert
        XCTAssertEqual(actual, expected)
    }

}
