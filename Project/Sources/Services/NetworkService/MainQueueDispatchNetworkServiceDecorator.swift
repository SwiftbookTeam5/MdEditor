//
//  MainQueueDispatchNetworkServiceDecorator.swift
//  MdEditor
//
//  Created by Александра Рязанова on 28.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import NetworkLayerPackage

/// Декоратор для управления потоками при сетевых запросах
final class MainQueueDispatchNetworkServiceDecorator: INetworkService {

	// MARK: - Private properties

	private let decorate: INetworkService

	// MARK: - Init

	/// Инициализатор
	/// - Parameter decorate: декорируемый объект
	init(_ decorate: INetworkService) {
		self.decorate = decorate
	}

	// MARK: - Internal methods

	/// Выполнение сетевого запроса с декодированием в модель
	/// - Parameters:
	///   - request: данные запроса
	///   - token: токен авторизации
	///   - completion: результат выполнения запроса
	func perform<T: Codable>(
		_ request: INetworkRequest,
		token: Token?,
		completion: @escaping (Result<T, HTTPNetworkServiceError>) -> Void
	) {
		decorate.perform(request, token: token) { result in
			doInMainThread {
				completion(result)
			}
		}
	}

	/// Выполнение сетевого запроса с декодированием в модель
	/// - Parameters:
	///   - request: данные запроса
	///   - token: токен авторизации
	///   - completion: результат выполнения запроса
	func perform(
		_ request: INetworkRequest,
		token: Token?,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	) {
		decorate.perform(request, token: token) { result in
			doInMainThread {
				completion(result)
			}
		}
	}

	/// Выполнение сетевого запроса с декодированием в Data
	/// - Parameters:
	///   - urlRequest: запрос
	///   - completion: результат выполнения запроса
	func perform(
		urlRequest: URLRequest,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	) {
		decorate.perform(urlRequest: urlRequest) { result in
			doInMainThread {
				completion(result)
			}
		}
	}

	/// Выполнение сетевого запроса загрузки файла
	/// - Parameters:
	///   - request: данные запроса
	///   - token: токен авторизации
	///   - completion: результат выполнения запроса
	func download(
		_ request: INetworkRequest,
		token: Token?,
		completion: @escaping (Result<URL?, HTTPNetworkServiceError>) -> Void
	) {
		decorate.download(request, token: token) { result in
			doInMainThread {
				completion(result)
			}
		}
	}

	/// Выполнение сетевого запроса загрузки файла
	/// - Parameters:
	///   - urlRequest: запрос
	///   - completion: результат выполнения запроса
	func download(
		urlRequest: URLRequest,
		completion: @escaping (Result<URL?, HTTPNetworkServiceError>) -> Void
	) {
		decorate.download(urlRequest: urlRequest) { result in
			doInMainThread {
				completion(result)
			}
		}
	}
}
