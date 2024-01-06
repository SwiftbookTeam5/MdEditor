//
//  DoubleLinkedListTests.swift
//  
//
//  Created by Александра Рязанова on 04.01.2024.
//

import XCTest
@testable import DataStructuresPackage

final class DoubleLinkedListTests: XCTestCase {

	func testExample() throws {
		var sut = DoubleLinkedList<Int>()
		sut.push(5)
		XCTAssertEqual(sut.value(at: 0), 5)
	}
}
