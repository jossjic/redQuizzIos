
import UIKit
import FirebaseAuth


class singupController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var registerName: UITextField!
    @IBOutlet weak var registerMail: UITextField!
    @IBOutlet weak var registerPass: UITextField!
    @IBOutlet weak var registerRepeatPass: UITextField!
    @IBOutlet weak var genderTxt: UITextField!
    @IBOutlet weak var birthdayTxt: UITextField!
    
    let generos = ["Masculino", "Femenino"]
    var genderPicker: UIPickerView!
    var birthdayPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPicker = UIPickerView()
        genderPicker.tag = 1
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderTxt.inputView = genderPicker
        genderTxt.text = generos[0]
        
        birthdayPicker = UIDatePicker()
        birthdayPicker.datePickerMode = .date
        birthdayPicker.addTarget(self, action: #selector(birthdayPickerChanged), for: .valueChanged)
        birthdayTxt.inputView = birthdayPicker
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTxt.text = generos[row]
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        let name = registerName.text!
        let mail = registerMail.text!
        let password = registerPass.text!
        let repeatPassword = registerRepeatPass.text!
        let birthday = birthdayPicker.date
        
        
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
            }
        }
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        let mail = registerMail.text!
        let password = registerPass.text!
        
        Auth.auth().signIn(withEmail: mail, password: password) { (result, error) in
            
            if  error != nil {
                print("Error al iniciar sesión")
            } else {
                print("Inicio de sesión exitoso")
            }
        }
    }
    
    @objc func birthdayPickerChanged(){
        let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            birthdayTxt.text = dateFormatter.string(from:birthdayPicker.date)
    }
}
