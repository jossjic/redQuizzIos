
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
    
    @IBOutlet weak var registerLastName: UITextField!
    
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
        let apellidos = registerLastName.text!
        let mail = registerMail.text!
        let password = registerPass.text!
        let repeatPassword = registerRepeatPass.text!
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
