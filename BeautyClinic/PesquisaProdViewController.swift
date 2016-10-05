//
//  PesquisaProdViewController.swift
//  
//
//  Created by Matheus Nonaka on 9/15/15.
//
//

import UIKit

class PesquisaProdViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var produtos: Array<Produto> = []
    var delegate: UtilProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Pesquisa de produtos"
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.automaticallyAdjustsScrollViewInsets = false
        
        let xib = UINib(nibName: "ProdutoCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
        getProdutos()
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
            
            cell.descProduto.text = produto.descricao
            cell.precoProduto.text = "R$ \(produto.preco)"
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let linha = indexPath.row
        let produto = self.produtos[linha]
        delegate?.saveProdForPreviousVC(produto)
        self.navigationController!.popViewControllerAnimated(false)
        
    }
    
    func getProdutos() {
        ProdutoService.getProdutos({(produtos: Array<Produto>, error: NSError!) in
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
        })
    }
}
