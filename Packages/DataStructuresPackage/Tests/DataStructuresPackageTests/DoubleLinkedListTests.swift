//
//  DoubleLinkedListTests.swift
//  
//
//  Created by Александра Рязанова on 04.01.2024.
//

import XCTest
@testable import DataStructuresPackage

final class DoubleLinkedListTests: XCTestCase {

	func test_init_emptyList_shouldBeEmpty() {
		let sut = DoubleLinkedList<Int>()

		XCTAssertTrue(sut.isEmpty, "Список должен быть пуст.")
		XCTAssertEqual(sut.count, 0, "Количество элементов с списке должно быть равно 0.")
		XCTAssertNil(sut.headValue, "Начало списка должно быть пустым.")
		XCTAssertNil(sut.tailValue, "Конец списка должен быть пуст.")
	}

	func test_init_withValue_shouldBeCorrect() {
		let value = 5

		let sut = DoubleLinkedList(value: value)

		XCTAssertFalse(sut.isEmpty, "Список не должен быть пуст.")
		XCTAssertEqual(sut.count, 1, "Количество элементов в списке должно быть равно 1.")
		XCTAssertEqual(sut.headValue, value, "Начало списка содержит неверное значение.")
		XCTAssertEqual(sut.tailValue, value, "Конец списка содержит неверное значение.")
	}

	func test_push_twoValue_shouldBeCorrect() {
		var sut = DoubleLinkedList<Int>()

		sut.push(1)
		sut.push(2)

		XCTAssertFalse(sut.isEmpty, "Список не должен быть пуст.")
		XCTAssertEqual(sut.count, 2, "Количество элементов в списке должно быть равно 2.")
		XCTAssertEqual(sut.headValue, 2, "Начало списка содержит неверное значение.")
		XCTAssertEqual(sut.tailValue, 1, "Конец списка содержит неверное значение.")
	}

	func test_append_twoValue_shouldBeCorrect() {
		var sut = DoubleLinkedList<Int>()

		sut.append(1)
		sut.append(2)

		XCTAssertFalse(sut.isEmpty, "Список не должен быть пуст.")
		XCTAssertEqual(sut.count, 2, "Количество элементов в списке должно быть равно 2.")
		XCTAssertEqual(sut.headValue, 1, "Начало списка содержит неверное значение.")
		XCTAssertEqual(sut.tailValue, 2, "Конец списка содержит неверное значение.")
	}

	func test_insert_threeValuesInListWithTwoElements_shouldBeCorrect() {
		let numbers = [1, 3]
		var sut = makeSUT(with: numbers)

		sut.insert(2, after: 0)
		sut.insert(4, after: 2)
		sut.insert(6, after: 4)

		XCTAssertFalse(sut.isEmpty, "Список не должен быть пуст.")
		XCTAssertEqual(sut.headValue, 1, "Начало списка содержит неверное значение.")
		XCTAssertEqual(sut.tailValue, 4, "Конец списка содержит неверное значение.")
		XCTAssertEqual(
			sut.count,
			4,
			"Количество элементов должно быть равно 4, т.к. один эелемент добавлялся после несуществующего индекса"
		)
	}

	func test_pop_threeValuesFromListWithTwoElements_shouldBeCorrect() {
		let numbers = [1, 2]
		var sut = makeSUT(with: numbers)

		let removedFirstValue = sut.pop()
		let removedSecondValue = sut.pop()
		let removedThirdValue = sut.pop()

		XCTAssertTrue(sut.isEmpty, "Список должен быть пуст.")
		XCTAssertEqual(sut.count, 0, "Количество элементов в списке должно быть равно 0.")
		XCTAssertEqual(removedFirstValue, 1, "Список вернул неверное значение.")
		XCTAssertEqual(removedSecondValue, 2, "Список вернул неверное значение.")
		XCTAssertNil(removedThirdValue, "Список вернул несуществующее значение.")
		XCTAssertNil(sut.headValue, "Начало списка должно быть пустым.")
		XCTAssertNil(sut.tailValue, "Конец списка должен быть пуст.")
	}

	func test_removeLast_threeValuesFromListWithTwoElements_shouldBeCorrect() {
		let numbers = [1, 2]
		var sut = makeSUT(with: numbers)

		let removedFirstValue = sut.removeLast()
		let removedSecondValue = sut.removeLast()
		let removedThirdValue = sut.removeLast()
		
		XCTAssertTrue(sut.isEmpty, "Список должен быть пуст.")
		XCTAssertEqual(sut.count, 0, "Количество элементов в списке должно быть равно 0.")
		XCTAssertEqual(removedFirstValue, 2, "Список вернул неверное значение.")
		XCTAssertEqual(removedSecondValue, 1, "Список вернул неверное значение.")
		XCTAssertNil(removedThirdValue, "Список вернул несуществующее значение.")
		XCTAssertNil(sut.headValue, "Начало списка должно быть пустым.")
		XCTAssertNil(sut.tailValue, "Конец списка должен быть пуст.")
	}

	func test_removeAfter_zeroIndexThreeValuesFromListWithThreeElements_shouldBeCorrect() {
		let numbers = [1, 2, 3]
		var sut = makeSUT(with: numbers)

		let removedFirstValue = sut.remove(after: 0)
		let removedSecondValue = sut.remove(after: 0)
		let removedThirdValue = sut.remove(after: 0)

		XCTAssertFalse(sut.isEmpty, "Список не должен быть пуст.")
		XCTAssertEqual(sut.count, 1, "Количество элементов в списке должно быть равно 1.")
		XCTAssertEqual(removedFirstValue, 2, "Список вернул неверное значение.")
		XCTAssertEqual(removedSecondValue, 3, "Список вернул неверное значение.")
		XCTAssertNil(removedThirdValue, "Список вернул несуществующее значение.")
		XCTAssertEqual(sut.headValue, 1, "Начало списка содержит неверное значение.")
		XCTAssertEqual(sut.tailValue, 1, "Конец списка содержит неверное значение.")
	}

	func test_valueAtIndex_shouldBeCorrectValues() {
		let numbers = [1, 2, 3, 4, 5]
		let sut = makeSUT(with: numbers)

		let valueAt0 = sut.value(at: 0)
		let valueAt1 = sut.value(at: 1)
		let valueAt2 = sut.value(at: 2)
		let valueAt3 = sut.value(at: 3)
		let valueAt4 = sut.value(at: 4)
		let valueAt5 = sut.value(at: 5)

		XCTAssertEqual(valueAt0, 1, "Список вернул неверное значение.")
		XCTAssertEqual(valueAt1, 2, "Список вернул неверное значение.")
		XCTAssertEqual(valueAt2, 3, "Список вернул неверное значение.")
		XCTAssertEqual(valueAt3, 4, "Список вернул неверное значение.")
		XCTAssertEqual(valueAt4, 5, "Список вернул неверное значение.")
		XCTAssertNil(valueAt5, "Список вернул несуществующее значение.")
	}

	func test_description_withValues_shouldHaveCorrectValue() {
		let numbers = [1, 2, 3]
		let sut = makeSUT(with: numbers)

		let description = sut.description

		XCTAssertEqual(
			description,
			"1 <--> 2 <--> 3",
			"Не корректное описание списка"
		)
	}
}

// MARK: - Private methods

private extension DoubleLinkedListTests {

	func makeSUT(with numbers: [Int]) -> DoubleLinkedList<Int> {
		var sut = DoubleLinkedList<Int>()
		numbers.forEach { sut.append($0) }

		return sut
	}
}
