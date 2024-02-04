//
//  MainFileCollectionViewCell.swift
//  MdEditor
//
//  Created by Александра Рязанова on 02.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

final class FileCollectionViewCell: UICollectionViewCell {

	// MARK: - Private properties

	private lazy var statusView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = Sizes.Radius.medium
		view.clipsToBounds = true

		return view
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .caption2)
		label.adjustsFontForContentSizeCategory = true
		label.textColor = FlatColor.Gray.IronGray
		label.textAlignment = .center

		return label
	}()

	private lazy var vStack: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.spacing = Sizes.Padding.half

		return view
	}()

	// MARK: - Lifecycle

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		titleLabel.text = nil
		statusView.backgroundColor = .yellow
	}

	// MARK: - Configure

	/// Конфигурирование ячейки файла
	/// - Parameters:
	///   - title: название файла
	///   - color: цвет статуса файла
	func configure(title: String, color: UIColor) {
		statusView.backgroundColor = color
		titleLabel.text = title
	}
}

// MARK: - UI setup

private extension FileCollectionViewCell {

	func setupView() {
		embedSubviews()
		setSubviewsConstraints()
	}

	func embedSubviews() {
		vStack.addArrangedSubview(statusView)
		vStack.addArrangedSubview(titleLabel)
		contentView.addSubview(vStack)
	}

	func setSubviewsConstraints() {
		NSLayoutConstraint.activate(
			[
				vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
				vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
				vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
				vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

				titleLabel.heightAnchor.constraint(equalToConstant: 18.0),
				statusView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4 * 1.5)
			]
		)
	}
}
