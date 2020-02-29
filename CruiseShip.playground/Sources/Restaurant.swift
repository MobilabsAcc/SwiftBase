import Foundation

class Restaurant : Entertainable {

    let capacity: Int
    var poepleInside: [Person]
    
    public init(){
        capacity = 300
        poepleInside = []
    }
    
    func enter(enter person: Person) {
        if capacity > poepleInside.count {
            poepleInside.append(person)
            print("\(person.description) entered the restaurant")
        }else{
            print("No room in the restaurant")
        }
    }
    func leave(person: Person) {
        poepleInside.removeAll { $0 == person }
    }
    
    func roomLeft() -> Int {
        return capacity - poepleInside.count
    }
    
    func printGuests(){
        poepleInside.forEach{ print($0.description) }
    }
}
