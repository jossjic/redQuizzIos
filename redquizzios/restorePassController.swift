
import UIKit
import Firebase

class restorePassController: UIViewController {
    deinit {
        // Liberar notificaciones
        NotificationCenter.default.removeObserver(self)
    }
    
    let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//outlets
    @IBOutlet weak var warningMsg: UILabel!
    
    @IBOutlet weak var correoText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        agregarGestorDeTapParaOcultarTeclado()
    }
    
//actions

    @IBAction func restoreBtn(_ sender: Any) {
        guard let email = correoText.text else {
            displayWarning(message: "Por favor, completa todos los campos.")
            return
        }
        
        if email.isEmpty {
            displayWarning(message: "Por favor, completa todos los campos.")
            return
        }
        
        if !matchRegex(pattern: emailPattern, input: email) {
            displayWarning(message: "Correo electrónico inválido.")
            return
        }
        
        self.resetPassword(email: email)
        
        
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
        warningMsg.textColor = UIColor.red
        warningMsg.text = message
    }
    

        // Función para restablecer la contraseña (si es necesario)
        func resetPassword(email: String) {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if let error = error {
                    print("Error al enviar el correo de restablecimiento de contraseña: \(error.localizedDescription)")
                    // Tratar el error según tus necesidades
                } else {
                    // El correo de restablecimiento de contraseña se envió con éxito
                    print("Correo de restablecimiento de contraseña enviado a \(email)")
                    let alertController = UIAlertController(title: "Correo Enviado", message: "Si está registrado, enviamos un correo a (\(email)), verifica tu correo y sigue los pasos", preferredStyle: .alert)
                    
                    // Agregar acciones (botones) a la alerta
                    let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                        // Código a ejecutar cuando se presiona el botón OK
                        print("Botón OK presionado")
                        self.performSegue(withIdentifier: "restoreSegue", sender: self)
                    }
                    alertController.addAction(okAction)
                    
                    // Mostrar la alerta
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
}

