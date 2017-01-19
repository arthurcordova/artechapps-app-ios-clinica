//
//  ProdutoViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/30/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class ProdutoViewController: UIViewController, UITableViewDataSource {
    
    var produtos: Array<Produto> = []
    var carrinho = Carrinho()
    var delegate: VendaProtocol?
    var isNewAppointment = false
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Produtos"
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.automaticallyAdjustsScrollViewInsets = false;
        
        let xib = UINib(nibName: "ProdutoCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
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
    
    override func viewWillDisappear(animated: Bool) {
        
        delegate?.saveCartForPreviousVC(self.carrinho)
        super.viewWillDisappear(animated)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
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
        
        if (!isNewAppointment){
            var qtdField: UITextField?
            let addAlerta = UIAlertController(title: "Adicionar", message: "Deseja adicionar o item ao carrinho ?", preferredStyle: UIAlertControllerStyle.Alert)
            
            addAlerta.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction!) in
                if (qtdField!.text == "0") {
                    produto.quantidade = "1"
                } else {
                    produto.quantidade = qtdField!.text!
                }
                self.carrinho.adicionarProduto(produto)
            }))
            
            addAlerta.addAction(UIAlertAction(title: "Não", style: .Cancel, handler: nil))
            
            addAlerta.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                textField.text = "1"
                //textField.placeholder = "Informe a quantidade"
                qtdField = textField
            })
            presentViewController(addAlerta, animated: true, completion: nil)
            self.tableView.deselectRowAtIndexPath(indexPath, animated:true)

        } else {
            
            let buscaHorario = HorariosViewController(nibName: "HorariosViewController", bundle: nil)
            self.navigationController!.pushViewController(buscaHorario, animated: true)
            
        }
        
        
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

