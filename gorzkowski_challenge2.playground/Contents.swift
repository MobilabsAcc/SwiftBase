import UIKit

// Challenge 2 - The cruise ship

class Ship{
    let shipName: String
    let shipCapacity: Int
    
    init(){
        shipName = "ACC MOBILABS"
        shipCapacity = 400
    }
}
                //let ship = Ship()
                //print(ship.shipName, ship.shipCapacity)

class Engine{
    let enginePower: Int
    var isOperating: Bool
    
    init(enginePower: Int){
        self.enginePower = enginePower
        self.isOperating = false
    }
    
    func startEngine(){
        isOperating = true
    }
    
    func stopEngine(){
        isOperating = false
    }
}
                //let engine1 = Engine(engineID: 1, enginePower: 2)
                //let engine2 = Engine(engineID: 2, enginePower: 4)

class Place{
    var placeName: String
    var placeCurrentCapacity: Int
    var placeCapacity: Int
    var isOver18: Bool
    let cabinCapacity: cabinType?
    
    enum cabinType: Int{
        case twoPerson = 2
        case fourPerson = 4
    }
    
    init(){
        placeName = "New Place"
        isOver18 = true
        placeCurrentCapacity = 0
        placeCapacity = 50
        cabinCapacity = Place.cabinType(rawValue: 2)
    }
}

class Cabin: Place{
    let cabinNumber: Int
    
    
    init(cabinNumber: Int, cabinCapacity: cabinType){
        self.cabinNumber = cabinNumber
        super.init()
        self.placeCapacity = self.cabinCapacity!.rawValue
        self.placeName = "Cabin \(self.cabinNumber)"
        self.isOver18 = false
    }
    
    func addTourist(tourist: Tourist) -> Bool{
        if self.placeCapacity <= self.placeCurrentCapacity{
            print("Tourist \(tourist.personName) cannot be assigned to cabin \(self.cabinNumber).\nTo many tourists in one cabin!\n\n")
            return false
        }
        else{
            self.placeCurrentCapacity += 1
            print("Tourist \(tourist.personName) is now assigned to cabin \(self.cabinNumber).\n\n")
            return true
        }
    }

    func removeTourist(tourist: Tourist){
        self.placeCurrentCapacity -= 1
        print("Tourist \(tourist.personName) is now deassigned from cabin \(self.cabinNumber).\n\n")
    }
}
                //let myCabin = Cabin(cabinName: "123", cabinNumber: 1, cabinCapacity: Cabin.cabinType.twoPerson)
                //print (myCabin.cabinCapacity.rawValue, myCabin.cabinNumber)

class Restaurant: Place{
    init(restaurantName: String, restaurantCapacity: Int, isOver18: Bool){
        super.init()
        self.placeCapacity = restaurantCapacity
        self.placeName = restaurantName
        self.isOver18 = isOver18
    }
}

class Bar: Place{
    init(barName: String, barCapacity: Int, isOver18: Bool){
        super.init()
        self.placeCapacity = barCapacity
        self.placeName = barName
        self.isOver18 = isOver18
    }
}


class Person{
    let personName: String
    let personAge: Int
    var currentPlace: Place?
    
    init(name: String, age: Int){
        self.personName = name
        self.personAge = age
    }
}

class Tourist: Person{
    var cabinNumber: Int?
    
    override init(name: String, age: Int){
        cabinNumber = nil
        super.init(name: name, age: age)
    }
    
    func assignToCabin(cabin: Cabin){
        if cabin.addTourist(tourist: self.self) == true{
            cabin.addTourist(tourist: self.self)
            cabinNumber = cabin.cabinNumber
        }
        else{
            cabin.addTourist(tourist: self.self) // jeśli if!=true to funkcja cabin.addTourist wywali blad wiec po prostu ja wywoluje zeby wywalila ten blad
        }
    }
    
    func changeCabin(oldCabin: Cabin, newCabin: Cabin){
        if cabinNumber == nil{
            print("Tourist \(self.personName) is not assigned to any cabin!\nAssign to cabin first.\n\n")
        }
        else if newCabin.addTourist(tourist: self.self) == true{
            oldCabin.removeTourist(tourist: self.self)
            self.assignToCabin(cabin: newCabin)
        }
        else{
            newCabin.addTourist(tourist: self.self) // jeśli else if!=true to funkcja cabin.addTourist wywali blad wiec po prostu ja wywoluje zeby wywalila ten blad
        }
    }
    
    func deassignFromCabin(cabin: Cabin){
        if cabinNumber == nil{
            print("Tourist \(self.personName) is not assigned to any cabin!\nAssign to cabin first.\n\n")
        }
        else{
            cabin.removeTourist(tourist: self.self)
            cabinNumber = nil
        }
    }
}
                //let turysta1 = Tourist(name: "Jan Kowalski", age: 12, cabinNumber: 43)
                //print (turysta1.personName, turysta1.personAge, turysta1.cabinNumber)
                //turysta1.visitPlace(place: myCabin)

class Crew: Person{
    let isCaptain: Bool
    
    init(name: String, age: Int, isCaptain: Bool){
        self.isCaptain = isCaptain
        super.init(name: name, age: age)
    }
    
    func startEngineOrder(engine: Engine){
        if isCaptain == true {
            engine.startEngine()
        }
        else{
            print("Crew member \(self.personName) do not have permission to give this order!\n\n")
        }
    }
    
    func stopEngineOrder(engine: Engine){
        if isCaptain == true {
                engine.stopEngine()
        }
        else{
            print("Crew member \(self.personName) do not have permission to give this order!\n\n")
        }
    }
}
                //let captain = Crew(name: "adam", age: 34, isCaptain: true)
                //print (captain.personName, captain.personAge, captain.isCaptain)
