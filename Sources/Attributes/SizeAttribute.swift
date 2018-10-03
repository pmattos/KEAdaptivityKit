//
//  SizeAttribute.swift
//  KEAdaptivityKit
//
//  Created by Kai Engelhardt on 25.08.18
//  Copyright © 2018 Kai Engelhardt (https://github.com/kaiengelhardt)
//
//  Distributed under the permissive MIT license
//  Get the latest version from here:
//
//  https://github.com/kaiengelhardt/KEAdaptivityKit
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

public enum SizeAttribute: AdaptiveAttribute {
	
	public enum Component {
		
		case width
		case height
		
	}
	
	case lessThan(Component, CGFloat)
	case lessThanOrEqualTo(Component, CGFloat)
	case equalTo(Component, CGFloat)
	case greaterThanOrEqualTo(Component, CGFloat)
	case greaterThan(Component, CGFloat)
	
	public func generateCondition() -> AdaptiveCondition {
		return SizeCondition(sizeAttributeCollection: [self])
	}
	
}

extension Array where Element == SizeAttribute {
	
	public func generateCondition() -> SizeCondition {
		return SizeCondition(sizeAttributeCollection: self)
	}
	
}

public func < (lhs: SizeAttribute.Component, rhs: CGFloat) -> SizeAttribute {
	return .lessThan(lhs, rhs)
}

public func <= (lhs: SizeAttribute.Component, rhs: CGFloat) -> SizeAttribute {
	return .lessThanOrEqualTo(lhs, rhs)
}

public func == (lhs: SizeAttribute.Component, rhs: CGFloat) -> SizeAttribute {
	return .equalTo(lhs, rhs)
}

public func >= (lhs: SizeAttribute.Component, rhs: CGFloat) -> SizeAttribute {
	return .greaterThanOrEqualTo(lhs, rhs)
}

public func > (lhs: SizeAttribute.Component, rhs: CGFloat) -> SizeAttribute {
	return .greaterThan(lhs, rhs)
}
