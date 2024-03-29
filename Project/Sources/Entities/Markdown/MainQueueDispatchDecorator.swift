//
//  MainQueueDispatchDecorator.swift
//  MdEditor
//
//  Created by Александра Рязанова on 13.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import FileManagerPackage
import MarkdownParserPackage

/// Декоратор для управления потоками при конвертации
final class MainQueueDispatchDecorator: IMarkdownConverterAdapter {
	private let decorate: IMarkdownConverterAdapter

	/// Инициализатор
	/// - Parameter decorate: декорируемый объект
	init(_ decorate: IMarkdownConverterAdapter) {
		self.decorate = decorate
	}

	/// Конвертация в PDF
	/// - Parameters:
	///   - file: файл
	///   - completion: данные
	func convertToPDF(file: File, completion: @escaping (Data?) -> Void) {
		decorate.convertToPDF(file: file) { result in
			doInMainThread {
				completion(result)
			}
		}
	}
}
