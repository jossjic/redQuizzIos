
import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore



class singupController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    
    

    
    @IBOutlet weak var eyeBtn: UIButton!
    
    @IBOutlet weak var registerName: UITextField!
    @IBOutlet weak var registerMail: UITextField!
    @IBOutlet weak var registerPass: UITextField!
    @IBOutlet weak var registerRepeatPass: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var registerLastName: UITextField!
    
    var escapeF = false
    
    let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let passwordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,}$"
    
    let generos = ["Masculino", "Femenino"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eyeBtn.setTitle("", for: .normal)
        agregarGestorDeTapParaOcultarTeclado()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        

        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return generos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return generos[row]
    }
    
    func checkIfUserExists(email: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email) { (methods, error) in
            if let error = error {
                print("Error al verificar el correo electrónico: \(error.localizedDescription)")
                completion(false)
                return
            }

            // Si methods es nil, el correo electrónico no está asociado con ninguna cuenta
            if let signInMethods = methods {
                if signInMethods.isEmpty {
                    // El correo electrónico no está registrado
                    completion(false)
                } else {
                    // El correo electrónico ya está registrado
                    completion(true)
                }
            }
        }
    }
    
    deinit {
        // Liberar notificaciones
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        
        guard let name = registerName.text, let apellidos = registerLastName.text, let mail = registerMail.text, let password = registerPass.text, let repeatPassword = registerRepeatPass.text
        else {
            displayWarning(message: "Por favor, completa todos los campos.")
            return
        }
        
        if mail.isEmpty || password.isEmpty || repeatPassword.isEmpty || apellidos.isEmpty || name.isEmpty {
            displayWarning(message: "Por favor, completa todos los campos.")
            return
        }
        
        if !matchRegex(pattern: emailPattern, input: mail) {
            displayWarning(message: "Correo electrónico inválido.")
            return
        }
        
        if !matchRegex(pattern: passwordPattern, input: password) {
            displayWarning(message: "La contraseña debe tener al menos 8 caracteres, una letra mayúscula, una letra minúscula y un número.")
            return
        }
        
        if password != repeatPassword {
            displayWarning(message: "Las contraseñas no coinciden.")
            return
        }
        
        let gender = generos[genderPicker.selectedRow(inComponent: 0)]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let fechaNacimiento = dateFormatter.string(from: birthdayPicker.date)
        let tipo = "usuario"
        let vidas = 5
        let acumulado = 0
        let puntaje = 0
        let conteoC = 0
        let conteoT = 0
        let recompensa1 = false
        let recompensa2 = false
        let recompensa3 = false
        let recompensa4 = false
        let recompensa5 = false
        let prendaI = 1
        let prendaS = 1
        
        
        Auth.auth().createUser(withEmail: mail, password: password) { (result, error) in
            if let error = error as NSError? {
                if error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    // El correo electrónico ya está registrado
                    self.displayWarning(message: "El correo electrónico ya está en uso.")
                } else {
                    // Otro tipo de error
                    print("Error al registrar el usuario: \(error.localizedDescription)")
                }
                self.escapeF = true
            } else {
                print("Usuario registrado con éxito")
                
                if let userId = result?.user.uid {
                    let userData: [String: Any] = [
                        "nombre": name,
                        "apellidos": apellidos,
                        "email": mail,
                        "genero": gender,
                        "fechaNacimiento": fechaNacimiento,
                        "tipo": tipo,
                        "vidas": vidas,
                        "puntaje": puntaje,
                        "acumulado": acumulado,
                        "prendaI": prendaI,
                        "prendaS": prendaS
                    ]
                    let _: [String: Any] = [
                        "conteoC": conteoC,
                        "conteoT": conteoT,
                        "recompensa1": recompensa1,
                        "recompensa2": recompensa2,
                        "recompensa3": recompensa3,
                        "recompensa4": recompensa4,
                        "recompensa5": recompensa5
                    ]
                    
                    let db = Firestore.firestore()
                    db.collection("rqUsers").document(userId).setData(userData) { error in
                        if let error = error {
                            print("Error al guardar los datos del usuario en Firestore: \(error.localizedDescription)")
                        } else {
                            print("Datos del usuario guardados en Firestore correctamente")
                            let rqAnatomiaData: [String: Any] = ["userId": userId,"acumulado": acumulado]
                            db.collection("rqAnatomia").document(userId).setData(rqAnatomiaData) { error in
                                if let error = error {
                                    print("Error al guardar los datos en la colección rqAnatomia en Firestore: \(error.localizedDescription)")
                                } else {
                                    print("Datos guardados en la colección rqAnatomia en Firestore correctamente")
                                }
                            }
                            let rqBonusData: [String: Any] = ["userId": userId,"acumulado": acumulado]
                            db.collection("rqBonus").document(userId).setData(rqBonusData) { error in
                                if let error = error {
                                    print("Error al guardar los datos en la colección rqBonus en Firestore: \(error.localizedDescription)")
                                } else {
                                    print("Datos guardados en la colección rqBonus en Firestore correctamente")
                                }
                            }
                            let rqCuracionData: [String: Any] = ["userId": userId,"acumulado": acumulado]
                            db.collection("rqCuracion").document(userId).setData(rqCuracionData) { error in
                                if let error = error {
                                    print("Error al guardar los datos en la colección rqCuracion en Firestore: \(error.localizedDescription)")
                                } else {
                                    print("Datos guardados en la colección rqCuracion en Firestore correctamente")
                                }
                            }
                            let rqSignosVitalesData: [String: Any] = ["userId": userId,"acumulado": acumulado]
                            db.collection("rqSignosVitales").document(userId).setData(rqSignosVitalesData) { error in
                                if let error = error {
                                    print("Error al guardar los datos en la colección rqSignosVitales en Firestore: \(error.localizedDescription)")
                                } else {
                                    print("Datos guardados en la colección rqSignosVitales en Firestore correctamente")
                                }
                            }
                            let rqSintomasData: [String: Any] = ["userId": userId,"acumulado": acumulado]
                            db.collection("rqSintomas").document(userId).setData(rqSintomasData) { error in
                                if let error = error {
                                    print("Error al guardar los datos en la colección rqSintomas en Firestore: \(error.localizedDescription)")
                                } else {
                                    print("Datos guardados en la colección rqSintomas en Firestore correctamente")
                                }
                            }
                            let rqConteoData: [String: Any] = ["userId": userId,"conteoC": conteoC, "conteoT": conteoT]
                            db.collection("rqConteo").document(userId).setData(rqConteoData) { error in
                                if let error = error {
                                    print("Error al guardar los datos en la colección rqConteo en Firestore: \(error.localizedDescription)")
                                } else {
                                    print("Datos guardados en la colección rqConteo en Firestore correctamente")
                                }
                            }
                            let rqRecompensasData: [String: Any] = ["userId": userId,"recompensa1": recompensa1, "recompensa2": recompensa2, "recompensa3": recompensa3, "recompensa4": recompensa4, "recompensa5": recompensa5]
                            db.collection("rqRecompensas").document(userId).setData(rqRecompensasData) { error in
                                if let error = error {
                                    print("Error al guardar los datos en la colección rqRecompensas en Firestore: \(error.localizedDescription)")
                                } else {
                                    print("Datos guardados en la colección rqRecompensas en Firestore correctamente")
                                }
                                
                            }
                            
                            if let user = Auth.auth().currentUser {
                                if !user.isEmailVerified {
                                    user.sendEmailVerification { (error) in
                                        if let error = error {
                                            print("Error al enviar el correo de verificación: \(error.localizedDescription)")
                                        } else {
                                            print("Correo de verificación enviado correctamente")
                                            // Puedes mostrar un mensaje al usuario indicando que se ha enviado un correo de verificación
                                        }
                                    }
                                } else {
                                    // El correo electrónico ya está verificado
                                    print("El correo electrónico ya está verificado")
                                }
                            }

                            let alertController = UIAlertController(title: "Registro Completado", message: "El usuario fue registrado correctamente, te enviamos un correo a (\(mail)), verifica tu correo e inicia sesión", preferredStyle: .alert)
                            
                            // Agregar acciones (botones) a la alerta
                            let okAction = UIAlertAction(title: "Iniciar Sesión", style: .default) { _ in
                                // Código a ejecutar cuando se presiona el botón OK
                                print("Botón OK presionado")
                                self.performSegue(withIdentifier: "postSignUp", sender: self)
                            }
                            alertController.addAction(okAction)
                            
                            // Mostrar la alerta
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
           
        

        
    }
    
    func displayWarning(message: String) {
        msgLbl.textColor = UIColor.red
        msgLbl.text = message
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
    
    @IBAction func eye(_ sender: Any) {
        self.registerPass.isSecureTextEntry.toggle()
                let imageName = registerPass.isSecureTextEntry ? "eye" : "eye_closed"
                self.eyeBtn.setImage(UIImage(named: imageName), for:.normal)
    }
    
}
