//
//  APSDetailViewController.swift
//  APShopping
//
//  Created by Abdullah  on 04/11/2017.
//  Copyright © 2017 Abdullah Sevim. All rights reserved.
//

import UIKit
import PureLayout
import Kingfisher
import HAActionSheet

class APSDetailViewController: APSBaseViewController, UIScrollViewDelegate, UIAlertViewDelegate {
    var selectedProduct : APSProductDetail?
    var selectedProductSizesArray = NSArray()
    var isInStockBool = Bool()
    private var productCount = Int ()
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var selectedProductImageView: UIImageView!
    @IBOutlet weak var selectedProductTitleLabel: UILabel!
    @IBOutlet weak var selectedProductPriceLabel: UILabel!
    @IBOutlet weak var selectedProductSizeLabel: UILabel!
    @IBOutlet weak var selectedProductSizeButton: UIButton!
    @IBOutlet weak var addToCardButton: UIButton!
    @IBOutlet weak var productSkuLabel: UILabel!
    @IBOutlet weak var productDescriptionScrollView: UIScrollView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productCountTextField: UITextField!
    @IBOutlet weak var productDescriptionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedProductTitleLabel.text = selectedProduct?.name
        let selectedProductSize =  String(describing:selectedProduct?.price ?? 0)
        self.selectedProductSizeButton.setTitle(self.selectedProduct?.sizeCode, for:.normal)
        self.isInStockBool = (self.selectedProduct?.isInStock)!
        self.checkStock(stock: (self.selectedProduct?.isInStock)!)
        self.selectedProductPriceLabel.text = "AED "+selectedProductSize
        self.productDescriptionLabel.text = "Description:\n" + (removeHTMLTagsFromString(textWithTags: (self.selectedProduct?.description)!))
        productCount = 1
        self.productSkuLabel.text = "Id:\(removeOptionalFromInt((self.selectedProduct?.visibleSku)!))"
        self.productCountTextField.text = String(productCount)
        let url = URL(string:urlForProductImages(self.selectedProduct!))
        self.selectedProductImageView.kf.setImage(with: url)
        self.productDescriptionView.layer.borderWidth = 0.5;
        self.productDescriptionView.layer.cornerRadius = 7.0;
        self.productDescriptionView.layer.borderColor = UIColor.black.cgColor
        self.selectedProductSizeButton.layer.borderWidth = 0.5;
        self.selectedProductSizeButton.layer.cornerRadius = 7.0;
        self.selectedProductSizeButton.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        productDescriptionScrollView.contentSize = CGSize(width: productDescriptionLabel.frame.size.width, height: productDescriptionLabel.frame.size.height + 20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func isBackButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func selectProductSize(_ sender: Any) {
        
        if self.selectedProduct?.sizeCode == "One Size"{
            self.selectedProductSizeButton.setTitle("One Size", for:.normal)
        }else{
            let alert = UIAlertController(title: nil, message: "Sizes", preferredStyle: .actionSheet)
            
            let productSizeArray = self.selectedProduct?.apsProductSize[0]
            for productSize in (productSizeArray?.apsProductSizeDetail)!{
                
                let sizeAction = UIAlertAction(title: productSize.label, style: .default, handler:
                {
                    (alert: UIAlertAction!) -> Void in
                    self.selectedProductSizeButton.setTitle(productSize.label, for:.normal)
                    self.isInStockBool = productSize.isInStock
                    self.productSkuLabel.text = "Id:\(productSize.simpleProductSkus)"
                    self.checkStock(stock: productSize.isInStock)
                })
                alert.addAction(sizeAction)
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func increasedProductCountButtonIsPressed(_ sender: Any) {
        if self.productCount < Int((self.selectedProduct?.productStock)!) && self.isInStockBool == true {
            self.productCount += 1
            self.productCountTextField.text = String(self.productCount)
        }
    }
    
    @IBAction func decreasedProductCountButtonIsPressed(_ sender: Any) {
        if self.productCount > 1 {
            self.productCount -= 1
            self.productCountTextField.text = String(self.productCount)
        }
    }
    
    @IBAction func addToCardButtonDidPressed(_ sender: Any) {
        self.alertView(title: "APShopping", message: "Added your product successfully")
    }
    
    func checkStock(stock:Bool) -> Void {
        if stock == false {
            self.addToCardButton.isEnabled = false
        }
    }
}
