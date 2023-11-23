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
    
    var timer: Timer?
    var timerFollow: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("User Home")
        userViewModel.fetchData {
            let userI = self.userViewModel.fetchedUser
            self.name.text = userI.nombre + " " + userI.apellidos
            self.vidas.text = String(userI.vidas) + " Vidas"
            self.vidasUsu = userI.vidas
            
            print(userI)
            self.startTimer()
            if userI.genero == "Masculino" {
                self.profileImg.image = UIImage(named: "placeHombre")
            } else if userI.genero == "Femenino" {
                self.profileImg.image = UIImage(named: "placeMujer")
            } else {
                print("genero no identificado")
            }
            

        }
        
       


        

    }
    

    
    @objc func followLifes() {
            if let nextFireDate = self.timer?.fireDate {
                // Calcular el tiempo restante hasta la próxima ejecución
                let tiempoRestante = nextFireDate.timeIntervalSince(Date())
                
                // Convertir el tiempo restante a minutos y segundos
                let minutos = Int(tiempoRestante) / 60
                let segundos = Int(tiempoRestante) % 60
                
                // Formatear y mostrar el tiempo restante
                let tiempoFormateado = String(format: "%02d:%02d", minutos, segundos)
                print("Tiempo restante hasta la próxima ejecución: \(tiempoFormateado)")
                
                // Asignar el tiempo formateado al texto, asegurándote de que se ejecute en el hilo principal
                DispatchQueue.main.async {
                    if self.vidasUsu < 5{
                        self.time.text = tiempoFormateado
                    } else {
                        self.time.text = "Máx Vidas"
                    }
                    
                }
            }
        }
    
    
    @objc func giveLife() {
           // Incrementa las vidas y actualiza la interfaz de usuario
           vidasUsu += 1
        if vidasUsu <= 5 {
            vidas.text = "\(vidasUsu) Vidas"
         print("vida añadida")
            
            // También puedes almacenar el nuevo número de vidas en Firebase si es necesario
         userViewModel.updateLives(newLives: vidasUsu)
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
            let defaults = UserDefaults.standard
            if defaults.value(forKey: "uid") is String{
                UserDefaults.standard.removeObject(forKey: "uid")
                UserDefaults.standard.synchronize()
            }
            try Auth.auth().signOut()
            // Cierre de sesión exitoso
            performSegue(withIdentifier: "logOutSegue1", sender: self)
        } catch let signOutError as NSError {
            print("Error al cerrar sesión: \(signOutError)")
        }
        
        
    }
    
    func startTimer() {
            // Programa un temporizador que se ejecutará cada 5 minutos
            timer = Timer.scheduledTimer(timeInterval: 360, target: self, selector: #selector(giveLife), userInfo: nil, repeats: true)
            timerFollow = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(followLifes), userInfo: nil, repeats: true)
        }
    
    deinit{
        timer?.invalidate()
        timerFollow?.invalidate()
    }
    
    
}





