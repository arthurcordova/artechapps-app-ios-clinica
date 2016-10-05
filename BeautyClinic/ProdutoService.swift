//
//  ProdutoService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/30/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation

class ProdutoService {
    
    class func parserProdutos(data: NSData) -> Array<Produto> {
        do {
            if (data.length == 0) {
                return []
            }
            
            var produtos: Array<Produto> = []
            let dict: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options:
                NSJSONReadingOptions.MutableContainers) as! NSArray
            
            for obj:AnyObject in dict {
                let dict = obj as! NSDictionary
                let produto = Produto()
                produto.codigo = dict["codProduto"] as! Int
                produto.descricao = dict["descricao"] as! String
                produto.preco = dict["valorProduto"] as! Float
                if (dict["tipoExame"] != nil) {
                    produto.tipoExame = dict["tipoExame"] as! String
                }
                produtos.append(produto)
            }
            
            return produtos
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
            return []
        }
        
    }
    
    class func getProdutos(callback: (produtos: Array<Produto>, error: NSError!) -> Void) {
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/procedimentos/3")!
        let task = http.dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil) {
                callback(produtos:[], error: error)
            } else {
                let produtos = ProdutoService.parserProdutos(data!)
                dispatch_sync(dispatch_get_main_queue(), {
                    callback(produtos:produtos, error: nil)
                })
            }
        })
        task.resume()
        
    }

}