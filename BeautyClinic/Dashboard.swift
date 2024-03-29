//
//  Dashboard.swift
//  BeautyClinic
//
//  Created by Arthur on 05/12/16.
//  Copyright © 2016 Matheus Nonaka. All rights reserved.
//

import UIKit

class Dashboard: UIViewController {
    
    @IBOutlet var btnMenu: UIBarButtonItem!
    @IBOutlet var viewMenu: UIViewController!
    
    var cliente: Cliente!
    var list: Array<String> = []
    
    
    @IBAction func funcMenu(sender: AnyObject) {
        print("Apertou menu")
        
    }
    
    @IBAction func funcMensagens(sender: AnyObject) {
        print("Chmando Mensagens")
        let mensagemView = MensagemViewController(nibName: "MensagemViewController", bundle: nil)
        mensagemView.codCliente = "\(cliente.codCliente)"
        self.navigationController!.pushViewController(mensagemView, animated: true)
    }
    
    @IBAction func carrinhoDetalhe(sender: AnyObject) {
//        var list = Array<String>()
//        let dao = CarrinhoDAO()
        
//        list.append("213123;Produto Nome 01;1;500,00")
//        list.append("098765;Produto Nome 02;1;399,00")
        
//        dao.saveProducts(list)
        
        
        let carrinhoStory: UIStoryboard = UIStoryboard(name: "MeuCarrinho", bundle: nil)
        let viewController = carrinhoStory.instantiateViewControllerWithIdentifier("carrinhoControllerID") as! MeuCarrinhoController
        viewController.dashboard = self
        self.navigationController?.pushViewController(viewController, animated: true);

        
//        let carrinhoView = CarrinhoViewController(nibName: "CarrinhoViewController", bundle: nil)
//        self.navigationController!.pushViewController(carrinhoView, animated: true)
    }
    
    @IBAction func funcAgendamentos(sender: AnyObject) {
        let agendaView = AgendaViewController(nibName: "AgendaViewController", bundle: nil)
        agendaView.cliente = self.cliente
        self.navigationController!.pushViewController(agendaView, animated: true)
    }
    
    @IBAction func funcProdutos(sender: AnyObject) {
        let produtoView = ProdutoViewController(nibName: "ProdutoViewController", bundle: nil)
        produtoView.dashboard = self
        self.navigationController!.pushViewController(produtoView, animated: true)
    }
    
    @IBAction func funcBudget(sender: AnyObject) {
        let orcamentoView = OrcamentoViewController(nibName: "OrcamentoViewController", bundle: nil)
        orcamentoView.cliente = self.cliente
        self.navigationController!.pushViewController(orcamentoView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated:true);
        
    }
    
}
