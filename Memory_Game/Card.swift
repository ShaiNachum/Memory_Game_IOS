import Foundation

class Card {
    private var name: String
    private var id: Int
    private var flipped: Bool
    
    
    init(name: String, id: Int){
        self.name = name
        self.id = id
        flipped = false
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getId() -> Int {
        return self.id
    }
    
    public func isFlipped() -> Bool {
        return self.flipped
    }
    
    public func setFlipped(flipped: Bool) {
        self.flipped = flipped
    }
}
