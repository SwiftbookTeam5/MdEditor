//
//  UICollectionView+RegisterCell.swift
//  MdEditor
//
//  Created by Александра Рязанова on 03.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

// MARK: - Reusable

protocol Reusable {
	static var reusableId: String { get }
}

extension UICollectionReusableView: Reusable {
	static var reusableId: String { String(describing: self) }
}

// MARK: - UICollectionView

extension UICollectionView {

	/// Регистрация ячейки
	/// - Parameter T: тип данных ячейки
	func register<T: UICollectionViewCell>(_: T.Type) {
		register(T.self, forCellWithReuseIdentifier: T.reusableId)
	}

	/// Регистрация header и footer
	/// - Parameters:
	///   - T: тип данных ячейки
	///   - type: тип - header или footer
	func register<T: UICollectionReusableView>(_: T.Type, for type: ReusableViewType) {
		register(T.self, forSupplementaryViewOfKind: type.rawValue, withReuseIdentifier: T.reusableId)
	}

	/// Получение ячейки
	/// - Parameter indexPath: индекс
	/// - Returns: ячейка
	func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableId, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.reusableId)")
		}

		return cell
	}

	/// Получение header и footer
	/// - Parameters:
	///   - type: тип - header или footer
	///   - indexPath: индекс
	/// - Returns: header или footer
	func dequeuReusableView<T: UICollectionReusableView>(for type: ReusableViewType, at indexPath: IndexPath) -> T {
		guard let view = dequeueReusableSupplementaryView(
			ofKind: type.rawValue,
			withReuseIdentifier: T.reusableId,
			for: indexPath
		) as? T else {
			fatalError("Could not dequeue view with identifier: \(T.reusableId)")
		}

		return view
	}
}

// MARK: - ReusableViewType

enum ReusableViewType: String {
	case header = "header-element-kind"
	case footer = "footer-element-kind"
}
