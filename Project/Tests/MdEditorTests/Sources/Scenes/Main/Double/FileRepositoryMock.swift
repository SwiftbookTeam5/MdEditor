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

		var files: [File] = []

		(1...4).forEach { _ in
			let file = File()
			file.name = L10n.File.default
			file.creationDate = Date()
			file.modificationDate = Date() + 1000
			files.append(file)
		}

		return files
	}
}
