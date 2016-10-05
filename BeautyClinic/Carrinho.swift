//
//  Carrinho.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 10/17/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class Carrinho {
        
    var Produtos: Array<Produto> = []
    
    init() {
        
    }
    
    func adicionarProduto(produto: Produto) -> Void {
        self.Produtos.append(produto)
    }
        
    func removerProduto(posicao: Int) -> Void {
        self.Produtos.removeAtIndex(posicao)
    }
    
    func totalizaCarrinho() -> Float {
        
        var totalCarrinho: Float = 0.0
        for prod in self.Produtos {
            totalCarrinho += prod.preco
        }
        return totalCarrinho
    }
    
}
