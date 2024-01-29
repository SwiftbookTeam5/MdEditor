//
//  TodoListPresenterTests.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 15.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
import TaskManagerPackage
@testable import MdEditor

final class TodoListPresenterTests: XCTestCase {

	// MARK: - Properties

	private let viewController = TodoListViewControllerSpy()

	// MARK: - Methods

	func test_present_withValidRequest_shouldBeSuccess() {
		let sut = makeSut()
		let response = TodoListModel.Response(data: [])

		sut.present(response: response)

		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.render(:)")
	}
}

// MARK: - Private methods

private extension TodoListPresenterTests {

	func makeSut() -> TodoListPresenter {
		TodoListPresenter(viewController: viewController, createTaskClosure: nil)
	}
}

final class TodoListViewControllerSpy: ITodoListViewController {

	private(set) var isCalledRender = false

	func render(viewModel: MdEditor.TodoListModel.ViewModel) {
		isCalledRender = true
	}
}
