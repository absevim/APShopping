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
import UIKit

class APSMainViewController: APSBaseViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    private var productArray = [APSProductDetail]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProducts("boy")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        cell.productTitleLabel.text = apsProductDetail.name
        cell.productDetailLabel.text = apsProductDetail.description
        cell.productPriceLabel.text = String(apsProductDetail.price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath){
        self.performSegue(withIdentifier: "MainToDetailSegue", sender: self)
    }
    
    func getProducts(_ searchString:String) -> Void {
        let urlString = "https://www.mamasandpapas.ae/search/full/?searchString="+searchString+"&page=1&hitsPerPage=10"
        
        let ws = WS(urlString)
        ws.post("").then { (json:JSON) in
            var apsProduct = APSProduct()
            apsProduct.deserialize(json)
            
            self.productArray = apsProduct.apsProductDetail;
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
