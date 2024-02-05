//
//  MainViewControllerSpy.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 04.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
@testable import MdEditor

final class MainViewControllerSpy: IMainViewController {

	// MARK: - Private properties

	private(set) var isCalledRender = false
	private(set) var isViewModel = false

	// MARK: - Internal Methods

	func render(viewModel: MainModel.ViewModel) {
		isCalledRender = true
		isViewModel = !viewModel.sections.isEmpty
	}
}
