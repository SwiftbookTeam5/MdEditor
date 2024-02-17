//
//  TodoListScreenUITest.swift
//  MdEditorUITests
//
//  Created by Руслан Мингалиев on 28.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest

final class TodoListScreenUITest: XCTestCase {

	// MARK: - Private properties

	private let app = XCUIApplication()
	private lazy var todoListScreenObject = TodoListScreenObject(app: app)

	// MARK: - Lifecycle

	override func setUp() {
		super.setUp()
		app.launchArguments = [LaunchArguments.enableTesting.rawValue, LaunchArguments.startTodoList.rawValue]
		app.launch()
	}

	// MARK: - Internal methods

	func test_sections_shouldBeCorrectCountOfSectionsAndCorrectTitles() {
		todoListScreenObject
			.isTodoList()
			.checkNumberOfSections(2)
			.checkSectionTitle(index: 0, title: L10n.TodoList.Section.uncompleted)
			.checkSectionTitle(index: 1, title: L10n.TodoList.Section.completed)
	}

	func test_cells_shouldBeFourNotSelectedCellsAndOneSelectedAsWellCorrectTitles() {
		todoListScreenObject
			.isTodoList()
			.checkCountOfNotSelectedCells(4)
			.checkCountOfSelectedCells(1)
			.checkCellTitle(section: 0, row: 0, title: CellTitleStub.doHomework)
			.checkCellTitle(section: 0, row: 1, title: CellTitleStub.goShopping)
			.checkCellTitle(section: 0, row: 2, title: CellTitleStub.writeNewTasks)
			.checkCellTitle(section: 0, row: 3, title: CellTitleStub.solve3Algorithms)
			.checkCellTitle(section: 1, row: 0, title: CellTitleStub.doWorkout)
	}

	func test_doTask_shouldBeThreeNotSelectedCellsAndTwoSelectedCellsAsWellCorrectTitles() {
		todoListScreenObject
			.isTodoList()
			.changeTaskStatusIn(section: 0, row: 0)
			.checkCountOfNotSelectedCells(3)
			.checkCountOfSelectedCells(2)
			.checkCellTitle(section: 0, row: 0, title: CellTitleStub.goShopping)
			.checkCellTitle(section: 0, row: 1, title: CellTitleStub.writeNewTasks)
			.checkCellTitle(section: 0, row: 2, title: CellTitleStub.solve3Algorithms)
			.checkCellTitle(section: 1, row: 0, title: CellTitleStub.doHomework)
			.checkCellTitle(section: 1, row: 1, title: CellTitleStub.doWorkout)
	}

	func test_undoTask_shouldBeFiveNotSelectedCellsAndZeroSelectedCellsAsWellCorrectTitles() {
		todoListScreenObject
			.isTodoList()
			.changeTaskStatusIn(section: 1, row: 0)
			.checkCountOfNotSelectedCells(5)
			.checkCountOfSelectedCells(0)
			.checkCellTitle(section: 0, row: 0, title: CellTitleStub.doHomework)
			.checkCellTitle(section: 0, row: 1, title: CellTitleStub.goShopping)
			.checkCellTitle(section: 0, row: 2, title: CellTitleStub.writeNewTasks)
			.checkCellTitle(section: 0, row: 3, title: CellTitleStub.doWorkout)
			.checkCellTitle(section: 0, row: 4, title: CellTitleStub.solve3Algorithms)
	}
}

private extension TodoListScreenUITest {

	enum CellTitleStub {
		static var doHomework = "!!! \(L10n.Task.doHomework)"
		static var doWorkout = L10n.Task.doWorkout
		static var writeNewTasks = "! \(L10n.Task.writeNewTasks)"
		static var solve3Algorithms = L10n.Task.solve3Algorithms
		static var goShopping = "!! \(L10n.Task.goShopping)"
	}
}
