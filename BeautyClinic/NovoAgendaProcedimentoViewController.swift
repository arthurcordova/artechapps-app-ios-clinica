//
//  NovoAgendaProcedimentoViewController.swift
//  BeautyClinic
//
//  Created by Arthur on 18/01/17.
//  Copyright © 2017 Matheus Nonaka. All rights reserved.
//

import UIKit

class NovoAgendaProcedimentoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var produtos: Array<Produto> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.automaticallyAdjustsScrollViewInsets = false;
        
        let xib = UINib(nibName: "ProdutoCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self

        
        if #available(iOS 8.0, *) {
            getProdutos()
        } else {
            // Fallback on earlier versions
        }
        
        

       

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
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! ProdutoCell
            let linha = indexPath.row
            let produto = self.produtos[linha]
            
            let price:NSNumber = produto.preco
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            formatter.locale = NSLocale(localeIdentifier: "pt_BR")
            
            cell.descProduto.text = produto.descricao
            cell.precoProduto.text = formatter.stringFromNumber(price);
            //cell.precoProduto.text = "R$ \(produto.preco)"
            
            return cell
    }
    
    @available(iOS 8, *)
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let linha = indexPath.row
        let produto = self.produtos[linha]
        
        var qtdField: UITextField?
        let addAlerta = UIAlertController(title: "Adicionar", message: "Deseja adicionar o item ao carrinho ?", preferredStyle: UIAlertControllerStyle.Alert)
        
        addAlerta.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction!) in
            if (qtdField!.text == "0") {
                produto.quantidade = "1"
            } else {
                produto.quantidade = qtdField!.text!
            }
            //self.carrinho.adicionarProduto(produto)
        }))
        
        addAlerta.addAction(UIAlertAction(title: "Não", style: .Cancel, handler: nil))
        
        addAlerta.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.text = "1"
            //textField.placeholder = "Informe a quantidade"
            qtdField = textField
        })
        
        presentViewController(addAlerta, animated: true, completion: nil)
        self.tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
    @available (iOS 8.0, *)
    func getProdutos() {
        ProdutoService.getProdutos({(produtos: Array<Produto>, error: NSError!) in
            if (error != nil) {
                Alerta.alerta("Erro", mensagem: "erro", viewController: self)
            } else {
                self.produtos = produtos
                self.tableView.reloadData()
                
            }
        })
    }
}
