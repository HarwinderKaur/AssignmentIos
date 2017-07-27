//
//  Model.swift
//  PracticeFirebase
//
//  Created by Ramandeep Singh on 2017-07-20.
//  Copyright © 2017 Ramandeep Singh. All rights reserved.
//

import Foundation



public class DataModel{
    var id: String = "", itemName: String = "",itemType: String = "",itemQuantity = "", itemPrice = "", itemImageUrl = ""
    
    init(id: String, itemName: String,itemType: String,itemQuantity: String,itemPrice: String,itemImageUrl: String) {
        self.id = id
        self.itemName = itemName
        self.itemType = itemType
        self.itemQuantity = itemQuantity
        self.itemPrice = itemPrice
        self.itemImageUrl = itemImageUrl
        
        
        
    }
    
    func getId() -> String {
        return id
    }
    
    func setId(id: String)  {
        self.id = id
    }
    func getItemName() -> String {
        return itemName
    }
    
    func setItemName(itemName: String)  {
        self.itemName = itemName
    }
    func getItemType() -> String {
        return itemType
    }
    
    func setItemType(itemType: String)  {
        self.itemType = itemType
    }
    func getItemQuantity() -> String {
        return itemQuantity
    }
    
    func setItemQuantity(itemQuantity: String)  {
        self.itemQuantity = itemQuantity
    }

    func getItePrice() -> String {
        return itemPrice
    }
    
    func setItemPrice(itemPrice: String)  {
        self.itemPrice = itemPrice
    }

    func getItemImage() -> String {
        return itemImageUrl
    }
    
    func setItemImage(itemImageUrl: String)  {
        self.itemImageUrl = itemImageUrl
    }

        
    
}
