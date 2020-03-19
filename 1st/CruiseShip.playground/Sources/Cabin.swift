import Foundation

open class Cabin {
    let cabinNumber: Int
    let capacity: Capacity
    public var roomLeft: Int {
        return capacity.intValue - peopleInTheCabin.count
    }
    var peopleInTheCabin: [Person]
    public var description: String {
        return "number: \(cabinNumber)"
    }
    
    public init(capacity: Capacity, cabinNumber: Int){
        peopleInTheCabin = []
        self.capacity = capacity
        self.cabinNumber = cabinNumber
    }
    
    public func addGuest(person: Person){
        if capacity.intValue > peopleInTheCabin.count {
            peopleInTheCabin.append(person)
            print("\(person.description) added to the cabin \(self.description)")
            
            
        }else{
            print("\(self.description) is full")
        }
    }
    
    public func removeGuest(person: Person){
        peopleInTheCabin.removeAll { $0 == person }
    }
    
    public func listAllGuestInTheCabin(){
        if peopleInTheCabin.isEmpty{
            print("Cabin is empty")
        }else{
            peopleInTheCabin.forEach{ print( $0.description ) }
        }
    }
}

public enum Capacity {
    case two, four

    var intValue : Int {
        switch self {
            case .two:
                return 2
            case .four:
                return 4
        }
    }
}
