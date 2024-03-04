//
//  AttributedTextVisitor.swift
//  Markdown
//
//  Created by Kirill Leonov on 22.02.2024.
//

import UIKit

public final class AttributedTextVisitor: IVisitor {

	// MARK: - Init

	public init() {}

	// MARK: - Public methods

	public func visit(node: Document) -> [NSMutableAttributedString] {
		visitChildren(of: node)
	}

	public func visit(node: HeaderNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode(String(repeating: "#", count: node.level) + " ")
		let text = visitChildren(of: node).joined()

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)
		result.append(String.lineBreak)

		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.headerColor[node.level - 1],
			.font: UIFont.systemFont(ofSize: Appearance.headerSize[node.level - 1])
		]

		result.addAttributes(attributes, range: NSRange(0..<result.length))
		return result
	}

	public func visit(node: ParagraphNode) -> NSMutableAttributedString {
		let result = visitChildren(of: node).joined()
		result.append(String.lineBreak)
		result.append(String.lineBreak)
		return result
	}

	public func visit(node: BlockquoteNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode(String(repeating: ">", count: node.level) + " ")
		let text = visitChildren(of: node).joined()

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)
		result.append(String.lineBreak)

		return result
	}

	public func visit(node: TextNode) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textColor,
			.font: UIFont.systemFont(ofSize: Appearance.textSize)
		]

		let result = NSMutableAttributedString(string: node.text, attributes: attributes)
		return result
	}

	public func visit(node: BoldTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("**")

		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textBoldColor,
			.font: UIFont.boldSystemFont(ofSize:  Appearance.textSize)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)

		return result
	}

	public func visit(node: BoldItalicTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("***")

		let font: UIFont

		if let fontDescriptor = UIFontDescriptor
			.preferredFontDescriptor(withTextStyle: .body)
			.withSymbolicTraits([.traitBold, .traitItalic]) {
			font = UIFont(descriptor: fontDescriptor, size:  Appearance.textSize)
		} else {
			font = UIFont.boldSystemFont(ofSize:  Appearance.textSize)
		}

		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textBoldItalicColor,
			.font: font
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)

		return result
	}

	public func visit(node: ItalicTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("*")

		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textItalicColor,
			.font: UIFont.italicSystemFont(ofSize: Appearance.textSize)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)

		return result
	}

	public func visit(node: EscapedCharNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}

	public func visit(node: InlineCodeNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}

	public func visit(node: LineBreakNode) -> NSMutableAttributedString {
		String.lineBreak
	}

	public func visit(node: ImageNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	public func visit(node: ListNode) -> NSMutableAttributedString {
		let result = visitChildren(of: node).joined()

		return result
	}
	
	public func visit(node: UnorderedListNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("- ")
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)

		return result
	}
	
	public func visit(node: OrderedListNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("* ")
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)

		return result
	}
}

// MARK: - Private menthods

private extension AttributedTextVisitor {

	func makeMarkdownCode(_ code: String) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.markdownCodeColor,
			.font: UIFont.systemFont(ofSize:  Appearance.textSize)
		]

		return NSMutableAttributedString(string: code, attributes: attributes)
	}
}

// MARK: - Appearance

private extension AttributedTextVisitor {

	enum Appearance {
		static let markdownCodeColor: UIColor = .lightGray
		static let textSize: CGFloat = 18
		static let textColor: UIColor = .black
		static let textBoldColor: UIColor = .black
		static let textBoldItalicColor: UIColor = .black
		static let textItalicColor: UIColor = .black
		static let headerSize: [CGFloat] = [40, 30, 26, 22, 20, 18]
		static let headerColor: [UIColor] = [.black, .black, .black, .black, .black, .black]
	}
}
