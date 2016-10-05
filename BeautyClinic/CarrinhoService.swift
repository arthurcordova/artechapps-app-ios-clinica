//
//  CarrinhoService.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 10/22/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation

class CarrinhoService {
    
    var codCliente: Int = 0
    
    class func confirmarCarrinho(codCliente: Int, carrinho: Carrinho) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/cadorcamento")!)
        request.HTTPMethod = "POST"
        
        let dataAux = "01/10/2015"
        let params = ["codAngariador":42,
                      "codCliente":codCliente,
                      "codVendedor":42,
                      "status":"P",
                      "valorOrcamento":carrinho.totalizaCarrinho(),
                      "valorDesconto":0,
                      "valorTotal":carrinho.totalizaCarrinho(),
                      "opcad":42,
                      "codFilial":3,
                      "dataOrcamento": dataAux
            ] as Dictionary<String, AnyObject>
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        } catch let error as NSError {
            print("erro ao inicializar json: \(error.localizedDescription)")
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            if(error != nil) {
                print(error!.localizedDescription)
            }
            else {
                if (strData != "0") {
                    
                    let ordem = 0
                    let codOrcamento = strData!.integerValue
                    for prod in carrinho.Produtos {
                        
                        let params2 = ["codProduto":prod.codigo,
                            "duracao":ordem,
                            "valorProduto":prod.preco,
                            "codAngariador":42,
                            "codIndicador":0,
                            "opcad":42
                            ] as Dictionary<String, AnyObject>
                        
                        let request2 = NSMutableURLRequest(URL: NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice/servidor/cadprodorcamento/"+"\(codOrcamento)")!)
                        
                        let session2 = NSURLSession.sharedSession()
                        request2.HTTPMethod = "POST"
                        
                        if (NSJSONSerialization.isValidJSONObject(params2)) {
                            
                            do {
                                request2.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params2, options:[])
                                request2.addValue("application/json", forHTTPHeaderField: "Content-Type")
                                request2.addValue("application/json", forHTTPHeaderField: "Accept")
                            } catch let error as NSError {
                                print("erro ao inicializar json: \(error.localizedDescription)")
                            }
                            
                            let task2 = session2.dataTaskWithRequest(request2, completionHandler: {
                                (data, response, error) -> Void in
                                
                                if(error != nil) {
                                    print(error!.localizedDescription)
                                }
                                else {
                                    print("Produto cadastrado com sucesso")
                                }
                            })
                            task2.resume()
                        }
                    }
                }
                carrinho.Produtos.removeAll(keepCapacity: false)
            }
        }
        task.resume()
    }
    
}