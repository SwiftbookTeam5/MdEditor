//
//  RecentFileManager.swift
//  MdEditor
//
//  Created by Kirill Leonov on 15.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

/// Протокол менеджера для получения данных по последним используемым файлам
protocol IRecentFileManager {
	/// Получает последние используемые файлы
	/// - Returns: данные файлов
	func getRecentFiles() -> [RecentFile]
}

/// Менеджер для получения данных по последним используемым файлам
final class RecentFileManager: IRecentFileManager {
	/// Получает последние используемые файлы
	/// - Returns: данные файлов
	func getRecentFiles() -> [RecentFile] {
		return []
	}
}

/// Менеджер для получения мок данных по последним используемым файлам
final class StubRecentFileManager: IRecentFileManager {
	/// Получает последние используемые файлы
	/// - Returns: данные файлов
	func getRecentFiles() -> [RecentFile] {
		return [
			RecentFile(
				previewText: "# Markdown Example",
				url: Endpoints.documentExample,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Как работать в Markdown с Заголовками",
				url: Endpoints.documentHeadings,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Вставка кода (code)",
				url: Endpoints.documentCode,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Экранирование (escaping characters)",
				url: Endpoints.documentLinks,
				createDate: Date()
			)
		]
	}
}
