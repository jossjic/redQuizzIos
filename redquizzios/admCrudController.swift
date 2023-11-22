
import UIKit

class admCrudController: UIViewController, UITableViewDataSource {
    
//outlets
    @IBOutlet weak var questionsTable: UITableView!
    @IBOutlet weak var categoriaPicker: UIPickerView!
    var questions = [Question]()
    
    let gameViewModel = GameViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        questionsTable.dataSource = self
        gameViewModel.fetchData {
            self.questions = self.gameViewModel.questions
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questionsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.
        return cell
    }
//actions

}
