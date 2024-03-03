//
//  FileExplorer.swift
//  MdEditor
//
//  Created by Александра Рязанова on 03.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

public enum FileSourceType {
	case documentDirectory
	case bundle(String)
}

public class FileExplorer: IFileExplorer {

	enum Error: Swift.Error {
		case wrongWay
		case fileGettingFailed
	}

	// MARK: - Properties

	public private(set) var files: [File] = []
	private let fileManager = FileManager.default

	// MARK: - Init

	public init() {}

	// MARK: - Methods

	/// Поиск источников фалов
	/// - Parameter sources: тип источника фалов
	public func scan(sources: [FileSourceType]) {
		files.removeAll()

		sources.forEach { type in
			var url: URL?

			switch type {
			case .documentDirectory:
				url = try? fileManager.url(
					for: .documentDirectory,
					in: .userDomainMask,
					appropriateFor: nil,
					create: false
				)
			case .bundle(let name):
				if let resourcePath = Bundle.main.resourcePath {
					url = URL(string: resourcePath)?.appendingPathComponent(name)
				}
			}

			if let url, let file = getFile(url: url) {
				files.append(file)
			}
		}

		files.sort { $0.isDirectory && !$1.isDirectory }
	}

	/// Поиск файлов
	/// - Parameter path: путь к файлам
	public func scan(url: URL) throws {
		files.removeAll()

		do {
			let names = try fileManager.contentsOfDirectory(atPath: url.relativePath)
			for name in names {
				if let file = getFile(url: url.appendingPathComponent(name)) {
					files.append(file)
				}
			}
		} catch {
			throw Error.fileGettingFailed
		}

		files.sort { $0.isDirectory && !$1.isDirectory }
	}

	/// Получение файла.
	/// - Parameters:
	///   - url: Путь до файла
	/// - Returns: Файл.
	public func getFile(url: URL) -> File? {
		do {
			let fileManager = FileManager.default
			let attr = try fileManager.attributesOfItem(atPath: url.relativePath)

			let file = File(
				url: url,
				size: (attr[FileAttributeKey.size] as? UInt64) ?? 0,
				isDirectory: (attr[FileAttributeKey.type] as? FileAttributeType) == FileAttributeType.typeDirectory,
				creationDate: (attr[FileAttributeKey.creationDate] as? Date) ?? Date(),
				modificationDate: (attr[FileAttributeKey.modificationDate] as? Date) ?? Date()
			)

			return file
		} catch {
			return nil
		}
	}

	/// Создание файла
	/// - Parameter name: Имя файла.
	public func createFile(with name: String, data: Data, url: URL) throws {
		do {
			try data.write(to: url.appendingPathComponent(name))
		} catch let error as NSError {
			throw error
		}
	}

	/// Создание папки.
	/// - Parameter name: Имя папки.
	public func createFolder(with name: String, url: URL) throws {
		do {
			try fileManager.createDirectory(
				atPath: url.appendingPathComponent(name).relativePath,
				withIntermediateDirectories: false,
				attributes: nil
			)
		} catch let error as NSError {
			throw error
		}
	}

	/// Загрузка текста файла
	/// - Returns: данные файла
	public func loadFileBody(url: URL) throws -> String {
		do {
			return try String(contentsOfFile: url.relativePath, encoding: .utf8)
		} catch let error as NSError {
			throw error
		}
	}
}
