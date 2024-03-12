//
//  File.swift
//  
//
//  Created by Александра Рязанова on 12.02.2024.
//

import Foundation

import XCTest
@testable import FileManagerPackage

final class FileExplorerTests: XCTestCase {
	
	// MARK: - Private properties
	
	private var fileManager = FileManager.default

	// MARK: - Internal Methods
	
	func test_createFile_shouldBeCreateOneFile() {
		let sut = FileExplorer()
		let url = makeDocumentURL()
		let fileBody = "Тело файла"
		let fileName = "CreateFile_\(UUID().uuidString).txt"

		if let url {
			let result = sut.createNewFile(at: url, fileName: fileName, fileBody: fileBody)
			if case .failure = result {
				XCTAssert(false, "Не создался файл")
			}
		}
	}

	func test_createFolder_shouldBeCreateOneFolder() {
		let sut = FileExplorer()
		let url = makeDocumentURL()
		let nameFolder = "CreateFolder_" + UUID().uuidString

		if let url {
			let result = sut.createFolder(at: url, withName: nameFolder)
			if case .failure = result {
				XCTAssert(false, "Не создалась папка")
			}
		}
	}

	func test_contentsOfFolder_shouldBeСorrectFile() {
		let sut = FileExplorer()
		let url = makeBundleURL()

		if let url {
			let result = sut.contentsOfFolder(at: url)

			if case .failure = result {
				XCTAssert(false, "Не получено содержиме папки")
			}
		}
	}
}

// MARK: - TestData

private extension FileExplorerTests {

	func makeDocumentURL() -> URL? {
		try? fileManager.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: false
		)
	}
	
	func makeBundleURL() -> URL? {
		let bundlePath = Bundle(for: Self.self).path(
			forResource: "FileManagerPackage_FileManagerPackageTests",
			ofType: "bundle"
		)

		return Bundle(path: bundlePath ?? "")?.bundleURL
	}
}
