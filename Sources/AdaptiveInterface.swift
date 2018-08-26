//
//  AdaptiveInterface.swift
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

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

public protocol AdaptiveInterface: AnyObject {
	
	var sizeAdaptiveElements: [SizeAdaptiveElement] { get set }
	
	#if canImport(UIKit)
	
	var traitAdaptiveElements: [TraitAdaptiveElement] { get set }
	
	#endif
	
}

public extension AdaptiveInterface {
	
	public func update(with newSize: CGSize) {
		sizeAdaptiveElements.filter { $0.condition.evaluate(with: newSize) == false }.forEach { $0.update(with: newSize) }
		sizeAdaptiveElements.filter { $0.condition.evaluate(with: newSize) == true }.forEach { $0.update(with: newSize) }
	}
	
	#if canImport(UIKit)
	
	public func update(with newTraitCollection: UITraitCollection) {
		traitAdaptiveElements.filter { $0.condition.evaluate(with: newTraitCollection) == false }.forEach { $0.update(with: newTraitCollection) }
		traitAdaptiveElements.filter { $0.condition.evaluate(with: newTraitCollection) == true }.forEach { $0.update(with: newTraitCollection) }
	}
	
	#endif
	
}

public extension AdaptiveInterface {
	
	public func when(size attributes: [SizeAttribute], apply constraints: [NSLayoutConstraint]) {
		let element = SizeAdaptiveConstraintContainer.init(condition: attributes.generateCondition(), constraints: constraints)
		sizeAdaptiveElements.append(element)
	}
	
	#if canImport(UIKit)
	
	public func when(traits: [TraitAttribute], apply constraints: [NSLayoutConstraint]) {
		let element = TraitAdaptiveConstraintContainer(condition: traits.generateCondition(), constraints: constraints)
		traitAdaptiveElements.append(element)
	}
	
	#endif
	
}
