/*
 * Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit

extension UIViewController {
	/**
	A convenience property that provides access to the StatusBarController.
	This is the recommended method of accessing the StatusBarController
	through child UIViewControllers.
	*/
	public var statusBarController: StatusBarController? {
		var viewController: UIViewController? = self
		while nil != viewController {
			if viewController is StatusBarController {
				return viewController as? StatusBarController
			}
			viewController = viewController?.parent
		}
		return nil
	}
}

open class StatusBarController: RootController {
	/// A reference to the statusBar.
	open private(set) lazy var statusBar = View()
	
	/**
	To execute in the order of the layout chain, override this
	method. LayoutSubviews should be called immediately, unless you
	have a certain need.
	*/
	open override func layoutSubviews() {
		super.layoutSubviews()
		statusBar.isHidden = Device.isLandscape && .phone == Device.userInterfaceIdiom
		rootViewController.view.frame = view.bounds
	}
	
	/**
	Prepares the view instance when intialized. When subclassing,
	it is recommended to override the prepare method
	to initialize property values and other setup operations.
	The super.prepare method should always be called immediately
	when subclassing.
	*/
	open override func prepare() {
        super.prepare()
		prepareStatusBar()
	}
	
	/// Prepares the statusBar.
	private func prepareStatusBar() {
		statusBar.zPosition = 3000
		statusBar.backgroundColor = .white
		view.layout(statusBar).top().horizontally().height(20)
	}
}
