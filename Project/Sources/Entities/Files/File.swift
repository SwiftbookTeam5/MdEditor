//
//  File.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

class File {
	var name = ""
	var path = ""
	var ext = ""
	var size: UInt64 = 0
	var isDirectory = false
	var creationDate = Date()
	var modificationDate = Date()
	var fullname: String {
		get {
			return "\(path)/\(name)"
		}
	}
}

// MARK: - CustomStringConvertible

extension File: CustomStringConvertible {

	var description: String {
		getFormattedAttributes()
	}
}

// MARK: - Internal methods

extension File {

	func getFormattedSize() -> String {
		return getFormattedSize(with: size)
	}

	func loadFileBody() -> String {
		var text = ""
		let fullPath = Bundle.main.resourcePath! + "/\(path)/\(name)"
		do {
			text = try String(contentsOfFile: fullPath, encoding: String.Encoding.utf8)
		} catch {
			print("Failed to read text from \(name)")
		}

		return text
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
