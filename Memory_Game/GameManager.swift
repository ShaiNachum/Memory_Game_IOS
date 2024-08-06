import Foundation

class GameManager {
    private let VISIBLE: Int = 1
    private let INVISIBLE: Int = 0
    private let ROWS: Int = 4
    private let COLS: Int = 4
    private let NUM_OF_MATCHES = 8
    
    private var cards: [[Card]]
    private var covers: [[Int]]
    
    private var attempts: Int
    private var score: Int
    private var matches: Int
    
    private var playerName: String
    
    private var pack: [Card]
    
    private var card_1_i: Int!
    private var card_1_j: Int!
    private var card_2_i: Int!
    private var card_2_j: Int!
    
    private let viewController: GameController
    private var dataManager: DataManager
    
    
    init(viewController: GameController, playerName: String) {
        self.viewController = viewController
        self.dataManager = DataManager()
        
        self.pack = dataManager.getPack()
        
        self.playerName = playerName
        self.attempts = 0
        self.score = 115
        self.matches = 0
        
        self.card_1_i = 0
        self.card_1_j = 0
        self.card_2_i = 0
        self.card_2_j = 0
        
        self.cards = Array(repeating: Array(repeating: Card(name: "", id: 0), count: COLS), count: ROWS)
        self.covers = Array(repeating: Array(repeating: 0, count: COLS), count: ROWS)
        
        initCovers()
        initCards()
    }
    
    private func initCovers() {
        for i in 0..<ROWS {
            for j in 0..<COLS {
                covers[i][j] = VISIBLE
            }
        }
    }
    
    private func initCards() {
        for i in 0..<ROWS {
            for j in 0..<COLS {
                cards[i][j] = pack[i * ROWS + j]
            }
        }
    }
    
    public func getImage(i: Int, j: Int) -> String {
        return cards[i][j].getName()
    }
    
    public func changeCoverStatus(i: Int, j: Int) {
        covers[i][j] = INVISIBLE
    }
    
    public func getCoverStatus(i: Int, j: Int) -> Int {
        return covers[i][j]
    }
    
    public func setCard_1_i(card_1_i: Int) {
        self.card_1_i = card_1_i
    }
    
    public func setCard_1_j(card_1_j: Int) {
        self.card_1_j = card_1_j
    }
    
    public func setCard_2_i(card_2_i: Int) {
        self.card_2_i = card_2_i
    }
    
    public func setCard_2_j(card_2_j: Int) {
        self.card_2_j = card_2_j
    }
    
    public func getAttempts() -> Int {
        return self.attempts
    }
    
    public func getScore() -> Int {
        return self.score
    }
    
    public func checkMatch() -> Bool {
        if(cards[card_1_i][card_1_j].getId() == cards[card_2_i][card_2_j].getId()){
            cards[card_1_i][card_1_j].setFlipped(flipped: true)
            cards[card_2_i][card_2_j].setFlipped(flipped: true)
            attempts += 1
            matches += 1
            
            return true
        }
        else{
            attempts += 1
            score -= 5
            
            if(score < 0){
                score = 0
            }
            
            return false
        }
    }
    
    public func updateCovers() {
        for i in 0..<ROWS {
            for j in 0..<COLS {
                if(cards[i][j].isFlipped()){
                    covers[i][j] = INVISIBLE
                }
                else{
                    covers[i][j] = VISIBLE
                }
            }
        }
    }
    
    public func isGameOver() -> Bool {
        return self.matches == 8
    }
}
