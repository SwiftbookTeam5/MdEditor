//
//  DoubleLinkedListTests.swift
//  
//
//  Created by Александра Рязанова on 04.01.2024.
//

import XCTest
@testable import DataStructuresPackage

final class DoubleLinkedListTests: XCTestCase {

	func test_initList_withValue_shouldHaveCorrectCount() {
		let sut = DoubleLinkedList(value: 5)

		XCTAssertEqual(
			sut.count,
			1,
			"Не верное количество элементов в списке при инициализации"
		)
	}

	func test_initList_withoutValue_shouldHaveCorrectCount() {
		let sut = DoubleLinkedList<Int>()

		XCTAssertEqual(
			sut.count,
			0,
			"Не верное количество элементов в списке при инициализации со значением"
		)
	}

	func test_initList_withValue_shouldHaveCorrectValue() {
		let value = 1
		let sut = DoubleLinkedList(value: value)

		XCTAssertEqual(
			sut.value(at: 0),
			value,
			"Не верное значение элемента в списке при инициализации"
		)
	}

	func test_push_withValue_shouldHaveCorrectCount() {

		// arrange
		var sut = DoubleLinkedList<Int>()

		// act
		sut.push(5)

		// assert
		XCTAssertEqual(
			sut.count,
			1,
			"Не верное количество элементов в списке при добавлении в начало списка"
		)
	}

	func test_push_withValue_shouldHaveCorrectValue() {

		// arrange
		let value = 1
		var sut = DoubleLinkedList<Int>()

		// act
		sut.push(value)

		// assert
		XCTAssertEqual(
			sut.value(at: 0),
			value,
			"Не верное значение элемента в списке при добавлении в начало списка"
		)
	}

	func test_append_withValue_shouldHaveCorrectCount() {

		// arrange
		var sut = DoubleLinkedList<Int>()

		// act
		sut.append(5)

		// assert
		XCTAssertEqual(
			sut.count,
			1,
			"Не верное количество элементов в списке при добавлении в конец списка"
		)
	}

	func test_append_withValue_shouldHaveCorrectValue() {

		// arrange
		let value = 5
		var sut = DoubleLinkedList<Int>()

		// act
		sut.append(value)

		// assert
		XCTAssertEqual(
			sut.value(at: 0),
			value,
			"Не верное значение элемента в списке при добавлении в конец списка"
		)
	}

	func test_insert_withValue_shouldHaveCorrectCount() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		sut.insert(10, after: 0)

		// assert
		XCTAssertEqual(
			sut.count,
			numbers.count + 1,
			"Не верное количество элементов в списке при вставке в список"
		)
	}

	func test_insert_withValue_shouldHaveCorrectValue() {

		// arrange
		let value = 10
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		sut.append(value)

		// assert
		XCTAssertEqual(
			sut.value(at: numbers.count),
			value,
			"Не верное значение элемента при вставке в список"
		)
	}

	func test_insert_withEmptyList_shouldBeFail() {
		var sut = DoubleLinkedList<Int>()

		sut.insert(5, after: 0)

		XCTAssertEqual(
			sut.count,
			0,
			"Не верное количество элементов после вставки в список по существующему индексу"
		)
	}

	func test_insert_withNotExistingAfterIndex_shouldBeFail() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		sut.insert(10, after: numbers.count + 1)

		// assert
		XCTAssertEqual(
			sut.count,
			numbers.count,
			"Не верное количество элементов после вставки в список по существующему индексу"
		)
	}

	func test_pop_withFullList_shouldHaveCorrectCount() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		sut.pop()

		// assert
		XCTAssertEqual(
			sut.count,
			numbers.count - 1,
			"Не верное количество элементов после извлечения из начала списка"
		)
	}

	func test_pop_withFullList_shouldHaveCorrectValue() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		let value = sut.pop()

		// assert
		XCTAssertTrue(
			numbers.first == value,
			"Не верное значение извлеченного элемента из начала списка"
		)
	}

	func test_pop_withEmptyList_shouldBeNilValue() {
		var sut = DoubleLinkedList<Int>()

		let value = sut.pop()

		XCTAssertNil(
			value,
			"Ошибка, при удалении из пустого списка вернулось значение"
		)
	}

	func test_pop_withOneNode_shouldBeEmpty() {

		// arrange
		var sut = DoubleLinkedList<Int>()
		sut.push(5)

		// act
		sut.pop()

		// assert
		XCTAssertTrue(
			sut.isEmpty,
			"Ошибка, при удалении единственного элемента список не пустой"
		)
	}

	func test_removeLast_withFullList_shouldHaveCorrectCount() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		sut.removeLast()

		// assert
		XCTAssertEqual(
			sut.count,
			numbers.count - 1,
			"Не верное количество элементов после извлечения из конца списка"
		)
	}

	func test_removeLast_withFullList_shouldHaveCorrectValue() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		let value = sut.removeLast()

		// assert
		XCTAssertTrue(
			numbers.last == value,
			"Не верное значение извлеченного элемента из конца списка"
		)
	}

	func test_removeLast_withEmptyList_shouldBeNilValue() {
		var sut = DoubleLinkedList<Int>()

		let value = sut.removeLast()

		XCTAssertNil(
			value,
			"Не верное значение извлеченного элемента с конца пустого списка"
		)
	}

	func test_removeLast_withOneNode_shouldBeEmpty() {

		// arrange
		var sut = DoubleLinkedList<Int>()
		sut.push(5)

		// act
		sut.removeLast()

		// assert
		XCTAssertTrue(
			sut.isEmpty,
			"Ошибка, при извлечении с конца списка последнего единственного элемента список не пустой"
		)
	}

	func test_remove_withIndex_shouldHaveCorrectCount() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		sut.remove(after: 0)

		// assert
		XCTAssertEqual(
			sut.count,
			numbers.count - 1,
			"Не верное количество элементов в списке при удалении по индексу"
		)
	}

	func test_remove_withIndex_shouldHaveCorrectValue() {

		// arrange
		let index = 1
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		let value = sut.remove(after: index - 1)

		// assert
		XCTAssertTrue(
			numbers[index] == value,
			"Не верное значение удаляемого элемента из списка"
		)
	}

	func test_remove_withNotExistingAfterIndex_shouldBeFail() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		sut.remove(after: numbers.count + 1)

		// assert
		XCTAssertEqual(
			sut.count,
			numbers.count,
			"Не корректное количество эелментов после удаления из списка по несуществующему индексу"
		)
	}

	func test_remove_withFullList_shouldHaveCorrectCount() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		var sut = makeSUT(with: numbers)

		// act
		sut.remove(after: 0)
		
		// assert
		XCTAssertEqual(
			sut.count,
			numbers.count - 1,
			"Не корректное количество элементов после удаления из списка"
		)
	}

	func test_remove_withSmallList_shouldHaveCorrectCount() {

		// arrange
		let numbers = [1, 2]
		var sut = makeSUT(with: numbers)

		// act
		sut.remove(after: 0)

		// assert
		XCTAssertEqual(
			sut.count,
			numbers.count - 1,
			"Не корректное количество элементов после удаления из списка"
		)
	}
	
	func test_value_withOneNode_shouldHaveCorrectValue() {

		// arrange
		let firstValue = 2
		var sut = DoubleLinkedList<Int>()
		sut.push(firstValue)

		// act
		let currentValue = sut.value(at: 0)

		// assert
		XCTAssertTrue(
			firstValue == currentValue,
			"Не корректное значение получаемого элемента"
		)
	}

	func test_value_withLastIndex_shouldHaveCorrectValue() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		let sut = makeSUT(with: numbers)

		// act
		let currentValue = sut.value(at: 7)

		// assert
		XCTAssertEqual(
			currentValue,
			8,
			"Не корректное значение получаемого элемента"
		)
	}

	func test_value_withFirstIndex_shouldHaveCorrectValue() {

		// arrange
		let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		let sut = makeSUT(with: numbers)

		// act
		let currentValue = sut.value(at: 2)

		// assert
		XCTAssertEqual(
			currentValue,
			3,
			"Не корректное значение получаемого элемента"
		)
	}
	
	func test_description_withValues_shouldHaveCorrectValue() {

		// arrange
		let numbers = [1, 2, 3]
		let sut = makeSUT(with: numbers)

		// act
		let description = sut.description

		// assert
		XCTAssertEqual(
			description,
			"1 <--> 2 <--> 3",
			"Не корректное описание списка"
		)
	}
}

private extension DoubleLinkedListTests {

	func makeSUT(with numbers: [Int]) -> DoubleLinkedList<Int> {
		var sut = DoubleLinkedList<Int>()
		numbers.forEach { sut.append($0) }

		return sut
	}
}
