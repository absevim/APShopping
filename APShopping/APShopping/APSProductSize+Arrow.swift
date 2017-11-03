//
//  APSProductSize+Arrow.swift
//  APShopping
//
//  Created by Abdullah  on 04/11/2017.
//  Copyright © 2017 Abdullah Sevim. All rights reserved.
//

import Arrow

struct APSProductSize {
    var apsProductSizeDetail = [APSProductSizeDetail]()
}

extension APSProductSize:ArrowParsable {
    mutating func deserialize(_ json: JSON) {
        apsProductSizeDetail <-- json["options"]
    }
}
