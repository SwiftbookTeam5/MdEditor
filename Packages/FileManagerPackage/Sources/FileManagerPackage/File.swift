//
//  File.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

public class File {
	public let url: URL
	public let size: UInt64
	public let isDirectory: Bool
	public let creationDate: Date
	public var modificationDate: Date

	public var name: String {
		String(describing: url.lastPathComponent)
	}

	public var ext: String {
		String(describing: name.split(separator: ".").last ?? "")
	}

	public init(
		url: URL,
		size: UInt64 = 0,
		isDirectory: Bool = false,
		creationDate: Date = Date(),
		modificationDate: Date = Date()
	) {
		self.url = url
		self.size = size
		self.isDirectory = isDirectory
		self.creationDate = creationDate
		self.modificationDate = modificationDate
	}
}

// MARK: - CustomStringConvertible

extension File: CustomStringConvertible {

	public var description: String {
		getFormattedAttributes()
	}
}

// MARK: - Internal methods

extension File {

	/// Получение строкового представления размера файла
	/// - Returns: размер
	func getFormattedSize() -> String {
		return getFormattedSize(with: size)
	}
}

// MARK: - Private methods

private extension File {

	func getFormattedSize(with size: UInt64) -> String {
		var convertedValue = Double(size)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]

		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}

		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
	}

	func getFormattedAttributes() -> String {
		let formattedSize = getFormattedSize()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		if isDirectory {
			return "\(dateFormatter.string(from: modificationDate)) | <dir>"
		} else {
			return "\"\(ext)\" – \(dateFormatter.string(from: modificationDate)) | \(formattedSize)"
		}
	}
}
