//
//  TodoListScreenUITest.swift
//  MdEditorUITests
//
//  Created by Руслан Мингалиев on 28.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest

final class TodoListScreenUITest: XCTestCase {
	
	let app = XCUIApplication()

	override func setUp() {
		app.launch()
	}
	func test_valid_change_status_Task() {
		let todoListScreen = TodoListScreenObject(app: app)
		
		todoListScreen
			.isTodoList()
			.changeTaskStatusIn(section: 0, row: 1)
			.changeTaskStatusIn(section: 0, row: 1)
			.changeTaskStatusIn(section: 0, row: 1)
			.changeTaskStatusIn(section: 1, row: 0)
	}
	func test_valid_numberOfSections_and_nameSections() {
		let todoListScreen = TodoListScreenObject(app: app)
		
		todoListScreen
			.isTodoList()
			.getTitleForHeaderIn(section: 0)
			.getTitleForHeaderIn(section: 1)
	}
	
	func test_valid_data_task_in_section() {
		let todoListScreen = TodoListScreenObject(app: app)
		todoListScreen
			.isTodoList()
		
		
	}
}
