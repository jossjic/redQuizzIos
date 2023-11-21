import Foundation
import FirebaseFirestore
import Firebase

class UserViewModel {
    private var db = Firestore.firestore()
    var uid = ""
    var fetchedUser = User(nombre: "", apellidos: "", email: "", password: "", fechaNacimiento: "", genero: "", indicePregunta: 0, puntaje: 0, vidas: 5)
    var puntajeCollection = 0
    
    // Completion handler to notify when data fetching is complete
    typealias CompletionHandler = () -> Void
    
    func fetchData(completion: @escaping CompletionHandler) {
        print("Fetching Data...")
        if let currentUser = Auth.auth().currentUser{
            self.uid = currentUser.uid
        }
        
        let userRef = db.collection("rqUsers").document(self.uid)
        userRef.getDocument{ (document, error) in
            if let error = error {
                print("Error al obtener al usuario")
            } else if let document = document, document.exists{
                let data = document.data()
                if let nombre = data?["nombre"] as? String,
                   let apellidos = data?["apellidos"] as? String,
                   let email = data?["email"] as? String,
                   let fechaNacimiento = data?["fechaNacimiento"] as? String,
                   let genero = data?["genero"] as? String,
                   let indicePregunta = data?["indicePregunta"] as? Int,
                   let password = data?["password"] as? String,
                   let puntaje = data?["puntaje"] as? Int,
                   let vidas = data?["vidas"] as? Int {
                    self.fetchedUser = User(nombre: nombre, apellidos: apellidos, email: email, password: password, fechaNacimiento: fechaNacimiento, genero: genero, indicePregunta: indicePregunta, puntaje: puntaje, vidas: vidas)
                    print("Fetch de usuario listo")
                    completion()
                } else {
                    print("Alguno de los campos no está presente o tiene un formato incorrecto.")
                }
            } else {
                print("El docuumento no existe")
            }
            
        }
        
        
        
    }
    func updateLives(newLives: Int) {
        guard let currentUser = Auth.auth().currentUser else {
            print("No hay usuario autenticado.")
            return
        }
        
        let userRef = db.collection("rqUsers").document(currentUser.uid)
        userRef.updateData(["vidas": newLives]) { error in
            if let error = error {
                print("Error al actualizar las vidas: \(error.localizedDescription)")
            } else {
                self.fetchedUser.vidas = newLives
            }
        }
    }
    
    private func updateDataScore(collection: String, score: Int) {
        var acumuladoAux = 0
        var puntajeGAux = 0

        guard let currentUser = Auth.auth().currentUser else {
            print("No hay usuario autenticado.")
            return
        }
        let userRef = db.collection(collection).document(currentUser.uid)

        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error al obtener el documento: \(error)")
            } else if let document = document, document.exists {
                let data = document.data()

                if let acumulado = data?["acumulado"] as? Int {
                    print("acumulado: \(acumulado)")
                    acumuladoAux = acumulado
                }

                if let puntajeG = data?["puntaje"] as? Int {
                    print("puntaje: \(puntajeG)")
                    puntajeGAux = puntajeG
                }

                // Actualizar la base de datos con la suma del puntaje actual y el nuevo puntaje
                if collection != "rqUsers" {
                    userRef.updateData(["acumulado": score + acumuladoAux]) { error in
                        if let error = error {
                            print("Error al actualizar el acumulado: \(error.localizedDescription)")
                        }
                    }
                } else {
                    userRef.updateData(["puntaje": score + puntajeGAux]) { error in
                        if let error = error {
                            print("Error al actualizar el puntaje: \(error.localizedDescription)")
                        } else {
                            // Puedes realizar acciones adicionales después de la actualización, si es necesario
                        }
                    }
                }
            } else {
                print("El documento no existe")
            }
        }
    }

    func updateScore(score: Int, type: String) {
        switch type {
        case "general":
            updateDataScore(collection: "rqUsers", score: score)
        case "Anatomía":
            updateDataScore(collection: "rqAnatomia", score: score)
        case "Signos Vitales":
            updateDataScore(collection: "rqSignosVitales", score: score)
        case "Curación":
            updateDataScore(collection: "rqCuracion", score: score)
        case "Síntomas":
            updateDataScore(collection: "rqSintomas", score: score)
        case "Bonus":
            updateDataScore(collection: "rqBonus", score: score)
        default:
            print("Tipo no permitido en updateScore()")
        }
    }
    
    func fetchCat(collection: String, completion: @escaping CompletionHandler){
        
        guard let currentUser = Auth.auth().currentUser else {
            print("No hay usuario autenticado.")
            return
        }
        let userRef = db.collection(collection).document(currentUser.uid)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error al obtener el documento: \(error)")
            } else if let document = document, document.exists {
                let data = document.data()
                
                if let acumulado = data?["acumulado"] as? Int {
                    print("acumulado: \(acumulado)")
                    self.puntajeCollection = acumulado
                    completion()
                }
            }
            else {
                print("El documento no existe")
            }
        }
        
        
        
    }
    
    
    }

