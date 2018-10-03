//
//  AdaptiveInterface.swift
//  KEAdaptivityKit
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

public protocol AdaptiveInterface: AnyObject, AdaptiveElement {
	
	var adaptiveElements: [AdaptiveElement] { get set }
	
}

public extension AdaptiveInterface {
	
	public func update(with dataSource: AdaptiveElementDataSource) {
		for i in 0 ..< adaptiveElements.count {
			adaptiveElements[i].update(with: dataSource)
		}
	}
	
}

public extension AdaptiveInterface {
	
	public func when(_ attribute: AdaptiveAttribute, activateConstraints constraints: [NSLayoutConstraint]) {
		when([attribute], activateConstraints: constraints)
	}
	
	public func when(_ attributes: [AdaptiveAttribute], activateConstraints constraints: [NSLayoutConstraint]) {
		let condition = CompoundCondition.init(conditions: attributes.map { $0.generateCondition() })
		let element = AdaptiveConstraintContainer.init(conditions: [condition], constraints: constraints)
		adaptiveElements.append(element)
	}
	
	public func when(_ attribute: AdaptiveAttribute, do behavior: @escaping AdaptiveBehavior.Behavior, otherwise counterBehavior: AdaptiveBehavior.Behavior? = nil) {
		when([attribute], do: behavior, otherwise: counterBehavior)
	}
	
	public func when(_ attributes: [AdaptiveAttribute], do behavior: @escaping AdaptiveBehavior.Behavior, otherwise counterBehavior: AdaptiveBehavior.Behavior? = nil) {
		let condition = CompoundCondition.init(conditions: attributes.map { $0.generateCondition() })
		let element = AdaptiveBehavior(conditions: [condition], behavior: behavior, counterBehavior: counterBehavior)
		adaptiveElements.append(element)
	}
	
}
