//
//  RootViewController.swift
//  estimate
//
//  Created by Oliver Michalak on 23.06.16.
//  Copyright © 2016 Oliver Michalak. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()

		self.delegate = self
		let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
		let viewControllers = [startingViewController]
		self.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
		self.dataSource = self.modelController
	}

	var modelController: ModelController {
		if _modelController == nil {
		    _modelController = ModelController()
		}
		return _modelController!
	}

	var _modelController: ModelController? = nil

}
