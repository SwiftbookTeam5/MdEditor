//
//  MainCompositionalLayout.swift
//  MdEditor
//
//  Created by Александра Рязанова on 02.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

private enum Config {

	enum Files {
		static let fractionalWidth: CGFloat = 0.25
	}
}

final class MainCompositionalLayout {

	// MARK: - Internal properties

	var sections: [MainModel.ViewModel.Section] = []

	var layout: UICollectionViewCompositionalLayout {
		let config = UICollectionViewCompositionalLayoutConfiguration()
		config.scrollDirection = .vertical
		config.interSectionSpacing = Sizes.Padding.normal

		return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
			self?.section(at: sectionIndex)
		}, configuration: config)
	}

	// MARK: - Private properties

	private var defaultSize: NSCollectionLayoutSize {
		.init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
	}

	private var defaultItem: NSCollectionLayoutItem {
		NSCollectionLayoutItem(layoutSize: defaultSize)
	}

	// MARK: - Private Methods

	private func section(at index: Int) -> NSCollectionLayoutSection? {
		let section = sections[index]

		switch section.type {
		case .horizontal:
			return createHorizontalSection()
		case .vertical:
			return createVerticalSection()
		}
	}

	private func createHorizontalSection() -> NSCollectionLayoutSection {
		let layoutSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(Config.Files.fractionalWidth),
			heightDimension: .estimated(1.0)
		)

		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: layoutSize,
			subitems: [defaultItem]
		)

		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = Sizes.Padding.normal
		section.orthogonalScrollingBehavior = .continuous
		section.contentInsets = NSDirectionalEdgeInsets(
			top: Sizes.Padding.normal,
			leading: Sizes.Padding.normal,
			bottom: 0,
			trailing: Sizes.Padding.normal
		)

		return section
	}

	private func createVerticalSection() -> NSCollectionLayoutSection {
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: defaultSize, subitems: [defaultItem])
		let section = NSCollectionLayoutSection(group: group)

		return section
	}
}
