//
//  HtmlVisitor.swift
//  Markdown
//
//  Created by Kirill Leonov on 22.02.2024.
//

import Foundation

public final class HtmlVisitor: IVisitor {

	public func visit(node: Document) -> [String] {
		return visitChildren(of: node)
	}

	public func visit(node: HeaderNode) -> String {
		let text = visitChildren(of: node).joined()
		return "<h\(node.level)>\(text)</h\(node.level)>"
	}

	public func visit(node: ParagraphNode) -> String {
		let text = visitChildren(of: node).joined()
		return "<p>\(text)</p>"
	}

	public func visit(node: BlockquoteNode) -> String {
		let text = visitChildren(of: node).joined()
		return "<blockquote><p>\(text)</p></blockquote>"
	}

	public func visit(node: TextNode) -> String {
		node.text
	}

	public func visit(node: BoldTextNode) -> String {
		"<strong>\(node.text)</strong>"
	}

	public func visit(node: BoldItalicTextNode) -> String {
		"<strong><em>\(node.text)</em></strong>"
	}

	public func visit(node: ItalicTextNode) -> String {
		"<em>\(node.text)</em>"
	}

	public func visit(node: EscapedCharNode) -> String {
		node.char
	}

	public func visit(node: InlineCodeNode) -> String {
		"<code>\(node.code)</code>"
	}

	public func visit(node: LineBreakNode) -> String {
		"<br/>"
	}

	public func visit(node: ImageNode) -> String {
		"<img src=\"\(node.url)>\" />"
	}
	
	public func visit(node: ListNode) -> String {
		""
	}
	
	public func visit(node: UnorderedListNode) -> String {
		let text = node.children.reduce("") { result,  node in
			if let textNode = node as? TextNode {
				return result + "<li>\(textNode.text)</li>"
			}
			
			return result
		}
		
		return "<ol>\(text)</ol>"
	}
	
	public func visit(node: OrderedListNode) -> String {
		let text = node.children.reduce("") { result,  node in
			if let textNode = node as? TextNode {
				return result + "<li>\(textNode.text)</li>"
			}
			
			return result
		}
		
		return "<ul>\(text)</ul>"
	}
}
