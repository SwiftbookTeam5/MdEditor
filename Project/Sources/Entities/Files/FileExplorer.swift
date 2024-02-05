//
//  FileExplorer.swift
//  MdEditor
//
//  Created by Александра Рязанова on 03.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

protocol IFileExplorer {
	var files: [File] { get }
	func scan(path: String)
	func getFile(withNAme name: String, atPath: String) -> File?
	func createFile(withName name: String) -> Bool
	func createFolder(withName name: String)
}

class FileExplorer: IFileExplorer {

	var files = [File]()

	func scan(path: String) {
		let fileManager = FileManager.default
		let fullPath = Bundle.main.resourcePath! + "/\(path)"
		files.removeAll()

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
			// failed to read directory – bad permissions, perhaps?
		}

		files.append(contentsOf: onlyFolders)
		files.append(contentsOf: onlyFiles)
	}

	func getFile(withNAme name: String, atPath: String) -> File? {
		let fileManager = FileManager.default
		let fullPath = Bundle.main.resourcePath! + "/\(atPath)"
		do {
			let attr = try fileManager.attributesOfItem(atPath: fullPath + "/" + name)

			let file = File()
			file.name = name
			file.path = atPath
			file.isDirectory = (attr[FileAttributeKey.type] as? FileAttributeType) == FileAttributeType.typeDirectory
			file.size = (attr[FileAttributeKey.size] as? UInt64) ?? 0
			file.creationDate = (attr[FileAttributeKey.creationDate] as? Date) ?? Date()
			file.modificationDate = (attr[FileAttributeKey.modificationDate] as? Date) ?? Date()

			if file.isDirectory {
				file.ext = ""
			} else {
				file.ext = String(describing: name.split(separator: ".").last!)
			}

			return file
		} catch {
			//
		}

		return nil
	}

	func createFile(withName name: String) -> Bool {
		let fullName = Bundle.main.resourcePath! + "/\(name)"
		let empty = ""
		do {
			try empty.write(toFile: fullName, atomically: false, encoding: .utf8)
			print("Filename created \(fullName)")
			return true
		} catch {
			print("Error, can not create file \(fullName)")
			return false
		}
	}

	static func createFile2(withName name: String) {
		let fullPath = Bundle.main.resourcePath! + "/\(name)"
		let data = "Created on \(Date())".data(using: String.Encoding.utf8)
		let fileManager = FileManager.default
		fileManager.createFile(atPath: fullPath, contents: data, attributes: [:])
	}

	/// Создание папки.
	/// - Parameter name: Имя папки.
	func createFolder(withName name: String) {
		let fullPath = Bundle.main.resourcePath! + "/\(name)"
		let fileManager = FileManager.default
		do {
			try fileManager.createDirectory(atPath: fullPath, withIntermediateDirectories: false, attributes: nil)
		} catch let error as NSError {
			print(error.localizedDescription)
		}
	}
}
