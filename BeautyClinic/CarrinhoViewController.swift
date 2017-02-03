//
//  CarrinhoViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 10/18/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class CarrinhoViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var carrinho = Carrinho()
    var codCliente: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Meu carrinho"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let xib = UINib(nibName: "CarrinhoCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CarrinhoCell
        let row = indexPath.row
        
        let produto = carrinho.Produtos[row]
        
//        cell.descProduto.text = produto.descricao
//        cell.qtdProduto.text = "Quantidade: "+produto.quantidade
//        cell.vlrUnitario.text = "Valor: R$ \(produto.preco)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carrinho.Produtos.count
    }
    
    @available(iOS 8.0, *)
    @IBAction func confirmarCarrinho() {
        
        let confAlerta = UIAlertController(title: "Confirmação", message: "Confirma o orçamento com os produtos do carrinho ?", preferredStyle: UIAlertControllerStyle.Alert)
        
        confAlerta.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction!) in
            CarrinhoService.confirmarCarrinho(self.codCliente, carrinho: self.carrinho)
            //self.carrinho.Produtos.removeAll(keepCapacity: false)
        }))
        
        confAlerta.addAction(UIAlertAction(title: "Não", style: .Cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        presentViewController(confAlerta, animated: true, completion: nil)
        
    }
    
    @available(iOS 8.0, *)
    @IBAction func limparCarrinho() {
        
        let delAlerta = UIAlertController(title: "Confirmação", message: "Deseja realmente limpar o carrinho ?", preferredStyle: UIAlertControllerStyle.Alert)
        
        delAlerta.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction!) in
            self.carrinho.Produtos.removeAll(keepCapacity: false)
        }))
        
        delAlerta.addAction(UIAlertAction(title: "Não", style: .Cancel, handler: { (action: UIAlertAction!) in
            
        }))
    }

}
