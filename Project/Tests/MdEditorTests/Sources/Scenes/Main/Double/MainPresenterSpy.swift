//
//  MainPresenterSpy.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 04.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
@testable import MdEditor

final class MainPresenterSpy: IMainPresenter {

	// MARK: - Private properties

	private(set) var isCalledPresent = false
	private(set) var isCalledOpen = false
	private(set) var isCalledAbout = false
	private(set) var isResponse = false

	// MARK: - Internal Methods

	func present(response: MainModel.Response) {
		isCalledPresent = true

		if !response.files.isEmpty {
			isResponse = true
		}
	}

	func presentFiles() {
		isCalledOpen = true
	}

	func presentAbout() {
		isCalledAbout = true
	}
}
