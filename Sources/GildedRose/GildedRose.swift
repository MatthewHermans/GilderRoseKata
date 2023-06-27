enum itemTypes: String, CaseIterable {
    case agedBrie = "Aged Brie"
    case sulfuras = "Sulfuras, Hand of Ragnaros"
    case backstagePasses = "Backstage passes to a TAFKAL80ETC concert"
    case ConjuredItem = "Conjured Mana Cake"
}

public class GildedRose {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public func updateQuality() {
        for item in items {
            if item.name != itemTypes.sulfuras.rawValue {
                item.sellIn -= 1
            }
            
            guard item.quality < 50 else { continue }
            let degradeRate = calculateDegradeRateBasedOn(item: item)
            updateItemQuality(item: item, adjustment: degradeRate)
            
            if item.sellIn < 0 {
                handleExpireditems(item: item, degradeRate: degradeRate)
            }
        }
    }
    
    private func updateItemQuality(item: Item, adjustment: Int) {
        let newQuality = item.quality + adjustment
        
        if newQuality > 50 {
            item.quality = 50
        } else if newQuality < 0 {
            item.quality = 0
        } else {
            item.quality = newQuality
        }
    }
    
    private func calculateDegradeRateBasedOn(item: Item) -> Int {
        var degrateRate: Int = -1
        
        guard let itemType = itemTypes(rawValue: item.name) else {
            return degrateRate
        }
        
        switch itemType {
        case .agedBrie:
            degrateRate += 2
        case .sulfuras:
            break
        case .backstagePasses:
            degrateRate += item.sellIn < 6 ? 4 : item.sellIn < 11 ? 3 : 2
        case .ConjuredItem:
            degrateRate -= 1
        }
        
        return degrateRate
    }
    
    private func handleExpireditems(item: Item, degradeRate: Int) {
        guard let itemType = itemTypes(rawValue: item.name) else {
            // this items do 
            updateItemQuality(item: item, adjustment: degradeRate)
            return
        }
        
        switch itemType {
        case .agedBrie, .sulfuras:
            break
        case .backstagePasses:
            item.quality -= item.quality
        case .ConjuredItem:
            updateItemQuality(item: item, adjustment: degradeRate)
        }
    }
}
