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

class APSDetailViewController: APSBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UIAlertViewDelegate {
    var selectedProduct : APSProductDetail?
    var selectedProductSizesArray = NSArray()
    private var productCount = Int ()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectedProductTitleLabel: UILabel!
    @IBOutlet weak var selectedProductPriceLabel: UILabel!
    @IBOutlet weak var selectedProductSizeLabel: UILabel!
    @IBOutlet weak var selectedProductSizeButton: UIButton!
    @IBOutlet weak var addToCardButton: UIButton!
    @IBOutlet weak var productSkuLabel: UILabel!
    @IBOutlet weak var productDescriptionScrollView: UIScrollView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productCountTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedProductTitleLabel.text = selectedProduct?.name
        let selectedProductSize =  String(describing:selectedProduct?.price ?? 0)
        self.selectedProductSizeButton.setTitle(self.selectedProduct?.sizeCode, for:.normal)
        if !(self.selectedProduct?.isInStock)! {
            self.selectedProductSizeButton.isEnabled = false
        }
        self.selectedProductPriceLabel.text = selectedProductSize + " AED"
        self.productDescriptionLabel.text = "Description:\n" + (removeHTMLTagsFromString(textWithTags: (self.selectedProduct?.description)!))
        productCount = 1
        self.productSkuLabel.text = "Id:\(removeOptionalFromInt((self.selectedProduct?.visibleSku)!))"
        self.productCountTextField.text = String(productCount)
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        productDescriptionScrollView.contentSize = CGSize(width: productDescriptionLabel.frame.size.width, height: productDescriptionLabel.frame.size.height + 20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.selectedProductSizesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "apsCollectionViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? APSCollectionViewCell  else {
            fatalError("The dequeued cell is not an instance of APSTableViewCell.")
        }

        let url = URL(string:urlForProductImages(self.selectedProduct!))
        cell.collectionImageView.kf.setImage(with: url)
        return cell
    }

    @IBAction func isBackButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func selectProductSize(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Sizes", preferredStyle: .actionSheet)
        
        let productSizeArray = self.selectedProduct?.apsProductSize[0]
        for productSize in (productSizeArray?.apsProductSizeDetail)!{

            let sizeAction = UIAlertAction(title: productSize.label, style: .default, handler:
            {
                (alert: UIAlertAction!) -> Void in
                self.selectedProductSizeButton.setTitle(productSize.label, for:.normal)
            })
            alert.addAction(sizeAction)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func increasedProductCountButtonIsPressed(_ sender: Any) {
        if self.productCount < Int((self.selectedProduct?.productStock)!) {
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
}
