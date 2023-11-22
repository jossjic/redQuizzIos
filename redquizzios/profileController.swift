//
//  ViewController.swift
//  redquizzios
//
//  Created by Administrador on 19/10/23.
//

import UIKit

import Firebase

class profileController: UIViewController {
    @IBOutlet weak var profileImg: UIImageView!
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var vidas: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    var vidasUsu = 0
   let userViewModel = UserViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel.fetchData {
            let userI = self.userViewModel.fetchedUser
            self.name.text = userI.nombre + " " + userI.apellidos
            self.vidas.text = String(userI.vidas) + " Vidas"
            self.vidasUsu = userI.vidas
            print(userI)
        }
       


        

    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        profileImg.round()
        }

    @IBAction func playBtn(_ sender: Any) {
        if vidasUsu <= 0{
            let alertController = UIAlertController(title: "Te quedaste sin vidas", message: "Espera un tiempo para volver a jugar :)", preferredStyle: .alert)
            
            // Agregar acciones (botones) a la alerta
            let okAction = UIAlertAction(title: "Inicio", style: .default) { _ in
                // Código a ejecutar cuando se presiona el botón OK
                print("Botón OK presionado")
                
            }
            alertController.addAction(okAction)
            
            // Mostrar la alerta
            self.present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "playSegue", sender: self)
        }
    }
    
    @IBAction func scoreBtn(_ sender: Any) {
        userViewModel.fetchCT {
            if self.userViewModel.conteoC <= 0 && self.userViewModel.conteoT <= 0 {
               let alertController = UIAlertController(title: "Cargando...", message: "Por favor juega al menos una vez para ver tu puntaje", preferredStyle: .alert)
               
               // Agregar acciones (botones) a la alerta
               let okAction = UIAlertAction(title: "Inicio", style: .default) { _ in
                   // Código a ejecutar cuando se presiona el botón OK
                   print("Botón OK presionado")
                   
               }
               alertController.addAction(okAction)
               
               // Mostrar la alerta
               self.present(alertController, animated: true, completion: nil)
           } else {
               self.performSegue(withIdentifier: "scoreSegue", sender: self)
           }
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            // Cierre de sesión exitoso
            performSegue(withIdentifier: "logOutSegue1", sender: self)
        } catch let signOutError as NSError {
            print("Error al cerrar sesión: \(signOutError)")
        }
    }
    
    
}





