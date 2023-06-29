@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    func testFoo() throws {
        let items = [Item(name: "foo", sellIn: 0, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].name, "foo")
    }
    
    func testBrie() {
        let items = [Item(name: itemTypes.agedBrie.rawValue, sellIn: 0, quality: 0),
                     Item(name: itemTypes.agedBrie.rawValue, sellIn: -1, quality: 50),
                     Item(name: itemTypes.agedBrie.rawValue, sellIn: 2, quality: 18)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality , 1)
        XCTAssertEqual(app.items[1].quality, 50)
        XCTAssertEqual(app.items[2].quality, 19)
    }
    
    func testConjuredItems() {
        let items = [Item(name: itemTypes.ConjuredItem.rawValue, sellIn: 3, quality: 5),
                     Item(name: itemTypes.ConjuredItem.rawValue, sellIn: 3, quality: 0),
                     Item(name: itemTypes.ConjuredItem.rawValue, sellIn: 0, quality: 3),
                     Item(name: itemTypes.ConjuredItem.rawValue, sellIn: 0, quality: 2),
                     Item(name: itemTypes.ConjuredItem.rawValue, sellIn: 5, quality: 56)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 3)
        XCTAssertEqual(app.items[1].quality, 0)
        XCTAssertEqual(app.items[2].quality, 0)
        XCTAssertEqual(app.items[3].quality, 50)
    }
    
    func testSulfuras() {
        let items = [Item(name: itemTypes.sulfuras.rawValue, sellIn: 3, quality: 80)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 80)
    }
    
    func testBackStagePasses() {
        let items = [Item(name: itemTypes.backstagePasses.rawValue, sellIn: 7, quality: 20),
                     Item(name: itemTypes.backstagePasses.rawValue, sellIn: 3, quality: 20),
                     Item(name: itemTypes.backstagePasses.rawValue, sellIn: -1, quality: 20),
                     Item(name: itemTypes.backstagePasses.rawValue, sellIn: 3, quality: 49)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 22)
        XCTAssertEqual(app.items[1].quality, 23)
        XCTAssertEqual(app.items[2].quality, 0)
        XCTAssertEqual(app.items[3].quality, 50)
    }
    
    func testRandomProducts() {
        let items = [Item(name: "carrot", sellIn: 6, quality: 20),
                     Item(name: "apple", sellIn: 0, quality: 4),
                     Item(name: "pear", sellIn: 0, quality: 1)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 19)
        XCTAssertEqual(app.items[1].quality, 2)
        XCTAssertEqual(app.items[2].quality, 0)
    }
}
