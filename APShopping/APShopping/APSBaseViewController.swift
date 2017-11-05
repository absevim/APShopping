//
//  APSBaseViewController.swift
//  APShopping
//
//  Created by Abdullah  on 04/11/2017.
//  Copyright © 2017 Abdullah Sevim. All rights reserved.
//

import UIKit

class APSBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func urlForProductImages(_ selectedProduct:APSProductDetail) -> String {
        let imageString = selectedProduct.image
        var urlString = String()
        if imageString != nil {
            urlString = "https://prod4.atgcdn.ae/small_light(p=zoom,of=undefined)/pub/media/catalog/product\(String(describing: imageString))"
        }
        return urlString
    }
    
    func removeOptionalFromInt(_ intWithOptional:Int) -> String {
        var intWithoutOptional = Int()
        if intWithOptional != nil {
            intWithoutOptional = intWithOptional
        }
        return String(intWithOptional)
    }
    
    func removeHTMLTagsFromString (textWithTags:String) -> String {
        var textWithOutTags = String()
        
        textWithOutTags = textWithTags.replacingOccurrences(of: "<li>", with: "")
        textWithOutTags = textWithOutTags.replacingOccurrences(of: "</li>", with: "")
        textWithOutTags = textWithOutTags.replacingOccurrences(of: "<br />", with: "")
        textWithOutTags = textWithOutTags.replacingOccurrences(of: "</strong>", with: "")
        textWithOutTags = textWithOutTags.replacingOccurrences(of: "<strong>", with: "")
        textWithOutTags = textWithOutTags.replacingOccurrences(of: "<ul>", with: "")
        textWithOutTags = textWithOutTags.replacingOccurrences(of: "</ul>", with: "")
        textWithOutTags = textWithOutTags.replacingOccurrences(of: "<p>", with: "")
        textWithOutTags = textWithOutTags.replacingOccurrences(of: "</p>", with: "")
        return textWithOutTags
    }
    
    func alertView(title:String, message:String) -> Void {
        let alert = UIAlertController(title: "APShopping", message: "Added your product succesfully", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
