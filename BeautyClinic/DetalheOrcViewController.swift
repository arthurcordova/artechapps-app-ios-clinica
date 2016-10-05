//
//  DetalheOrcViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 7/15/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class DetalheOrcViewController: UIViewController, UITableViewDataSource {
    
    var codOrcamento: String = ""
    var produtos: Array<ProdutoOrcamento> = []
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detalhes do Orçamento"
        self.navigationController!.setNavigationBarHidden(false, animated: false)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let xib = UINib(nibName: "ProdOrcamentoCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")


        getProdutos()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return produtos.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! ProdOrcamentoCell
            let linha = indexPath.row
            let produto = self.produtos[linha]
            
            cell.descProd.text = "\(produto.descricao)"
            cell.qtdProd.text = "\(produto.quantidade)"
            cell.vlrProd.text = "R$ \(produto.valorTotal)"
            
            return cell
    }
    
    func getProdutos() {
        DetalheOrcamentoService.getProdutosOrcamento({(produtos: Array<ProdutoOrcamento>, error: NSError!) in
            if (error != nil) {
                if #available(iOS 8.0, *) {
                    Alerta.alerta("Erro", mensagem: "erro", viewController: self)
                } else {
                    // Fallback on earlier versions
                }
            } else {
                self.produtos = produtos
                self.tableView.reloadData()
                
            }
        }, codOrcamento: self.codOrcamento)
    }

    
}
