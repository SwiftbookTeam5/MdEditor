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

	func test_init_withoutFiles_shouldBeZeroFile() {
		let sut = makeSUT()
		
		XCTAssertEqual(sut.files.count, 0, "Количество файлов в менеджере должно быть равно 0.")
	}
	
	func test_createFile_shouldBeCreateOneFile() {
		let sut = makeSUT()
		let url = makeDocumentURL()
		let bodyFile = "Тело файла"
		let nameFile = "CreateFile_\(UUID().uuidString).txt"

		if let url, let data = bodyFile.data(using: .utf8) {
			XCTAssertNoThrow(
				try sut.createFile(with: nameFile, data: data, url: url),
				"Не создался файл"
			)
		}
	}

	func test_createFolder_shouldBeCreateOneFolder() {
		let sut = makeSUT()
		let url = makeDocumentURL()
		let nameFolder = "CreateFolder_" + UUID().uuidString
		
		if let url {
			XCTAssertNoThrow(
				try sut.createFolder(with: nameFolder, url: url),
				"Не создалась папка"
			)
		}
	}
	
	func test_getFile_shouldBeСorrectFile() {
		let sut = makeSUT()
		let nameFile = "TestContent.md"
		let url = makeBundleURL(with: nameFile)
		
		if let url {
			let file = sut.getFile(url: url)
			XCTAssertNotNil(file, "Не получен файл")
			XCTAssertEqual(file?.name ?? "", nameFile, "Не верное имя файла")
		}
	}

	func test_loadFileBody_shouldBeСorrectBodyFile() {
		let sut = makeSUT()
		let nameFile = "TestContent.md"
		let url = makeBundleURL(with: nameFile)
		
		if let url {
			XCTAssertNoThrow(try sut.loadFileBody(url: url), "Не загрузилосьтело файла")
		}
	}
}

// MARK: - TestData

private extension FileExplorerTests {
	
	func makeSUT() -> FileExplorer {
		FileExplorer(fileManager: fileManager)
	}
	
	func makeDocumentURL() -> URL? {
		try? fileManager.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: false
		)
	}
	
	func makeBundleURL(with name: String) -> URL? {
		let bundlePath = Bundle(for: Self.self).path(
			forResource: "FileManagerPackage_FileManagerPackageTests",
			ofType: "bundle"
		)
		
		let bundle = Bundle(path: bundlePath ?? "")
		return bundle?.bundleURL.appendingPathComponent(name)
	}
}
