//
//  IFileExplorer.swift
//  
//
//  Created by Александра Рязанова on 12.02.2024.
//

import Foundation

public protocol IFileExplorer {
	
	// MARK: - Properties
	
	var files: [File] { get }
	
	// MARK: - Methods
	
	/// Поиск источников фалов
	/// - Parameter sources: тип источника фалов
	func scan(sources: [FileSourceType])
	
	/// Поиск файлов
	/// - Parameter path: путь к файлам
	func scan(url: URL) throws
	
	/// Получение файла.
	/// - Parameters:
	///   - url: Путь до файла
	/// - Returns: Файл.
	func getFile(url: URL) -> File?
	
	/// Создание файла
	/// - Parameter name: Имя файла.
	func createFile(with name: String, data: Data, url: URL) throws
	
	/// Создание папки.
	/// - Parameter name: Имя папки.
	func createFolder(with name: String, url: URL) throws
	
	/// Загрузка текста файла
	/// - Returns: данные файла
	func loadFileBody(url: URL) throws -> String
}
