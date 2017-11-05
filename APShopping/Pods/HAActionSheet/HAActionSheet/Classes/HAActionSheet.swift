//
//  HAActionSheet.swift
//  HAActionSheet
//
//  Created by Hasan Asan on 04/08/2017.
//  Copyright © 2017 Hasan Ali Asan. All rights reserved.
//

import UIKit

public class HAActionSheet: UIView {
  @IBOutlet private var view              : UIView!
  @IBOutlet private var listContainerView : UIView!
  @IBOutlet private var cancelButton      : UIButton!
  @IBOutlet private var tableView         : UITableView!
  
  @IBOutlet private var listContainerHeightConst : NSLayoutConstraint!
  @IBOutlet private var listContainerTopConst    : NSLayoutConstraint!
  
  var animatedCells                      = [IndexPath]()
  public var cancelButtonTitle           = "Cancel"
  public var title                       = ""
  public var message                     = ""
  public var buttonCornerRadius: CGFloat = 16.0
  public var titleFont                   = UIFont.systemFont(ofSize: 17)
  public var headerTitleFont             = UIFont.boldSystemFont(ofSize: 17)
  public var headerMessageFont           = UIFont.systemFont(ofSize: 14)
  public var cancelButtonTitleColor      = UIColor.red
  public var cancelButtonBackgroundColor = UIColor.white
  public var buttonTitleColor            = UIColor.blue
  public var headerTextColor             = UIColor.black
  public var headerBackgroundColor       = UIColor.white
  public var buttonBackgroundColor       = UIColor.white
  public var seperatorColor              = UIColor(red: 237.0/255.0,
                                                   green: 237.0/255.0,
                                                   blue: 239.0/255.0,
                                                   alpha: 1)
  
  var sourceData: [String]!
  
  var handler: ((_ canceled: Bool, _ index: Int?) -> Void)? = nil
  
  public init(fromView: UIView, sourceData: [String]) {
    super.init(frame: fromView.frame)
    
    let podBundle = Bundle.init(for: self.classForCoder)
    if let bundleURL = podBundle.url(forResource: "HAActionSheet", withExtension: "bundle") {
      let bundle = Bundle.init(url: bundleURL)
      UINib(nibName: "HAActionSheet", bundle: bundle).instantiate(withOwner: self, options: nil)
      addSubview(view)
      view.frame = self.bounds
      fromView.addSubview(self)
      
      self.sourceData = sourceData
    }else {
      assertionFailure("Could not create a path to the bundle")
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  @IBAction func cancelButtonAction(_ sender: Any) {
    self.handler!(true, nil)
    self.removeView()
  }
  
  public func show(completion: @escaping(_ canceled: Bool, _ index: Int?) -> Void) {
    self.cancelButton.setTitleColor(self.cancelButtonTitleColor, for: .normal)
    self.cancelButton.backgroundColor = self.cancelButtonBackgroundColor
    self.cancelButton.titleLabel?.font = self.titleFont
    self.listContainerView.layer.cornerRadius = self.buttonCornerRadius
    self.cancelButton.layer.cornerRadius = self.buttonCornerRadius
    self.cancelButton.setTitle(self.cancelButtonTitle, for: .normal)
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    self.tableView.reloadData()
    if self.tableView.contentSize.height < self.frame.size.height {
      self.listContainerTopConst.isActive = false
      self.listContainerHeightConst.constant = self.tableView.contentSize.height
    } else {
      self.listContainerHeightConst.constant = self.tableView.frame.size.height
      self.listContainerTopConst.isActive = true
    }
    
    self.listContainerView.transform = CGAffineTransform(translationX: 0,
                                                         y: self.frame.size.height)
    self.cancelButton.transform = CGAffineTransform(translationX: 0,
                                                    y: self.frame.size.height)
    
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.3, animations: {
        self.listContainerView.transform = .identity
      })
      
      UIView.animate(withDuration: 0.4, animations: {
        self.cancelButton.transform = .identity
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
      })
    }
    
    self.handler = completion
  }
  
  func removeView() {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.3, animations: {
        self.cancelButton.transform = CGAffineTransform(translationX: 0, y: self.frame.size.height)
        self.view.backgroundColor = .clear
      })
      
      UIView.animate(withDuration: 0.4, animations: {
        self.listContainerView.transform = CGAffineTransform(translationX: 0, y: self.frame.size.height)
      }, completion: { (_) in
        self.removeFromSuperview()
      })
    }
  }
}

extension HAActionSheet: UITableViewDataSource {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView,
                        numberOfRowsInSection section: Int) -> Int {
    return self.sourceData.count
  }
  
  public func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HAActionSheetCell
    if cell == nil {
      let podBundle = Bundle.init(for: self.classForCoder)
      if let bundleURL = podBundle.url(forResource: "HAActionSheet", withExtension: "bundle") {
        let bundle = Bundle.init(url: bundleURL)
        cell = UINib(nibName: "HAActionSheetCell", bundle: bundle).instantiate(withOwner: self,
                                                                               options: nil)[0] as? HAActionSheetCell
      }
    }
    
    cell?.prepare(title: self.sourceData[indexPath.row],
                  titleColor: self.buttonTitleColor,
                  bgColor: self.buttonBackgroundColor,
                  seperatorColor: self.seperatorColor,
                  font: self.titleFont)
    return cell!
  }
}

extension HAActionSheet: UITableViewDelegate {
  public func tableView(_ tableView: UITableView,
                        heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  public func tableView(_ tableView: UITableView,
                        estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  public func tableView(_ tableView: UITableView,
                        didSelectRowAt indexPath: IndexPath) {
    self.handler!(false, indexPath.row)
    self.removeView()
  }
  
  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if self.title == "" && self.message == "" {
      return nil
    }
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as? HAActionSheetHeaderCell
    if cell == nil {
      let podBundle = Bundle.init(for: self.classForCoder)
      if let bundleURL = podBundle.url(forResource: "HAActionSheet", withExtension: "bundle") {
        let bundle = Bundle.init(url: bundleURL)
        cell = UINib(nibName: "HAActionSheetHeaderCell", bundle: bundle).instantiate(withOwner: self,
                                                                                     options: nil)[0] as? HAActionSheetHeaderCell
        cell?.prepare(title: self.title,
                      message: self.message,
                      bgColor: self.headerBackgroundColor,
                      textColor: self.headerTextColor,
                      titlefont: self.headerTitleFont,
                      messagefont: self.headerMessageFont)
        return cell
      }
    }
    return nil
  }
  
  public func tableView(_ tableView: UITableView,
                        heightForHeaderInSection section: Int) -> CGFloat {
    if self.title == "" && self.message == "" {
      return 0
    }
    
    return 90
  }
}
