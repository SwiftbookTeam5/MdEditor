//
//  FileRepositoryMock.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 04.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
@testable import MdEditor

final class FileRepositoryMock: IFileRepository {

	// MARK: - Private properties

	private(set) var isCalledGetFiles = false

	// MARK: - Internal Methods

	func getFiles() -> [File] {
		isCalledGetFiles = true

		let files = [
			File(name: L10n.File.default, creationDate: Date(), modifiationData: Date() + 1000),
			File(name: L10n.File.default, creationDate: Date(), modifiationData: Date() + 1000),
			File(name: L10n.File.default, creationDate: Date(), modifiationData: Date()),
			File(name: L10n.File.default, creationDate: Date(), modifiationData: Date())
		]

		return files
	}
}
