//
//  CarrinhoDAO.swift
//  BeautyClinic
//
//  Created by Arthur on 04/02/17.
//  Copyright © 2017 Matheus Nonaka. All rights reserved.
//

import Foundation

class CarrinhoDAO {
    
    let productArchive: String
    
    init() {
        let userDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let dir = userDir[0]
        productArchive = "\(dir)/products"
    }
    
    func saveProducts(products: Array<String>) {
        NSKeyedArchiver.archiveRootObject(products, toFile: productArchive)
    }
    
    func loadProducts() -> Array<String> {
        if let loaded =
        NSKeyedUnarchiver.unarchiveObjectWithFile(productArchive){
            return loaded as! Array<String>
        }
        return Array<String>()
    }
    
}
