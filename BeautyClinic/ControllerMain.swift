//
//  ControllerMain.swift
//  BeautyClinic
//
//  Created by Arthur Stapassoli on 07/10/16.
//  Copyright © 2016 Matheus Nonaka. All rights reserved.
//

import UIKit

class ControllerMain: UITabBarController, UITabBarControllerDelegate {
 
    var cliente: Cliente!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        

        
        let viewMensagem = MensagemViewController()
        
        let viewAgendamento = AgendaViewController()
        viewAgendamento.cliente = cliente
        
        let viewProduto = ProdutoViewController()
        
        let viewOrcamento = OrcamentoViewController()
        viewOrcamento.cliente = cliente
        
        let viewCarrinho = CarrinhoViewController()
 
        let tabTitle1 = UITabBarItem(title: "Mensagens", image: UIImage(named: "ic_message.png"), tag: 1)
        let tabTitle2 = UITabBarItem(title: "Agendamentos", image: UIImage(named: "ic_event.png"), tag: 2)
        let tabTitle3 = UITabBarItem(title: "Produtos", image: UIImage(named: "ic_local_offer.png"), tag: 3)
        let tabTitle4 = UITabBarItem(title: "Orçamentos", image: UIImage(named: "ic_local_atm.png"), tag: 4)
        let tabTitle5 = UITabBarItem(title: "Carrinho", image: UIImage(named: "ic_shopping_cart.png"), tag: 5)

        viewMensagem.tabBarItem = tabTitle1
        viewAgendamento.tabBarItem = tabTitle2
        viewProduto.tabBarItem = tabTitle3
        viewOrcamento.tabBarItem = tabTitle4
        viewCarrinho.tabBarItem = tabTitle5
        
        self.viewControllers = [viewMensagem, viewAgendamento, viewProduto, viewOrcamento, viewCarrinho]
    }
    
    //Delegate methods
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title) ?")
        return true;
    }

    

}

