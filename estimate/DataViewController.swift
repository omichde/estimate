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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let fontHeight = CGFloat(arc4random_uniform(200)+100)
		let fontFamilies = UIFont.familyNames
		var fontNames = [String]()
		repeat {
			fontNames = UIFont.fontNames(forFamilyName: fontFamilies[Int(arc4random_uniform(UInt32(fontFamilies.count)))])
		} while fontNames.count < 1
		let fontName = fontNames[Int(arc4random_uniform(UInt32(fontNames.count)))]
		let fontColor = UIColor(red:CGFloat(arc4random_uniform(128)+128)/256,
														green: CGFloat(arc4random_uniform(128)+128)/256,
														blue: CGFloat(arc4random_uniform(128)+128)/256,
														alpha: 1)
		let paragraph = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
		paragraph.alignment = .center
		paragraph.lineBreakMode = .byCharWrapping
		let attributes:[NSAttributedString.Key:AnyObject] = [.font: UIFont(name: fontName, size: fontHeight)!,
																												 .paragraphStyle: paragraph,
																												 .foregroundColor: fontColor,
																												 .strokeWidth: -1 as AnyObject,
																												 .strokeColor: UIColor.black]
		let attrString = NSAttributedString(string: dataObject, attributes: attributes)
		dataButton.setAttributedTitle(attrString, for: .normal)
		if let data = UserDefaults.standard.object(forKey: "image") as? Data {
			let image = UIImage(data: data)
			dataButton.setBackgroundImage(image, for: .normal)
		}
	}
	
	@IBAction func selectPhoto(_ sender: UIButton) {
		guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
		
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.sourceType = .camera
		present(picker, animated: true) { }
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		// Local variable inserted by Swift 4.2 migrator.
		let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
		
		guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else { return }
		let data = image.jpegData(compressionQuality: 0.9)
		UserDefaults.standard.set(data, forKey: "image")
		dataButton.setBackgroundImage(image, for: .normal)
		picker.dismiss(animated: true)
	}
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
