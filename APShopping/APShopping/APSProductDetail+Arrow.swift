//
//  APSProductDetail+Arrow.swift
//  APShopping
//
//  Created by Abdullah  on 04/11/2017.
//  Copyright © 2017 Abdullah Sevim. All rights reserved.
//

import Arrow

struct APSProductDetail {
    var productId = 0
    var sku = 0
    var visibleSku = 0
    var name = ""
    var description = ""
    var image = ""
    var smallImage = ""
    var thumbnail = ""
    var price = 0
    var specialPrice = 0
    var discounted = ""
    var discountPercent = 0
    var productStock = 0
    var apsProductSize = [APSProductSize]()
}

extension APSProductDetail:ArrowParsable {
    mutating func deserialize(_ json: JSON) {
        productId <-- json["productId"]
        sku <-- json["sku"]
        visibleSku <-- json["visibleSku"]
        name <-- json["name"]
        description <-- json["description"]
        image <-- json["image"]
        smallImage <-- json["smallImage"]
        thumbnail <-- json["thumbnail"]
        price <-- json["price"]
        specialPrice <-- json["specialPrice"]
        discounted <-- json["discounted"]
        discountPercent <-- json["discountPercent"]
        productStock <-- json["stockOfAllOptions.maxAvailableQty"]
        apsProductSize <-- json["configurableAttributes"]
    }
}
