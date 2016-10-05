//
//  VendaService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/22/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation

class VendaService {
    
    class func getOrcamentos(callback: (orcamentos: Array<Orcamento>, error: NSError!) -> Void, codCliente: String) {
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www2.beautyclinic.com.br/webservice/servidor/vendas/"+codCliente+"//31/12/2015/A")!
        let task = http.dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil) {
                callback(orcamentos:[], error: error)
            } else {
                let orcamentos = OrcamentoService.parserOrcamentos(data!)
                dispatch_sync(dispatch_get_main_queue(), {
                    callback(orcamentos:orcamentos, error: nil)
                })
            }
        })
        task.resume()
        
    }
    
    class func parserVendas(data: NSData) -> Array<Venda> {
        
        do {
            if (data.length == 0) {
                return []
            }
            
            var vendas: Array<Venda> = []
            let dict: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options:
                NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let jsonVendas: NSDictionary = dict["vendas"] as! NSDictionary
            let arrayVendas: NSArray = jsonVendas["venda"] as! NSArray
            
            for obj:AnyObject in arrayVendas {
                let dict = obj as! NSDictionary
                let venda = Venda()
                venda.codVenda = dict["codigo"] as! String
                venda.data = dict["data"] as! String
                venda.status = dict["status"] as! String
                venda.valorAberto = dict["aberto"] as! String
                venda.valorTotal = dict["total"] as! String
                vendas.append(venda)
            }
            
            return vendas
            
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
            return []
        }
        
    }
}