//
//  PrincipalViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/18/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit
import Foundation

class PrincipalViewController: UIViewController, VendaProtocol {
    
    @IBOutlet var btPromocao: UIButton!
    @IBOutlet var btProdutos: UIButton!
    @IBOutlet var btOrcamentos: UIButton!
    @IBOutlet var lbBemVindo: UILabel!
    @IBOutlet var lbMensagens: UILabel!
    @IBOutlet var lbProcedimentos: UILabel!
    var cliente: Cliente!
    var carrinho: Carrinho!

 func color(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    @IBAction func exibeAgendamentos(sender: UIButton) {

        let agendaView = AgendaViewController(nibName: "AgendaViewController", bundle: nil)
        agendaView.codCliente = "\(self.cliente.codCliente)"
        self.navigationController!.pushViewController(agendaView, animated: false)
        
    }
    
    @IBAction func exibeMensagens(sender: UIButton) {
        
        let mensagemView = MensagemViewController(nibName: "MensagemViewController", bundle: nil)
        mensagemView.codCliente = "\(cliente.codCliente)"
        self.navigationController!.pushViewController(mensagemView, animated: false)
        
    }
    
    @IBAction func exibeVendas(sender: UIButton) {
        
        let vendaView = VendaViewController(nibName: "VendaViewController", bundle: nil)
        self.navigationController!.pushViewController(vendaView, animated: true)
        
    }
    
    @IBAction func exibeProdutos(sender: UIButton) {
    
        let produtoView = ProdutoViewController(nibName: "ProdutoViewController", bundle: nil)
        produtoView.delegate = self
        self.navigationController!.pushViewController(produtoView, animated: true)
        for prod: Produto in carrinho.Produtos {
            print(prod.descricao)
        }
        
    }
    
    @IBAction func exibeOrcamentos(sender: UIButton) {
    
        let orcamentoView = OrcamentoViewController(nibName: "OrcamentoViewController", bundle: nil)
        orcamentoView.codCliente = "\(cliente.codCliente)"
        self.navigationController!.pushViewController(orcamentoView, animated: true)
        
    }
    
    @IBAction func exibePromocoes(sender: UIButton) {
        if #available(iOS 8.0, *) {
            Alerta.alerta("Em breve", mensagem: "O serviço de promoções estará disponível em breve",
                          viewController: self)
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func exibeCarrinho(sender: UIButton) {
        
        if (self.carrinho.Produtos.count == 0) {
            if #available(iOS 8.0, *) {
                Alerta.alerta("Atenção", mensagem: "Seu carrinho está vazio. Inclua através dos produtos",
                              viewController: self)
            } else {
                // Fallback on earlier versions
            }
        } else {
        
            let carrinhoView = CarrinhoViewController(nibName: "CarrinhoViewController", bundle: nil)
            carrinhoView.codCliente = cliente.codCliente
            carrinhoView.carrinho = self.carrinho
            self.navigationController!.pushViewController(carrinhoView, animated: true)
        }
    }
    
    @IBAction func agendar(sender: UIButton) {
        let agendarView = AgendarViewController(nibName: "AgendarViewController", bundle: nil)
        agendarView.codCliente = self.cliente.codCliente
        self.navigationController!.pushViewController(agendarView, animated: true)
    }
    
    @IBAction func exitNow(sender: AnyObject) {
        exit(0)
    }
    
    func saveCartForPreviousVC(data: Carrinho) {
        self.carrinho = data
    }
    
    func montaAvisos() {
        if (self.cliente.sexo == "M") {
            self.lbBemVindo.text = " Bem vindo \(cliente.nome)"
        } else if (self.cliente.sexo == "F") {
            self.lbBemVindo.text = " Bem vinda \(cliente.nome)"
        } else {
            self.lbBemVindo.text = " Bem vindo(a) \(cliente.nome)"
        }
        
        if (self.cliente.mensagens == 0) {
            self.lbMensagens.text = " Você não possui mensagens novas"
        } else {
            self.lbMensagens.text = " Você possui \(cliente.mensagens) mensagens"
        }
        
        if (self.cliente.agendamentos == 0) {
            self.lbProcedimentos.text = " Você não possui agendamentos"
        } else {
            self.lbProcedimentos.text = " Você possui \(cliente.agendamentos) agendamentos"
        }
    }
    
    func configuraCores() {
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.backgroundColor =  UIColor.purpleColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.translucent = false;
        self.navigationController!.navigationBar.barTintColor = UIColor.purpleColor()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()

        let font = UIFont(name: "Avenir", size: 22)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: font!]
        self.navigationItem.title = ""
        
    }
    
    func verificaMensagens() {
        
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.montaAvisos()
        self.configuraCores()
        
        self.carrinho = Carrinho()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {

        self.navigationController!.setNavigationBarHidden(true, animated: false)
        
    }

}
