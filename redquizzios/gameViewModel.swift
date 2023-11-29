import Foundation
import FirebaseFirestore

class GameViewModel {
    private var db = Firestore.firestore()
    var questions = [Question]()

    // Completion handler to notify when data fetching is complete
    typealias CompletionHandler = () -> Void

    func fetchData(completion: @escaping CompletionHandler) {
        print("Fetching Data...")
            db.collection("preguntas").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }

            self.questions = documents.map { (queryDocumentSnapshot) -> Question in
                print("saving question")
                let data = queryDocumentSnapshot.data()

                let categoria = data["categoria"] as? String ?? ""
                let correcta = data["correcta"] as? String ?? ""
                let incorrecta1 = data["incorrecta1"] as? String ?? ""
                let incorrecta2 = data["incorrecta2"] as? String ?? ""
                let incorrecta3 = data["incorrecta3"] as? String ?? ""
                let pregunta = data["pregunta"] as? String ?? ""
                let puntos = data["puntos"] as? Int ?? 0
                let id = queryDocumentSnapshot.documentID

                return Question(categoria: categoria, correcta: correcta, incorrecta1: incorrecta1, incorrecta2: incorrecta2, incorrecta3: incorrecta3, pregunta: pregunta, puntos: puntos, id: id)
            }

            // Call the completion handler when data fetching is complete
            completion()
        }
    }
    
    func createQuestion(pregunta: String, categoria: String, correcta: String, incorrecta1: String, incorrecta2: String, incorrecta3: String, puntos: Int, completion: @escaping CompletionHandler) {
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref = db.collection("preguntas").addDocument(data: [
          "pregunta": pregunta,
          "categoria": categoria,
          "correcta": correcta,
          "incorrecta1": incorrecta1,
          "incorrecta2": incorrecta2,
          "incorrecta3": incorrecta3,
          "puntos": puntos
        ]) { err in
          if let err = err {
            print("Error adding document: \(err)")
          } else {
            print("Document added with ID: \(ref!.documentID)")
              completion()
          }
        }
    }
    
    func deleteQuestion(id: String, completion: @escaping CompletionHandler){
        let collection = db.collection("preguntas")
            let documentReference = collection.document(id)
            
            documentReference.delete { error in
                if let error = error {
                    print("Error deleting document: \(error.localizedDescription)")
                } else {
                    print("Document successfully deleted")
                    self.questions.removeAll { $0.id == id }
                }
                
                // Call the completion handler regardless of success or failure
                completion()
            }
    }
    
    func updateQuestion(id: String, pregunta: String, categoria: String, correcta: String, incorrecta1: String, incorrecta2: String, incorrecta3: String, puntos: Int, completion: @escaping CompletionHandler) {
        let documentReference = db.collection("preguntas").document(id)
        
        documentReference.setData([
            "pregunta": pregunta,
            "categoria": categoria,
            "correcta": correcta,
            "incorrecta1": incorrecta1,
            "incorrecta2": incorrecta2,
            "incorrecta3": incorrecta3,
            "puntos": puntos
        ], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Document successfully updated")
                
                // Update the local questions array with the updated question
                if let updatedQuestionIndex = self.questions.firstIndex(where: { $0.id == id }) {
                    self.questions[updatedQuestionIndex] = Question(
                        categoria: categoria,
                        correcta: correcta,
                        incorrecta1: incorrecta1,
                        incorrecta2: incorrecta2,
                        incorrecta3: incorrecta3,
                        pregunta: pregunta,
                        puntos: puntos,
                        id: id
                    )
                }
            }
            
            // Call the completion handler regardless of success or failure
            completion()
        }
    }

}
