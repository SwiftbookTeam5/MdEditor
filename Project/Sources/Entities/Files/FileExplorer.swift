//
//  FileExplorer.swift
//  MdEditor
//
//  Created by Александра Рязанова on 03.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

protocol IFileExplorer {

	// MARK: - Properties

	var files: [File] { get }

	// MARK: - Methods

	/// Поиск файлов
	/// - Parameter path: путь к файлам
	func scan(path: String) throws

	/// Получение файла.
	/// - Parameters:
	///   - name: Имя файла
	///   - atPath: Путь до файла
	/// - Returns: Файл.
	func getFile(withNAme name: String, atPath: String) -> File?

	/// Создание файла
	/// - Parameter name: Имя файла.
	func createFile(withName name: String) throws

	/// Создание папки.
	/// - Parameter name: Имя папки.
	func createFolder(withName name: String) throws
}

class FileExplorer: IFileExplorer {

	enum Error: Swift.Error {
		case wrongWay
		case fileGettingFailed
	}

	// MARK: - Properties

	private(set) var files = [File]()

	// MARK: - Methods

	/// Поиск файлов
	/// - Parameter path: путь к файлам
	func scan(path: String) throws {
		files.removeAll()

		guard let resourcePath = Bundle.main.resourcePath else {
			throw Error.wrongWay
		}

		let fileManager = FileManager.default
		let fullPath = resourcePath + "/\(path)"

		var onlyFiles = [File]()
		var onlyFolders = [File]()

		do {
			let items = try fileManager.contentsOfDirectory(atPath: fullPath)
			for item in items {
				if let file = getFile(withNAme: item, atPath: path) {
					if file.isDirectory {
						onlyFolders.append(file)
					} else {
						onlyFiles.append(file)
					}
				}
			}
		} catch {
			throw Error.fileGettingFailed
		}

		files.append(contentsOf: onlyFolders)
		files.append(contentsOf: onlyFiles)
	}

	/// Получение файла.
	/// - Parameters:
	///   - name: Имя файла
	///   - atPath: Путь до файла
	/// - Returns: Файл.
	func getFile(withNAme name: String, atPath: String) -> File? {
		guard let resourcePath = Bundle.main.resourcePath else {
			return nil
		}

		let fileManager = FileManager.default
		let fullPath = resourcePath + "/\(atPath)"

		do {
			let attr = try fileManager.attributesOfItem(atPath: fullPath + "/" + name)

			let file = File()
			file.name = name
			file.path = atPath
			file.isDirectory = (attr[FileAttributeKey.type] as? FileAttributeType) == FileAttributeType.typeDirectory
			file.size = (attr[FileAttributeKey.size] as? UInt64) ?? 0
			file.creationDate = (attr[FileAttributeKey.creationDate] as? Date) ?? Date()
			file.modificationDate = (attr[FileAttributeKey.modificationDate] as? Date) ?? Date()

			return file
		} catch {
			return nil
		}
	}

	/// Создание файла
	/// - Parameter name: Имя файла.
	func createFile(withName name: String) throws {
		guard let resourcePath = Bundle.main.resourcePath else {
			throw Error.wrongWay
		}

		let fullName = resourcePath + "/\(name)"
		let empty = ""
		do {
			try empty.write(toFile: fullName, atomically: false, encoding: .utf8)
		} catch let error as NSError {
			throw error
		}
	}

	/// Создание папки.
	/// - Parameter name: Имя папки.
	func createFolder(withName name: String) throws {
		guard let resourcePath = Bundle.main.resourcePath else {
			throw Error.wrongWay
		}

		let fullPath = resourcePath + "/\(name)"
		let fileManager = FileManager.default

		do {
			try fileManager.createDirectory(atPath: fullPath, withIntermediateDirectories: false, attributes: nil)
		} catch let error as NSError {
			throw error
		}
	}
}
