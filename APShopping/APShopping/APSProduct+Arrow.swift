//
//  APSProduct+Arrow.swift
//  APShopping
//
//  Created by Abdullah  on 04/11/2017.
//  Copyright © 2017 Abdullah Sevim. All rights reserved.
//

import UIKit

import Arrow

struct APSProduct {
    var apsProductDetail = [APSProductDetail]()
}

extension APSProduct:ArrowParsable {
    mutating func deserialize(_ json: JSON) {
        apsProductDetail <-- json["hits"]
    }
}
