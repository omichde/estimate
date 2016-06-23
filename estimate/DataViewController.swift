//
//  DataViewController.swift
//  estimate
//
//  Created by Oliver Michalak on 23.06.16.
//  Copyright © 2016 Oliver Michalak. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var dataButton: UIButton!
	var dataObject: String = ""

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		self.dataButton.layer.borderColor = UIColor.whiteColor().CGColor

		let fontHeight = CGFloat(arc4random_uniform(200)+100)
		let fontFamilies = UIFont.familyNames()
		var fontNames = [String]()
		repeat {
			fontNames = UIFont.fontNamesForFamilyName(fontFamilies[Int(arc4random_uniform(UInt32(fontFamilies.count)))])
		} while fontNames.count < 1
		let fontName = fontNames[Int(arc4random_uniform(UInt32(fontNames.count)))]
		let fontColor = UIColor(colorLiteralRed: Float(arc4random_uniform(256))/256,
		                        green: Float(arc4random_uniform(256))/256,
		                        blue: Float(arc4random_uniform(256))/256,
		                        alpha: 1)
		let paragraph = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
		paragraph.alignment = .Center
		paragraph.lineBreakMode = .ByCharWrapping
		let attributes:[String:AnyObject] = [NSFontAttributeName: UIFont(name: fontName, size: fontHeight)!,
		                                     NSParagraphStyleAttributeName: paragraph,
		                                     NSForegroundColorAttributeName: fontColor,
		                                     NSStrokeWidthAttributeName: -1,
		                                     NSStrokeColorAttributeName: UIColor.blackColor()]
		let attrString = NSAttributedString(string: dataObject, attributes: attributes)
		self.dataButton.setAttributedTitle(attrString, forState: .Normal)
		let data = NSUserDefaults.standardUserDefaults().objectForKey("image") as? NSData
		if (data != nil) {
			let image = UIImage(data: data!)
			self.dataButton.setBackgroundImage(image, forState: .Normal)
		}
	}

	@IBAction func selectPhoto(sender: UIButton) {
		guard UIImagePickerController.isSourceTypeAvailable(.Camera) else { return }
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.sourceType = .Camera
		presentViewController(picker, animated: true) { }
	}

	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
		let data = UIImageJPEGRepresentation(image, 0.9)
		NSUserDefaults.standardUserDefaults().setObject(data, forKey: "image")
		self.dataButton.setBackgroundImage(image, forState: .Normal)
		picker.dismissViewControllerAnimated(true) { }
	}
}
