//
//  SizeCondition.swift
//  KELayoutKit
//
//  Created by Kai Engelhardt on 26.08.18
//  Copyright © 2018 Kai Engelhardt. All rights reserved.
//
//  Distributed under the permissive MIT license
//  Get the latest version from here:
//
//  https://github.com/kaiengelhardt/KELayoutKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import CoreGraphics

public struct SizeCondition: AdaptiveCondition {
	
	public let sizeAttributeCollection: [SizeAttribute]
	
	public func evaluate(with dataSource: AdaptiveElementDataSource) -> Bool {
		let size = dataSource.bounds.size
		
		func evaluate(sizeAttribute: SizeAttribute) -> Bool {
			switch sizeAttribute {
			case .lessThan(.width, let width):
				return size.width < width
			case .lessThan(.height, let height):
				return size.height < height
			case .lessThanOrEqualTo(.width, let width):
				return size.width <= width
			case .lessThanOrEqualTo(.height, let height):
				return size.height <= height
			case .equalTo(.width, let width):
				return size.width == width
			case .equalTo(.height, let height):
				return size.height == height
			case .greaterThanOrEqualTo(.width, let width):
				return size.width >= width
			case .greaterThanOrEqualTo(.height, let height):
				return size.height >= height
			case .greaterThan(.width, let width):
				return size.width > width
			case .greaterThan(.height, let height):
				return size.height > height
			}
		}
		
		return sizeAttributeCollection.reduce(true) { result, sizeAttribute in
			result && evaluate(sizeAttribute: sizeAttribute)
		}
	}
	
}
