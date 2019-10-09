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

	func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> DataViewController? {
		if (pageData.count == 0) || (index >= pageData.count) {
		    return nil
		}

		let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
		dataViewController.dataObject = pageData[index]
		return dataViewController
	}

	func indexOfViewController(_ viewController: DataViewController) -> Int {
		return pageData.firstIndex(of: viewController.dataObject) ?? NSNotFound
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
	    var index = indexOfViewController(viewController as! DataViewController)
	    if (index == 0) || (index == NSNotFound) {
	        return nil
	    }
	    
	    index -= 1
	    return viewControllerAtIndex(index, storyboard: viewController.storyboard!)
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
	    var index = indexOfViewController(viewController as! DataViewController)
	    if index == NSNotFound {
	        return nil
	    }
	    
	    index += 1
	    if index == pageData.count {
	        return nil
	    }
	    return viewControllerAtIndex(index, storyboard: viewController.storyboard!)
	}

}
