import UIKit
import Firebase

class loginController: UIViewController {
    
    
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    let userViewModel = UserViewModel()
    let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    if userType == "usuario" {
                        self.performSegue(withIdentifier: "loginSegueUser", sender: self)
                    } else if userType == "administrador" {
                        self.performSegue(withIdentifier: "loginSegueAdmin", sender: self)
                    } else {
                        print("tipo de usuario incorrecto")
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

