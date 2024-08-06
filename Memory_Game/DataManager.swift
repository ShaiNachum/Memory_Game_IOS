import Foundation

class DataManager {
    private var cards: [Card]
    private var pack: [Card]

    
    init() {
        self.cards = []
        self.pack = []
        cards.append(Card(name: "1_of_spades", id: 1))
        cards.append(Card(name: "7_of_spades", id: 7))
        cards.append(Card(name: "8_of_spades", id: 8))
        cards.append(Card(name: "9_of_spades", id: 9))
        cards.append(Card(name: "10_of_spades", id: 10))
        cards.append(Card(name: "11_of_spades", id: 11))
        cards.append(Card(name: "12_of_spades", id: 12))
        cards.append(Card(name: "13_of_spades", id: 13))
    }
    
    public func getPack() -> [Card] {
        for i in 0..<cards.count {
            pack.append(cards[i])
            pack.append(cards[i])
        }

        self.pack = pack.shuffled()
        
        return pack
    }
    
}
