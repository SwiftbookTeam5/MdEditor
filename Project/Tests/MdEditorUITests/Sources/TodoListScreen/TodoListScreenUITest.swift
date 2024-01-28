//
//  TodoListScreenUITest.swift
//  MdEditorUITests
//
//  Created by Руслан Мингалиев on 28.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest

final class TodoListScreenUITest: XCTestCase {
	
	func test_valid_status() {
		let app = XCUIApplication()
		let todoListScreen = TodoListScreenObject(app: app)
		app.launch()
		
		todoListScreen
			.isTodoList()
			.changeTaskStatusIn(section: 1, row: 0)
	}
}
