//
//  ViewController.swift
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

import AppKit
import KELayoutKit

class ViewController: NSViewController, AdaptiveInterface {
	
	var sizeAdaptiveElements: [SizeAdaptiveElement] = []
	
	let button: NSButton
	
	init() {
		button = NSButton(frame: CGRect(x: 10, y: 10, width: 300, height: 400))
		super.init(nibName: nil, bundle: nil)
		setUpUI()
	}
	
	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setUpUI() {
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		
		button.title = "Ente"
		
		NSLayoutConstraint.activate([
			view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
			view.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
			button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			])
		
		when(size: [.width > 400, .height > 300], apply: [
			button.widthAnchor.constraint(equalToConstant: 180),
			])
		when(size: [.width <= 400, .height <= 400], apply: [
			button.widthAnchor.constraint(equalToConstant: 60),
			])
	}
	
	override func loadView() {
		view = NSView(frame: .zero)
	}
	
	override func viewDidLayout() {
		super.viewDidLayout()
		update(with: view.bounds.size)
	}
	
}
