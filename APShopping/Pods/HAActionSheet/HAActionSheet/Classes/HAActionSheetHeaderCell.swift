//
//  HAActionSheetHeaderCell.swift
//  Pods
//
//  Created by Hasan Asan on 22/08/2017.
//
//

import UIKit

class HAActionSheetHeaderCell: UITableViewCell {
  @IBOutlet var titleLabel   : UILabel!
  @IBOutlet var messageLabel : UILabel!
  @IBOutlet var labelContainerView: UIView!
  
  func prepare(title       : String,
               message     : String,
               bgColor     : UIColor,
               textColor   : UIColor,
               titlefont   : UIFont,
               messagefont : UIFont) {
    self.titleLabel.text = title
    self.messageLabel.text = message
    
    self.messageLabel.textColor = textColor
    self.titleLabel.textColor   = textColor
    self.titleLabel.font        = titlefont
    self.messageLabel.font      = messagefont
    self.labelContainerView.backgroundColor = bgColor
  }
}
