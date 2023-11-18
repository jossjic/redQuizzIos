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

                return Question(categoria: categoria, correcta: correcta, incorrecta1: incorrecta1, incorrecta2: incorrecta2, incorrecta3: incorrecta3, pregunta: pregunta, puntos: puntos)
            }

            // Call the completion handler when data fetching is complete
            completion()
        }
    }
}
