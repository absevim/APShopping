//
//  APSMainViewController.swift
//  APShopping
//
//  Created by Abdullah  on 04/11/2017.
//  Copyright © 2017 Abdullah Sevim. All rights reserved.
//

import ws
import then
import Arrow
import Kingfisher
import UIKit

class APSMainViewController: APSBaseViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    private var productArray = [APSProductDetail]()
    private var pageNumber = Int()
    var refreshControl: UIRefreshControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.productArray.count == 0 {
            self.pageNumber = 1
            getProducts("boy",self.pageNumber)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject) {
        // Code to refresh table view
        self.productArray.removeAll()
        tableView.reloadData()
        refreshControl.endRefreshing()
        self.pageNumber = 1
        getProducts("boy", self.pageNumber)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "apsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? APSTableViewCell  else {
            fatalError("The dequeued cell is not an instance of APSTableViewCell.")
        }

        let apsProductDetail = self.productArray[indexPath.row];
        let url = URL(string:urlForProductImages(apsProductDetail))
       // cell.productImageView.kf.setImage(with: url)
        cell.productTitleLabel.text = apsProductDetail.name
        cell.productDetailLabel.text = removeHTMLTagsFromString(textWithTags: (apsProductDetail.description) as String)
        cell.productPriceLabel.text = String("AED \(apsProductDetail.price)")
        
        let lastElement = self.productArray.count - 1
        if indexPath.row == lastElement {
            self.pageNumber += 1
            getProducts("boy",self.pageNumber)
            print("PageNumber is \(self.pageNumber)")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath){
        self.performSegue(withIdentifier: "MainToDetailSegue", sender: self)
    }
    
    func getProducts(_ searchString:String,_ pageNumber:Int) -> Void {
        let urlString = "https://www.mamasandpapas.ae/search/full/?searchString="+searchString+"&page="+String(pageNumber)+"&hitsPerPage=10"
        
        let ws = WS(urlString)
        ws.post("").then { (json:JSON) in
            var apsProduct = APSProduct()
            apsProduct.deserialize(json)
            
            for product in apsProduct.apsProductDetail{
                self.productArray.append(product)
            }
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "MainToDetailSegue" ,
            let vc = segue.destination as? APSDetailViewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedProduct = self.productArray[indexPath.row]
            vc.selectedProduct = selectedProduct
        }
    }

}
