//
//  DetalheOrcamentoService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 7/14/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation

class DetalheOrcamentoService {
    
    class func parserProdutosOrcamento(data: NSData) -> Array<ProdutoOrcamento> {
        
        if (data.length == 0) {
            return []
        }
        
        var produtos: Array<ProdutoOrcamento> = []
        do {
            let dict: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options:
                NSJSONReadingOptions.MutableContainers) as! NSArray
            
            for obj:AnyObject in dict {
                let dict = obj as! NSDictionary
                let produto = ProdutoOrcamento()
                produto.codigo = dict["codProduto"] as! Int
                produto.descricao = dict["descricao"] as! String
                //produto.quantidade = dict["qtd"] as Int
                produto.valorTotal = dict["valorProduto"] as! Float
                produtos.append(produto)
            }
            
            return produtos
        } catch let error as NSError {
            print("erro ao buscar produtos: \(error.localizedDescription)")
            return []
        }
        
    }

    class func getProdutosOrcamento(callback: (produtos: Array<ProdutoOrcamento>, error: NSError!) -> Void, codOrcamento: String) {
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/produtosorcamento/"+codOrcamento)!
        let task = http.dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil) {
                callback(produtos:[], error: error)
            } else {
                let produtos = DetalheOrcamentoService.parserProdutosOrcamento(data!)
                dispatch_sync(dispatch_get_main_queue(), {
                    callback(produtos:produtos, error: nil)
                })
            }
        })
        task.resume()
        
    }
    
    class func exibeProdutos(codOrcamento: String) {
        
        
        
    }
    
}
