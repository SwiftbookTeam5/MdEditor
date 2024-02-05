//
//  MainInteractorTests.swift
//  MdEditor
//
//  Created by Александра Рязанова on 04.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
@testable import MdEditor

final class MainInteractorTests: XCTestCase {

	// MARK: - Private properties

	private let presenter = MainPresenterSpy()
	private let fileRepository = FileRepositoryMock()

	// MARK: - Internal Methods

	func test_fetchData_witchFiles_shouldBePresentSuccess() {
		let sut = makeSut()

		sut.fetchData()

		XCTAssertTrue(fileRepository.isCalledGetFiles, "Не вызван presenter.present(:)")
		XCTAssertTrue(presenter.isCalledPresent, "Не вызван fileRepository.getFiles()")
		XCTAssertTrue(presenter.isResponse, "Нет данных MainModel.Response")
	}
}

// MARK: - Private methods

private extension MainInteractorTests {

	func makeSut() -> MainInteractor {
		MainInteractor(presenter: presenter, fileRepository: fileRepository)
	}
}
