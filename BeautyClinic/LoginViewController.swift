//
//  LoginViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/15/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var agendamentos: Array<Agendamento> = []
    
    @IBOutlet var tfLogin: UITextField!
    @IBOutlet var tfSenha: UITextField!
    @IBOutlet var btnEntrar: UIButton!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnCadastrar: UIButton!
    
    @IBAction func fazerLogin(sender: UIButton) {
        
        //progress.startAnimating()
        btnLogin.hidden = true
        
        var cpfCnpjAux = self.tfLogin.text!.stringByReplacingOccurrencesOfString(".", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

        cpfCnpjAux = cpfCnpjAux.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

        
        LoginService.doLogin({(cliente: Cliente) in
            if (cliente.nome == "Erro") {
                dispatch_sync(dispatch_get_main_queue(), {
                    //self.progress.stopAnimating()
                    if #available(iOS 8.0, *) {
                        Alerta.alerta("Falha no acesso", mensagem: "Verifique seus dados de login e tente novamente", viewController: self)
                        self.btnLogin.hidden = false
                    } else {
                        // Fallback on earlier versions
                    }
                })
            } else {
                dispatch_sync(dispatch_get_main_queue(), {
                    //self.progress.stopAnimating()
                    /* VOLTAR PARA VERSAO PRODUCAO
                    let principalViewController = ControllerMain(nibName: "PrincipalView",
                        bundle: nil)
                    principalViewController.cliente = Cliente()
                    principalViewController.cliente = cliente
                    self.navigationController!.pushViewController(principalViewController, animated: false)
 */
                    let dash = Dashboard(nibName: "Dashboard",
                        bundle: nil)
                    self.navigationController!.pushViewController(dash, animated: false)
                    
                })
            }
            }, cpfCnpj: cpfCnpjAux, senha: self.tfSenha.text!)
    }
    
    @IBAction func cadastrar(sender: UIButton) {
        let cadUsuarioViewController = CadUsuarioViewController(nibName: "CadUsuarioViewController", bundle: nil)
        self.navigationController!.pushViewController(cadUsuarioViewController, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfLogin.delegate = self
        self.tfSenha.delegate = self
        
        btnEntrar.layer.cornerRadius = 5;
        
        
        var codigo = 0
        let defaults = NSUserDefaults.standardUserDefaults()
        codigo = defaults.integerForKey("codigo")
        if (codigo > 0){
            let principalViewController = ControllerMain(nibName: "PrincipalView",
                                                         bundle: nil)
            let cliente: Cliente = Cliente()
            cliente.codCliente = codigo
            cliente.nome = defaults.objectForKey("nome") as! String
            
            principalViewController.cliente = Cliente()
            principalViewController.cliente = cliente
            self.navigationController!.pushViewController(principalViewController, animated: false)
        }
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == tfLogin) {
            //strSenha.becomeFirstResponder()
            textField.resignFirstResponder()
            return true
        } else if (textField == tfSenha) {
            self.fazerLogin(btnLogin!)
            return true
        }
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (textField == tfLogin) {
            
            let strCpf = textField.text!.stringByReplacingOccurrencesOfString(".", withString: "", options:NSStringCompareOptions.LiteralSearch, range: nil)
            
            if (textField.text!.isEmpty) {
                return true
            }
            
            switch strCpf.characters.count {
            case 3,6:
                if (string != "") && (!textField.text!.hasSuffix(".")) {
                    textField.text = textField.text!+"."
                }
                return true
            case 9:
                if (string != "") && (!textField.text!.hasSuffix("-")){
                    textField.text = textField.text!+"-"
                }
                return true
            case 12:
                if (string != "") {
                    return false
                } else {
                    return true
                }
                
            default: true
            }
            return true
        } else {
            return true
        }
    }
    
    func doneCPFAction()
    {
        self.tfLogin.resignFirstResponder()
    }
    
    func doneSenhaAction() {
        if (self.tfLogin.text?.characters.count > 0) {
            self.fazerLogin(btnLogin)
        } else {
            self.tfSenha.resignFirstResponder()
            //self.strCpf.becomeFirstResponder()
            if #available(iOS 8.0, *) {
                Alerta.alerta("Atenção", mensagem: "Informe o CPF do usuário.", viewController: self)
            }
        }
    }
    
    func cancelAction() {
        self.tfLogin.resignFirstResponder()
        self.tfSenha.resignFirstResponder()
    }
}
