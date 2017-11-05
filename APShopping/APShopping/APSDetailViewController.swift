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

class APSDetailViewController: APSBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    var selectedProduct : APSProductDetail?
    var selectedProductSizesArray = [APSProductSize]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedProductSizesArray = (self.selectedProduct?.apsProductSize)!
        self.selectedProductTitleLabel.text = selectedProduct?.name
        let selectedProductSize =  String(describing:selectedProduct?.price ?? 0)
        self.selectedProductPriceLabel.text = selectedProductSize + " AED"
        self.productDescriptionLabel.text = "Description:\n" + (self.selectedProduct?.description)!
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
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.selectedProductSizesArray.count
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "apsCollectionViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? APSCollectionViewCell  else {
            fatalError("The dequeued cell is not an instance of APSTableViewCell.")
        }
        var imageString = self.selectedProduct!.image
        
        if imageString != nil {
            let urlString = "https://prod4.atgcdn.ae/small_light(p=zoom,of=undefined)/pub/media/catalog/product\(String(describing: imageString))"
            let url = URL(string:urlString)
            cell.collectionImageView.kf.setImage(with: url)
        }
        return cell
    }

    @IBAction func isBackButtonPressed(_ sender: Any) {
    }

}
