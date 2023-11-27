

import UIKit
import Firebase

class editAvatarController: UIViewController {
    
    // Outlets
    @IBOutlet weak var maleAvatar: UIImageView!
    @IBOutlet weak var femaleAvatar: UIImageView!
    @IBOutlet weak var playeraHombre: UIImageView!
    @IBOutlet weak var pantalonHombre: UIImageView!
    @IBOutlet weak var zapatosHombre: UIImageView!
    @IBOutlet weak var playeraMujer: UIImageView!
    @IBOutlet weak var pantalonMujer: UIImageView!
    @IBOutlet weak var zapatosMujer: UIImageView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var superiorBtn: UIButton!
    @IBOutlet weak var inferiorBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var returnBtn: UIButton!
    
    var userId: String?
    var genero: String?
    var puntaje: Int?
    var prendaS: String?
    var prendaI: String?
    var recompensa1: Bool = false
    var recompensa2: Bool = false
    var recompensa3: Bool = false
    var recompensa4: Bool = false
    var recompensa5: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        // Configurar visibilidad de UIImageView según el género del usuario
        configureGenderUI()
        // Configurar visibilidad de botones según la lógica descrita
        configureButtonsVisibility()
    }
    
    func getUserData() {
        // Obtener el ID del usuario logeado (puedes implementar esta lógica según tu aplicación)
        // ...
        
        // Consultar Firestore para obtener los datos del usuario
        let db = Firestore.firestore()
        let userRef = db.collection("rqUsers").document(userId ?? "")
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Obtener datos del documento
                self.genero = document["genero"] as? String
                self.puntaje = document["puntaje"] as? Int
                self.prendaS = document["prendaS"] as? String
                self.prendaI = document["prendaI"] as? String
                
                // Actualizar visibilidad de UIImageView según el género
                self.configureGeneroUI()
                
                // Actualizar recompensas según el puntaje del usuario
                self.updateRewards()
            } else {
                print("Document does not exist")
            }
        }
    }
    func updateRewards() {
            // Actualizar recompensas según el puntaje del usuario
            if let puntaje = puntaje {
                recompensa1 = puntaje >= 50
                recompensa2 = puntaje >= 100
                recompensa3 = puntaje >= 200
                recompensa4 = puntaje >= 400
                recompensa5 = puntaje >= 800
            }
            
            // Actualizar visibilidad de botones según las recompensas
            configureButtonsVisibility()
        }
        
        // Consultar Firestore para obtener datos de recompensas
    let rewardsRef = db.collection("rqRecompensas").document(userId ?? ""); func rewardsRef;.getDocument { (document, error) in
            if let document = document, document.exists {
                // Obtener datos de recompensas
                self.recompensa1 = document["recompensa1"] as? Bool ?? false
                self.recompensa2 = document["recompensa2"] as? Bool ?? false
                self.recompensa3 = document["recompensa3"] as? Bool ?? false
                self.recompensa4 = document["recompensa4"] as? Bool ?? false
                self.recompensa5 = document["recompensa5"] as? Bool ?? false
                
                // Actualizar visibilidad de botones según las recompensas
                self.configureButtonsVisibility()
            } else {
                print("Document does not exist")
            }
        }
    }

func configureGeneroUI() {
        // Configurar visibilidad de UIImageView según el género del usuario
        if genero == "Masculino" {
            maleAvatar.isHidden = false
            femaleAvatar.isHidden = true
            playeraHombre.isHidden = false
            pantalonHombre.isHidden = false
            zapatosHombre.isHidden = false
            playeraMujer.isHidden = true
            pantalonMujer.isHidden = true
            zapatosMujer.isHidden = true
        } else if genero == "Femenino" {
            maleAvatar.isHidden = true
            femaleAvatar.isHidden = false
            playeraHombre.isHidden = true
            pantalonHombre.isHidden = true
            zapatosHombre.isHidden = true
            playeraMujer.isHidden = false
            pantalonMujer.isHidden = false
            zapatosMujer.isHidden = false
        }
    }
    
    func configureButtonsVisibility() {
        // Configurar visibilidad de botones según la lógica descrita
        btn1.isHidden = false
        btn2.isHidden = false
        btn3.isHidden = false
        btn4.isHidden = false
    }

    @IBAction func superiorBtnTapped(_ sender: UIButton) {
        // Habilitar 4 botones
        btn1.isEnabled = true
        btn2.isEnabled = reward1
        btn3.isEnabled = reward3
        btn4.isEnabled = reward5
    }

    @IBAction func inferiorBtnTapped(_ sender: UIButton) {
        // Habilitar 3 botones
        btn1.isEnabled = true
        btn2.isEnabled = reward2
        btn3.isEnabled = reward4
        btn4.isHidden = true
    }

    @IBAction func btnTapped(_ sender: UIButton) {
        // Verificar qué botón fue presionado y actualizar prendaS y la imagen correspondiente
        if sender == btn1 {
            prendaS = "1"
            updateAvatarImage()
            prendaI = "1"
            updatePantalonImage()
        } else if sender == btn2 {
            prendaS = "2"
            updateAvatarImage()
            prendaI = "2"
            updatePantalonImage()
        } else if sender == btn3 {
            prendaS = "3"
            updateAvatarImage()
            prendaI = "3"
            updatePantalonImage()
        } else if sender == btn4 {
            prendaS = "4"
            updateAvatarImage()
            prendaI = "4"
            pdatePantalonImage()
        }
    }
    func updateAvatarImage() {
        // Actualizar la imagen en playeraHombre o playeraMujer según el género y prendaS
        if userGender == "male" {
            playeraHombre.image = UIImage(named: "playeraHombre_\(prendaS ?? "1")")
        } else if userGender == "female" {
            playeraMujer.image = UIImage(named: "playeraMujer_\(prendaS ?? "1")")
        }
    }
    func updatePantalonImage() {
        // Actualizar la imagen en pantalonHombre o pantalonMujer según el género y prendaI
        if userGender == "male" {
            pantalonHombre.image = UIImage(named: "pantalonHombre_\(prendaI ?? "1")")
        } else if userGender == "female" {
            pantalonMujer.image = UIImage(named: "pantalonMujer_\(prendaI ?? "1")")
        }
    }
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        // Guardar y actualizar en la base de datos el valor de prendaS y prendaI
            let db = Firestore.firestore()
            let userRef = db.collection("rqUsers").document(userId ?? "")
            
            userRef.updateData([
                "prendaS": prendaS ?? "",
                "prendaI": prendaI ?? ""
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }

            // Establecer la selección de imágenes de playera y pantalón según el género
            if userGender == "male" {
                playeraHombre.image = UIImage(named: "playeraHombre_\(prendaS ?? "1")")
                pantalonHombre.image = UIImage(named: "pantalonHombre_\(prendaI ?? "1")")
            } else if userGender == "female" {
                playeraMujer.image = UIImage(named: "playeraMujer_\(prendaS ?? "1")")
                pantalonMujer.image = UIImage(named: "pantalonMujer_\(prendaI ?? "1")")
    }
}
