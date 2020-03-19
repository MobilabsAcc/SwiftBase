import Foundation

class Bar : Entertainable {

    let capacity: Int
    var poepleInside: [Person]
    
    init(capacity: Int = 50){
        self.capacity = capacity
        poepleInside = []
    }
    
    func enter(enter person: Person) {
        if capacity > poepleInside.count && person.getAge() >= 18 {
            poepleInside.append(person)
            print("\(person.description) entered the restaurant")
        }else if capacity < poepleInside.count{
            print("No room in the bar. Sorry!")
        }else if person.getAge() < 18{
            print("You are not old enought to enter the bar. Try to grow up!")
        }
    }
    func leave(person: Person) {
        poepleInside.removeAll { $0 == person }
    }
    
    func roomLeft() -> Int {
        return capacity - poepleInside.count
    }
    
    func printGuests(){
        poepleInside.forEach{ print( $0.description ) }
    }
}
