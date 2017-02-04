//
//  Produto.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/30/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation

class Produto: NSObject {
    
    var codigo: Int = 0
    var descricao: String = ""
    var preco: Float = 0.00
    var quantidade: String = "0"
    var tipoExame: String = "T"
    
    override init() {
        super.init()
    }
    
}
