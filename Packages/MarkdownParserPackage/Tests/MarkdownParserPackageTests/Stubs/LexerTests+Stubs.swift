//
//  File.swift
//  
//
//  Created by Александра Рязанова on 21.02.2024.
//

import Foundation

extension LexerTests {

	var headersString: String {
		"""
		# Header1

		## Header2

		### Header3

		#### Header4

		##### Header5

		###### Header6
		"""
	}

	var blockquotesString: String {
		"""
		> Blockquote1

		>> Blockquote2

		>>> Blockquote3

		>>>> Blockquote4

		>>>>> Blockquote5

		>>>>>> Blockquote6
		"""
	}

	var horizontalLineString: String {
		"""
		---

		***

		____

		--

		**

		_
		"""
	}

	var unorderedListString: String {
		"""
		- пункт
		- пункт
		"""
	}

	var orderedListString: String {
		"""
		1. пункт
		2. пункт
		"""
	}

	var paragraphString: String {
		"""
		Параграф
		1 пункт
		-пункт
		"""
	}

	var codeBlockString: String {
		"""
		'''md
		строка кода
		'''
		"""
	}
	
	var textString: String {
		"""
		*курсив*
		**жирный**
		***жирный курсив***
		нормальный
		`строка кода`
		"""
	}
}
