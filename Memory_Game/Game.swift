import Foundation


class Game: Codable{
    private var playerName: String
    private var attempts: Int
    private var time: String
    private var score: Int
    
    
    init(playerName: String, attempts: Int, time: String, score: Int) {
        self.playerName = playerName
        self.attempts = attempts
        self.time = time
        self.score = score
    }
    
    public func setPlayerName(playerName: String) {
        self.playerName = playerName
    }
    
    public func getPlayerName() -> String {
        return self.playerName
    }
    
    public func setAttempts(attempts: Int) {
        self.attempts = attempts
    }
    
    public func getAttempts() -> Int {
        return self.attempts
    }
    
    public func setTime(time: String) {
        self.time = time
    }
    
    public func getTime() -> String {
        return self.time
    }
    
    public func setScore(score: Int) {
        self.score = score
    }
    
    public func getScore() -> Int {
        return self.score
    }
}
