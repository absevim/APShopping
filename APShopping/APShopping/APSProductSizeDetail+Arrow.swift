//
//  APSProductSizeDetail+Arrow.swift
//  APShopping
//
//  Created by Abdullah  on 04/11/2017.
//  Copyright © 2017 Abdullah Sevim. All rights reserved.
//

import UIKit

import Arrow

struct APSProductSizeDetail {
    var optionId = 0
    var label = ""
    var isInStock = false;
    var simpleProductSkus = ""
}

extension APSProductSizeDetail:ArrowParsable {
    mutating func deserialize(_ json: JSON) {
        optionId <-- json["optionId"]
        label <-- json["label"]
        isInStock <-- json["isInStock"]
        simpleProductSkus <-- json["simpleProductSkus.Optional"]
    }
}
