//
//  FilesService.swift
//  MdEditor
//
//  Created by Александра Рязанова on 26.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import FileManagerPackage
import NetworkLayerPackage

protocol IFilesService {
	/// Получение списка файлов
	/// - Parameter completion: результат
	func fetchFiles(completion: @escaping (Result<[FileResponseDTO], HTTPNetworkServiceError>) -> Void)

	/// Получение файла
	/// - Parameters:
	///   - id: id файла
	///   - completion: результат
	func fetchFile(id: String, completion: @escaping (Result<FileResponseDTO, HTTPNetworkServiceError>) -> Void)

	/// Загрузка файла на сервер
	/// - Parameters:
	///   - file: бинарные данные
	///   - completion: результат
	func uploadFile(file: File, completion: @escaping (Result<FileResponseDTO, HTTPNetworkServiceError>) -> Void)

	/// Скачивание файла
	/// - Parameters:
	///   - id:  id файла
	///   - completion: результат
	func downloadFile(id: String, completion: @escaping (Result<URL?, HTTPNetworkServiceError>) -> Void)

	/// Удаление файла
	/// - Parameters:
	///   - id: id файла
	///   - completion: результат
	func deleteFile(id: String, completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void)
}

final class FilesService {

	// MARK: - Private properties

	private let networkService: INetworkService
	private let tokenPepository: ITokenPepository

	// MARK: - Init

	init(networkService: INetworkService, tokenPepository: ITokenPepository) {
		self.networkService = networkService
		self.tokenPepository = tokenPepository
	}
}

// MARK: - Internal methods

extension FilesService: IFilesService {

	/// Получение списка файлов
	/// - Parameter completion: результат
	func fetchFiles(completion: @escaping (Result<[FileResponseDTO], HTTPNetworkServiceError>) -> Void) {
		guard let token = tokenPepository.getToken() else { return }
		networkService.perform(FilesRequestDTO(), token: token, completion: completion)
	}

	/// Получение файла
	/// - Parameters:
	///   - id: id файла
	///   - completion: результат
	func fetchFile(id: String, completion: @escaping (Result<FileResponseDTO, HTTPNetworkServiceError>) -> Void) {
		guard let token = tokenPepository.getToken() else { return }
		networkService.perform(FilesRequestDTO(id: id), token: token, completion: completion)
	}

	/// Загрузка файла на сервер
	/// - Parameters:
	///   - file: бинарные данные
	///   - completion: результат
	func uploadFile(file: File, completion: @escaping (Result<FileResponseDTO, HTTPNetworkServiceError>) -> Void) {
		guard let token = tokenPepository.getToken() else { return }
		let request = UploadFileRequestDTO(file: file)
		networkService.perform(request, token: token, completion: completion)
	}

	/// Скачивание файла
	/// - Parameters:
	///   - id:  id файла
	///   - completion: результат
	func downloadFile(id: String, completion: @escaping (Result<URL?, HTTPNetworkServiceError>) -> Void) {
		guard let token = tokenPepository.getToken() else { return }
		networkService.download(DownloadFileRequestDTO(id: id), token: token, completion: completion)
	}

	/// Удаление файла
	/// - Parameters:
	///   - id: id файла
	///   - completion: результат
	func deleteFile(id: String, completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void) {
		guard let token = tokenPepository.getToken() else { return }
		networkService.perform(DeleteFileRequestDTO(id: id), token: token, completion: completion)
	}
}
