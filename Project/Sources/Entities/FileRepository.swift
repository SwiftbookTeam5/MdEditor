//
//  FileRepository.swift
//  MdEditor
//
//  Created by Александра Рязанова on 03.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

/// Репозиторий для получения файлов.
protocol IFileRepository {

	/// Получить список файлов.
	/// - Returns: Массив файлов.
	func getFiles() -> [File]
}

/// Stub репозиторя для получения файлов.
final class FileRepositoryStub: IFileRepository {

	/// Возвращает предустановленные данные для приложения.
	/// - Returns: Массив заданий.
	func getFiles() -> [File] {
		[
			File(name: L10n.File.default, creationDate: Date(), modifiationData: Date() + 1000),
			File(name: L10n.File.default, creationDate: Date(), modifiationData: Date() + 1000),
			File(name: L10n.File.default, creationDate: Date(), modifiationData: Date()),
			File(name: L10n.File.default, creationDate: Date(), modifiationData: Date())
		]
	}
}
