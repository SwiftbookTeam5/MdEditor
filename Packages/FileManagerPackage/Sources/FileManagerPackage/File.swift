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
	public let isFolder: Bool
	public let creationDate: Date
	public var modificationDate: Date

	public init(
		url: URL,
		size: UInt64 = 0,
		isFolder: Bool = false,
		creationDate: Date = Date(),
		modificationDate: Date = Date()
	) {
		self.url = url
		self.size = size
		self.isFolder = isFolder
		self.creationDate = creationDate
		self.modificationDate = modificationDate
	}

	enum ParseError: Error {
		case wrongAttribute
	}

	public static func parse(url: URL) -> Result<File, Error> {
		let fileManager = FileManager.default
		do {
			let attributes = try fileManager.attributesOfItem(atPath: url.relativePath)
			if
				let type = attributes[.type] as? FileAttributeType,
				let size = attributes[.size] as? UInt64,
				let creationDate = attributes[.creationDate] as? Date,
				let modificationDate = attributes[.modificationDate] as? Date
			{
				let file = File(
					url: url,
					size: size,
					isFolder: type == .typeDirectory,
					creationDate: creationDate,
					modificationDate: modificationDate
				)
				return .success(file)
			} else {
				return .failure(ParseError.wrongAttribute)
			}
		} catch {
			return .failure(error)
		}
	}
	
	public var fullname: String {
		url.absoluteString
	}
	
	public var path: String {
		return url.deletingLastPathComponent().absoluteString
	}
	
	public var name: String {
		url.lastPathComponent
	}
	
	public var ext: String {
		url.pathExtension
	}

	public func contentOfFile() -> Data? {
		try? Data(contentsOf: url)
	}
}
