import XCTest

class Cabin {
    enum Capacity{
        case twoPerson
        case fourPerson
        var number: Int {
            switch self {
            case .fourPerson:
                return 4
            case .twoPerson:
                return 2
            }
        }
    }
    
    let capacity: Capacity
    let people: [Person]
    
    init(capacity: Capacity, people: [Person]) {
        self.capacity = capacity
        self.people = people
    }
}

class Person {
}

class CrewMember: Person {
}

class Tourist: Person {
    var friends: [Tourist] = []
    var cabin: Cabin?
    var age: Int
    var isAtTheCabin: Bool = false
    
    init(age: Int) {
        self.age = age
    }
    
    var description: String {
        return "age=\(age), friends: \(friends.count)"
    }
}

class Engine {
    
    enum Power {
        case twokHP
        case fourkHP
    }
    
    let power: Power
    private (set) var running: Bool = false
    
    init(power: Power) {
        self.power = power
    }
    
    func start() {
        running = true
    }
    
    func stop() {
        running = false
    }
}

enum CaptainOrder {
    case runBothEngines
    case stopAllEngines
    case runOnly(Engine.Power)
}

let order = CaptainOrder.runOnly(.twokHP)

class Ship {
    let people: [Person]
    private (set) var cabins: [Cabin] = []
    var tourists: [Tourist] {
        return people.compactMap{ $0 as? Tourist}
    }
    var crew: [CrewMember] {
        return people.compactMap{ $0 as? CrewMember}
    }
    let engines: [Engine] = [Engine(power: .fourkHP), Engine(power: .twokHP)]
    let attractions: [Attraction] = [Bar(), Bar(), Restaurant()]
    
    init(people: [Person]) {
        self.people = people
    }
    
    func assignCabins() {
        
        var touristsWithoutCabin = Array(tourists)
        while !touristsWithoutCabin.isEmpty {
            let capacity: Cabin.Capacity = Bool.random() ? .twoPerson : .fourPerson
            
            let peopleToAssign: [Tourist] = touristsWithoutCabin.suffix(capacity.number)
            touristsWithoutCabin = Array(touristsWithoutCabin.dropLast(capacity.number))
            let cabin = Cabin(capacity: capacity, people: peopleToAssign)
            peopleToAssign.forEach{ $0.cabin = cabin }
            cabins.append(cabin)
        }
    }
    
    func performCaptainOrder(order: CaptainOrder) {
        switch order {
            case .runBothEngines:
                engines.forEach{ $0.start() }
            case .stopAllEngines:
                engines.forEach{ $0.stop() }
        case .runOnly(let enginePowerToRun):
            engines.first(where: {
                $0.power == enginePowerToRun
                
            })?.start()
            engines.first(where: {
                $0.power != enginePowerToRun
                
            })?.stop()
        }
    }
}


class Attraction {

    let capacity: Int
    private (set) var guests: [Tourist] = []
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func add(tourist: Tourist) -> Bool {
        if guests.count < capacity {
            tourist.isAtTheCabin = false
            guests.append(tourist)
            return true
        } else {
            return false
        }
    }
}

class Restaurant: Attraction {
    init() {
        super.init(capacity: 300)
    }
}

class Bar: Attraction {
    
    init() {
        super.init(capacity: 50)
    }
    
    override func add(tourist: Tourist) -> Bool {
        if tourist.age < 18 {
            return false
        } else {
            return super.add(tourist: tourist)
        }
    }
}

func friendGenerator(tourists: [Tourist]) {
    
    for _ in 0...100 {
        let randomTourist = tourists.randomElement()
        let randomNumberOfFriends = Int.random(in: 0...5)
        for _ in 0..<randomNumberOfFriends {
            randomTourist?.friends.append(tourists.randomElement()!)
        }
    }
}

//
//let crew = [CrewMember].init(repeating: CrewMember(), count: 50)
//var tourists: [Tourist] = (0..<300).map{ _ in Tourist(age: Int.random(in: 1...80)) }
//friendGenerator(tourists: tourists)
//let people: [Person] = crew + tourists
//
//let cruiseShip = Ship(people: people)
//
//cruiseShip.assignCabins()
//


class ShipTests: XCTestCase {
    
    var sut: Ship!
    
    func testGiverOrderStartBothWhenBothStoppedThenBothStarted() {
        sut = Ship(people: [])
        sut.performCaptainOrder(order: .runBothEngines)
        XCTAssertTrue(sut.engines[0].running)
        XCTAssertTrue(sut.engines[1].running)
    }
    
    func testGiverOrderStartOneWhenBothStoppedThenOneStarted() {
        sut = Ship(people: [])
        sut.performCaptainOrder(order: .runOnly(.fourkHP))
        XCTAssertTrue(sut.engines.first(where: { $0.power == .fourkHP})!.running)
        XCTAssertFalse(sut.engines.first(where: { $0.power != .fourkHP})!.running)
    }
    
   
}

class AttractionTests: XCTestCase {
    var sut: Attraction!
    
    func testGivenNoTouristsInsideWhenAddingTouristThenTouristAppendedToList() {
        sut = Attraction(capacity: 5)
        let tourist = Tourist(age: 1)
        XCTAssertTrue(sut.add(tourist: tourist), "Failed to add tourist")
        XCTAssertEqual(sut.guests.count, 1, "Wrong number of guests")
    }
    
    func testGivenCapacity1WhenAddingTwoTouristsThenOneeTouristAdded() {
        sut = Attraction(capacity: 1)
        let tourist = Tourist(age: 1)
        sut.add(tourist: tourist)
        XCTAssertFalse(sut.add(tourist: tourist), "Second turist was added exceeding attraction capacity")
        XCTAssertEqual(sut.guests.count, 1, "Wrong number of guests")
    }
    
}

class BarTests: XCTestCase {
    
    var sut: Bar!
    
    func testGivenBarWhenGrownUpEnteringThenAddedToTheList() {
        sut = Bar()
        let tourist = Tourist(age: 45)
        XCTAssertTrue (sut.add(tourist: tourist))
        XCTAssertEqual(sut.guests.count, 1)
    }
    
    func testGivenBarWhenTeenEnteringThenNotAddedToTheList() {
        sut = Bar()
        let tourist = Tourist(age: 15)
        XCTAssertFalse(sut.add(tourist: tourist))
        XCTAssertEqual(sut.guests.count, 0)
    }
}

ShipTests.defaultTestSuite.run()
AttractionTests.defaultTestSuite.run()
BarTests.defaultTestSuite.run()
