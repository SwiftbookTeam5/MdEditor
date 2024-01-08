//
//  File.swift
//  
//
//  Created by Руслан Мингалиев on 08.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class RegularTaskTest: XCTestCase {
	func test_initialization_propertyisCompleteShuldBeFalse() {
		
		let sut = Task(title: "TestTask")

		XCTAssertNotEqual(sut.completed, true, "Невероное значение параметра Completed, необходим False")
		
	}
	func test_isComplete_setTrue_propertyisCompleteShuldBeFalse() {
		let sut = Task(title: "TestTask")
		
		sut.completed = true
		
		XCTAssertNotEqual(sut.completed, false, "Невероное значение параметра Completed, необходим True")
		
	}
	
}
