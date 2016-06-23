//
//  ModelController.swift
//  estimate
//
//  Created by Oliver Michalak on 23.06.16.
//  Copyright © 2016 Oliver Michalak. All rights reserved.
//

import UIKit

class ModelController: NSObject, UIPageViewControllerDataSource {

	var pageData: [String] = ["?", "0", "1", "2", "3", "5", "8", "13", "20", "42", "100"]

	func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
		if (self.pageData.count == 0) || (index >= self.pageData.count) {
		    return nil
		}

		let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as! DataViewController
		dataViewController.dataObject = self.pageData[index]
		return dataViewController
	}

	func indexOfViewController(viewController: DataViewController) -> Int {
		return pageData.indexOf(viewController.dataObject) ?? NSNotFound
	}

	func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
	    var index = self.indexOfViewController(viewController as! DataViewController)
	    if (index == 0) || (index == NSNotFound) {
	        return nil
	    }
	    
	    index -= 1
	    return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
	}

	func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
	    var index = self.indexOfViewController(viewController as! DataViewController)
	    if index == NSNotFound {
	        return nil
	    }
	    
	    index += 1
	    if index == self.pageData.count {
	        return nil
	    }
	    return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
	}

}
