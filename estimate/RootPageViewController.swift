//
//  RootViewController.swift
//  estimate
//
//  Created by Oliver Michalak on 23.06.16.
//  Copyright © 2016 Oliver Michalak. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDelegate {

	lazy var modelController: ModelController = {
		return ModelController()
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		delegate = self
		let startingViewController: DataViewController = modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
		let viewControllers = [startingViewController]
		self.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
		self.dataSource = modelController
	}

}
