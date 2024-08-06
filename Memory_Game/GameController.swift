import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var game_IMG_00: UIImageView!
    @IBOutlet weak var game_IMG_01: UIImageView!
    @IBOutlet weak var game_IMG_02: UIImageView!
    @IBOutlet weak var game_IMG_03: UIImageView!
    
    @IBOutlet weak var game_IMG_10: UIImageView!
    @IBOutlet weak var game_IMG_11: UIImageView!
    @IBOutlet weak var game_IMG_12: UIImageView!
    @IBOutlet weak var game_IMG_13: UIImageView!
    
    @IBOutlet weak var game_IMG_20: UIImageView!
    @IBOutlet weak var game_IMG_21: UIImageView!
    @IBOutlet weak var game_IMG_22: UIImageView!
    @IBOutlet weak var game_IMG_23: UIImageView!
    
    @IBOutlet weak var game_IMG_30: UIImageView!
    @IBOutlet weak var game_IMG_31: UIImageView!
    @IBOutlet weak var game_IMG_32: UIImageView!
    @IBOutlet weak var game_IMG_33: UIImageView!
    
    @IBOutlet weak var game_LBL_time: UILabel!
    @IBOutlet weak var game_LBL_attempts: UILabel!
    @IBOutlet weak var game_LBL_score: UILabel!
    
    private let ROWS: Int = 4
    private let COLS: Int = 4
    private let VISIBLE: Int = 1
    private let INVISIBLE: Int = 0
    
    var openCardsTimer: Timer?
    var openCardsTimerOn: Bool = false
    var delay: Double = 2.0
    
    var generalTimer: Timer?
    var generalTimerOn: Bool = false
    var startTime: TimeInterval = 0
    var generalDelay: TimeInterval = 1.0
    
    var playerName: String = ""
    
    var cards: [[UIImageView]] = []

    var openCards: Int = 0
    
    var gameManager: GameManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameManager = GameManager(viewController: self, playerName: self.playerName)
                
        setupImageViewMatrix()
        
        initViews()
        
        startGeneralTimer()
    }
    
    private func startGeneralTimer() {
        if(generalTimerOn == false) {
            generalTimerOn = true
            startTime = Date().timeIntervalSince1970
            generalTimer = Timer.scheduledTimer(timeInterval: generalDelay, target: self, selector: #selector(updateTimerUI), userInfo: nil, repeats: true)
        }
    }
    
    private func stopGeneralTimer() {
        generalTimerOn = false
        generalTimer?.invalidate()
        generalTimer = nil
    }
    
    @objc func updateTimerUI() {
        let currentMillis = Date().timeIntervalSince1970 - startTime
        let seconds = Int(currentMillis) % 60
        let minutes = (Int(currentMillis) / 60) % 60
        
        DispatchQueue.main.async {
            self.game_LBL_time.text = String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    private func setupImageViewMatrix() {
            cards = [
                [game_IMG_00, game_IMG_01, game_IMG_02, game_IMG_03],
                [game_IMG_10, game_IMG_11, game_IMG_12, game_IMG_13],
                [game_IMG_20, game_IMG_21, game_IMG_22, game_IMG_23],
                [game_IMG_30, game_IMG_31, game_IMG_32, game_IMG_33]
            ]
    }
    
    private func initViews() {
        for i in 0..<ROWS {
            for j in 0..<COLS {
                cards[i][j].image = UIImage(named: "cardBack")
            }
        }
        
        for i in 0..<ROWS {
            for j in 0..<COLS {
                cards[i][j].isUserInteractionEnabled = true
                // Create a tap gesture recognizer
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped(_:)))
                cards[i][j].addGestureRecognizer(tapGesture)
            }
        }
    }
    
    @objc private func cardTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView else { return }
        
        // Find the index of the tapped image view in the matrix
        for (rowIndex, row) in cards.enumerated() {
            if let colIndex = row.firstIndex(of: tappedImageView) {
                print("Tapped image view at row \(rowIndex), column \(colIndex)")
                // Perform additional actions as needed
                
                if(openCardsTimerOn == false) {
                    if(openCards == 0){
                        setFirstCard(i: rowIndex, j: colIndex)
                    }
                    else if(openCards == 1) {
                        setSecondCard(i: rowIndex, j: colIndex)
                    }
                }
            }
        }
    }
    
    
    private func setFirstCard(i: Int, j: Int) {
        cards[i][j].image = UIImage(named:gameManager.getImage(i: i, j: j))
        
        if(gameManager.getCoverStatus(i: i, j: j) == 1){ //1 = visible
            gameManager.changeCoverStatus(i: i, j: j)
            gameManager.setCard_1_i(card_1_i: i)
            gameManager.setCard_1_j(card_1_j: j)
        }
        
        openCards = 1
    }
    
    
    private func setSecondCard(i: Int, j: Int) {
        cards[i][j].image = UIImage(named:gameManager.getImage(i: i, j: j))
        if(gameManager.getCoverStatus(i: i, j: j) == 1){ //1 = visible
            gameManager.changeCoverStatus(i: i, j: j)
            gameManager.setCard_2_i(card_2_i: i)
            gameManager.setCard_2_j(card_2_j: j)
        }
        
        let isMatch: Bool = gameManager.checkMatch()
        let isGameOver: Bool = gameManager.isGameOver()
        
        if(isGameOver == true){
            gameOver()
        }
        else if(isMatch == true){
            delay = 0.0
        }
        else {
            delay = 2.0
        }
        
        gameManager.updateCovers()
        openCardsStartTimer()
        openCards = 0
    }
    
    private func openCardsStartTimer() {
        openCardsTimerOn = true
        openCardsTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
        
    }
    
    @objc func timerFired() {
        DispatchQueue.main.async {
            self.updateUI()
            self.openCardsTimerOn = false
        }
    }
    
    private func updateUI() {
        for i in 0..<ROWS {
            for j in 0..<COLS {
                if(gameManager.getCoverStatus(i: i, j: j) == 0){
                    cards[i][j].image = UIImage(named: gameManager.getImage(i: i, j: j))
                }
                else{
                    cards[i][j].image = UIImage(named: "cardBack")
                }
            }
        }
        game_LBL_attempts.text = "Attempts: \(gameManager.getAttempts())"
        
        if(gameManager.getScore() > 100) {
            game_LBL_score.text = "Score: 100"
        }
        else{
            game_LBL_score.text = "Score: \(gameManager.getScore())"
        }
    }
    
    private func gameOver() {
        stopGeneralTimer()
        let game: Game = Game(playerName: self.playerName, attempts: self.gameManager.getAttempts(), time: self.game_LBL_time.text!, score: self.gameManager.getScore())
        
        RecordsManager.shared.addGameToFirebase(game) { error in
            if let error = error {
                print("Error adding game: \(error.localizedDescription)")
            } else {
                print("Game added successfully")
            }
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecordsController") as! RecordsController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

