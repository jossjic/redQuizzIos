import UIKit
import Firebase


extension UIViewController {
    func agregarGestorDeTapParaOcultarTeclado() {
        // Registrar notificaciones del teclado
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoSeMostrara(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoSeOcultara(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Agregar un gestor de toques para ocultar el teclado al tocar fuera
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapFueraDelTeclado))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func tecladoSeMostrara(_ notification: Notification) {
        // Puedes realizar acciones adicionales cuando el teclado se muestra
    }

    @objc func tecladoSeOcultara(_ notification: Notification) {
        // Puedes realizar acciones adicionales cuando el teclado se oculta
    }

    @objc func tapFueraDelTeclado() {
        // Ocultar el teclado
        view.endEditing(true)
    }

   
}


class loginController: UIViewController, UITextFieldDelegate{
    
    deinit {
        // Liberar notificaciones
        NotificationCenter.default.removeObserver(self)
    }
   
    
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    let userViewModel = UserViewModel()
    let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agregarGestorDeTapParaOcultarTeclado()
        let defaults = UserDefaults.standard
        if defaults.value(forKey: "uid") is String{
            userViewModel.fetchData {
                let userType = self.userViewModel.tipo
                print(userType)
                if userType == "usuario" {
                    self.performSegue(withIdentifier: "loginSegueUser", sender: self)
                } else if userType == "administrador" {
                    self.performSegue(withIdentifier: "loginSegueAdmin", sender: self)
                } else {
                    print("tipo de usuario incorrecto")
                }
            }
        }

    }
    
   

    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let email = email.text, let password = pass.text else {
            displayWarning(message: "Por favor, completa todos los campos.")
            return
        }
        
        if email.isEmpty || password.isEmpty {
            displayWarning(message: "Por favor, completa todos los campos.")
            return
        }
        
        if !matchRegex(pattern: emailPattern, input: email) {
            displayWarning(message: "Correo electrónico inválido.")
            return
        }
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
                guard let self = self else { return }
                
                if let error = error {
                    self.displayWarning(message: "Correo y/o contraseña incorrectos.")
                    print("Error al iniciar sesiónA: \(error.localizedDescription)")
                    return
                }
                
                print("Inicio de sesión exitoso.")
                if let currentUser = Auth.auth().currentUser{
                    let defaults = UserDefaults.standard
                    defaults.set(currentUser.uid, forKey: "uid")
                    defaults.synchronize()
                }
                
                
                // Aquí puedes realizar acciones adicionales después del inicio de sesión exitoso
                // Por ejemplo, navegar a la siguiente vista
                userViewModel.fetchData {
                    let userType = self.userViewModel.tipo
                    print(userType)
                    if let user = Auth.auth().currentUser {
                        if !user.isEmailVerified {
                            let alertController = UIAlertController(title: "Correo sin verificar", message: "Por favor, revisa el correo que te mandamos para verificar tu usuario", preferredStyle: .alert)
                            if let user = Auth.auth().currentUser {
                                    user.sendEmailVerification { (error) in
                                        if let error = error {
                                            print("Error al enviar el correo de verificación: \(error.localizedDescription)")
                                        } else {
                                            print("Correo de verificación enviado correctamente")
                                            // Puedes mostrar un mensaje al usuario indicando que se ha enviado un correo de verificación
                                        }
                                    }
                        
                            }
                            
                            // Agregar acciones (botones) a la alerta
                            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                                // Código a ejecutar cuando se presiona el botón OK
                                print("Botón OK presionado")
                            }
                            alertController.addAction(okAction)
                            
                            // Mostrar la alerta
                            self.present(alertController, animated: true, completion: nil)
                        } else {
                            // El correo electrónico ya está verificado
                            if userType == "usuario" {
                                self.performSegue(withIdentifier: "loginSegueUser", sender: self)
                            } else if userType == "administrador" {
                                self.performSegue(withIdentifier: "loginSegueAdmin", sender: self)
                            } else {
                                print("tipo de usuario incorrecto")
                            }
                        }
                    }

                    
                }
                
            }
        
        //
    }
    
    
    func matchRegex(pattern: String, input: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: input.utf16.count)
            return regex.firstMatch(in: input, options: [], range: range) != nil
        } catch {
            print("Error al compilar la expresión regular: \(error.localizedDescription)")
            return false
        }
    }
    
    func displayWarning(message: String) {
        warningLbl.textColor = UIColor.red
        warningLbl.text = message
    }
}

extension UIImageView {
    func round() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
        clipsToBounds = true
    }
    
}





