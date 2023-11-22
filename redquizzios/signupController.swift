
import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore



class singupController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    
    @IBOutlet weak var registerName: UITextField!
    @IBOutlet weak var registerMail: UITextField!
    @IBOutlet weak var registerPass: UITextField!
    @IBOutlet weak var registerRepeatPass: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    let generos = ["Masculino", "Femenino"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    
    @IBAction func registerBtn(_ sender: Any) {
        let name = registerName.text!
        let mail = registerMail.text!
        let password = registerPass.text!
        let repeatPassword = registerRepeatPass.text!
        let gender = generos[genderPicker.selectedRow(inComponent: 0)]
        let fechaNacimiento = "sjahbdhjas"
        let tipo = "usuario"
        let vidas = 5
        let acumulado = 0
        let puntaje = 0
        let apellidos = "fyguqefr"
        
        
        
        if password != repeatPassword {
            print("Las contraseñas no coinciden")
            return
        }
        
        Auth.auth().createUser(withEmail: mail, password: password){
            (result, error) in
            if error != nil  {
                print("Error al registrar el usuario")
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
                        "acumulado": acumulado
                        
                        
                    ]
                    
                    let db = Firestore.firestore()
                    db.collection("rqUsers").document(userId).setData(userData) { error in
                        if let error = error {
                            print("Error al guardar los datos del usuario en Firestore: \(error.localizedDescription)")
                        } else {
                            print("Datos del usuario guardados en Firestore correctamente")
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
}
