//import Foundation
//import FirebaseDatabaseInternal
//import FirebaseDatabaseSwift
//
//
//class RecordsManager {
//    
//    static let shared = RecordsManager()
//    
//    private var games: [Game] = []
//    
//    var ref: DatabaseReference! = Database.database().reference()
//
//    
//    
//    private init() {}
//    
//    
//    public func getGames() -> [Game] {
//        return games.sorted(by: { $0.getScore() > $1.getScore()})
//    }
//    
//    public func addGame(_ game: Game) {
//        games.append(game)
//    }
//    
//    public func addGames(_ gamesList: [Game]) {
//        games.append(contentsOf: gamesList)
//    }
//    
//    
//    
//}

import Foundation
import FirebaseDatabaseInternal
import FirebaseDatabaseSwift

class RecordsManager {
    
    static let shared = RecordsManager()
    
    private var games: [Game] = []
    
    var ref: DatabaseReference! = Database.database().reference()
    
    private init() {}
    
    public func getGames() -> [Game] {
        return games.sorted(by: { $0.getScore() > $1.getScore()})
    }
    
    public func addGame(_ game: Game) {
        games.append(game)
    }
    
    public func addGames(_ gamesList: [Game]) {
        games.append(contentsOf: gamesList)
    }
    
    // Function to add a game to Firebase
    public func addGameToFirebase(_ game: Game, completion: @escaping (Error?) -> Void) {
        let gameDict = [
            "playerName": game.getPlayerName(),
            "attempts": game.getAttempts(),
            "time": game.getTime(),
            "score": game.getScore()
        ] as [String : Any]
        
        ref.child("games").childByAutoId().setValue(gameDict) { error, _ in
            completion(error)
        }
    }
    
    // Function to fetch all games from Firebase
    public func fetchGamesFromFirebase(completion: @escaping (Error?) -> Void) {
        ref.child("games").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            
            self.games.removeAll()
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let gameDict = snapshot.value as? [String: Any],
                   let playerName = gameDict["playerName"] as? String,
                   let attempts = gameDict["attempts"] as? Int,
                   let time = gameDict["time"] as? String,
                   let score = gameDict["score"] as? Int {
                    
                    let game = Game(playerName: playerName, attempts: attempts, time: time, score: score)
                    self.games.append(game)
                }
            }
            
            completion(nil)
        } withCancel: { error in
            completion(error)
        }
    }
}
