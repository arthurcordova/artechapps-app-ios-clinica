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
//        let iconMensagem = UITabBarItem(title: "Mensagens", image: UIImage(named: "envelope.png"), selectedImage: UIImage(named: "envelope.png"))
//        
//        viewMensagem.tabBarItem = iconMensagem
//        viewAgendamento.tabBarItem = iconMensagem
//        viewProduto.tabBarItem = iconMensagem
//        viewOrcamento.tabBarItem = iconMensagem
        
        let controllers = [viewMensagem, viewAgendamento, viewProduto, viewOrcamento]
        self.viewControllers = controllers
    }
    
    //Delegate methods
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title) ?")
        return true;
    }

    

}

