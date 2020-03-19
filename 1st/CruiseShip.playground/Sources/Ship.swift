import Foundation

class Ship {
    let shipEngine : ShipEngine
    var crew : [Person]
    let engine2kHP: Engine
    let engine4kHP: Engine
    let barOne: Bar
    let barTwo: Bar
    let restaurant: Restaurant
    var cabin: [Cabin]
    
    init(){
        shipEngine = ShipEngine()
        barOne = Bar()
        barTwo = Bar()
        restaurant = Restaurant()
        cabin = []
        crew = []
        
        engine2kHP = Engine(power: 2, serialNumber: 48382)
        engine4kHP = Engine(power: 4, serialNumber: 32311)
        
        shipEngine.addEngine(engine: engine2kHP)
        shipEngine.addEngine(engine: engine4kHP)
        
        createCabin()
    }
    
    fileprivate func createCabin(){
        for i in 0..<150{
            cabin.append(Cabin(capacity: .two, cabinNumber: (i + 1)))
        }
        for i in 150..<210{
            cabin.append(Cabin(capacity: .four, cabinNumber: (i + 1)))
        }
    }
    
    func freeCabin(numberOfPeople: Int) -> Cabin? {
        for i in 0..<cabin.count{
            if cabin[i].roomLeft >= numberOfPeople {
                return cabin[i]
            }
        }
        return nil
    }
}
