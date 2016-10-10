//
//  ControllerMain.swift
//  BeautyClinic
//
//  Created by Arthur Stapassoli on 07/10/16.
//  Copyright © 2016 Matheus Nonaka. All rights reserved.
//

import UIKit

class ControllerMain: UITabBarController, UITabBarControllerDelegate {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let viewMensagem = MensagemViewController()
        let viewAgendamento = AgendaViewController()
        let viewProduto = ProdutoViewController()
        let viewOrcamento = OrcamentoViewController()
// 
        let tabTitle1 = UITabBarItem(title: "Mensagens", image: UIImage(named: ""), tag: 1)
        let tabTitle2 = UITabBarItem(title: "Agendamentos", image: UIImage(named: ""), tag: 2)
        let tabTitle3 = UITabBarItem(title: "Produtos", image: UIImage(named: ""), tag: 3)
        let tabTitle4 = UITabBarItem(title: "Orçamentos", image: UIImage(named: ""), tag: 4)
//
        viewMensagem.tabBarItem = tabTitle1
        viewAgendamento.tabBarItem = tabTitle2
        viewProduto.tabBarItem = tabTitle3
        viewOrcamento.tabBarItem = tabTitle4
        
        let controllers = [viewMensagem, viewAgendamento, viewProduto, viewOrcamento]
        self.viewControllers = controllers
    }
    
    //Delegate methods
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title) ?")
        return true;
    }

    

}

