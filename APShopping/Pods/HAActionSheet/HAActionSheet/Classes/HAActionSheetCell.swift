//
//  HAActionSheetCell.swift
//  HAActionSheet
//
//  Created by Hasan Asan on 04/08/2017.
//  Copyright © 2017 Hasan Ali Asan. All rights reserved.
//

import UIKit

class HAActionSheetCell: UITableViewCell {
  @IBOutlet var titleLabel    : UILabel!
  @IBOutlet var seperatorView : UIView!
  
  func prepare(title          : String,
               titleColor     : UIColor,
               bgColor        : UIColor,
               seperatorColor : UIColor,
               font           : UIFont) {
    self.titleLabel.text = title
    
    self.titleLabel.textColor          = titleColor
    self.titleLabel.backgroundColor    = bgColor
    self.titleLabel.font               = font
    self.seperatorView.backgroundColor = seperatorColor
  }
}
