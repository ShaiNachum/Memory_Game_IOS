import Foundation
import UIKit



class RecordsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var records_LST_games: UITableView!
    
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        records_LST_games.dataSource = self
        records_LST_games.delegate = self
        
        fetchGames()
    }
    
    func fetchGames() {
            RecordsManager.shared.fetchGamesFromFirebase { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching games: \(error.localizedDescription)")
                } else {
                    self.games = RecordsManager.shared.getGames()
                    print("Fetched \(self.games.count) games")
                    
                    DispatchQueue.main.async {
                        self.records_LST_games.reloadData()
                    }
                }
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = games[indexPath.row]
        let cell = records_LST_games.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameCell
        cell.cell_LBL_name.text = "Name: \(game.getPlayerName())"
        cell.cell_LBL_place.text = "# \(indexPath.row + 1)"
        cell.cell_LBL_score.text = "Score: \(game.getScore())"
        cell.cell_LBL_time.text = "Time: \(game.getTime())"
        cell.cell_LBL_attempts.text = "Attempts: \(game.getAttempts())"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //here you decide what happend when cell is tapped
        print("You tapped cell number \(indexPath.row). name: \(games[indexPath.row].getPlayerName()). score: \(games[indexPath.row].getScore()). time: \(games[indexPath.row].getTime())")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    @IBAction func records_BTN_back(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


class GameCell: UITableViewCell {
    @IBOutlet weak var cell_LBL_name: UILabel!
    @IBOutlet weak var cell_LBL_place: UILabel!
    @IBOutlet weak var cell_LBL_time: UILabel!
    @IBOutlet weak var cell_LBL_score: UILabel!
    @IBOutlet weak var cell_LBL_attempts: UILabel!
}
