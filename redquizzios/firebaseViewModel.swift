
import Foundation
import FirebaseFirestore

class gameViewModel: ObservableObject {
    @Published var questions = [Question]()
    
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("preguntas").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }
            self.questions = documents.map { (queryDocumentSnapshot) -> Question in
               let data = queryDocumentSnapshot.data()
                
                let categoria = data["categoria"] as? String ?? ""
                let correcta = data["correcta "] as? String ?? ""
                let incorrecta1 = data["ncorrecta1 "] as? String ?? ""
                let incorrecta2 = data["incorrecta2 "] as? String ?? ""
                let incorrecta3 = data["incorrecta3 "] as? String ?? ""
                let pregunta = data["pregunta"] as? String ?? ""
                let puntos = data["puntos"] as? Int ?? 0
                
                return Question(categoria: categoria, correcta: correcta, incorrecta1: incorrecta1, incorrecta2: incorrecta2, incorrecta3: incorrecta3, pregunta: pregunta, puntos: puntos)
            }
        }
    }
}
