import UIKit

private var globalID: Int

class Ship{
    
    let name: String
    var restaurants = [String: Restaurant]()
    var bars = [String: Bar]()
    
    
    init(name: String){
        
        self.name = name

    }
    
}
class Engine{
    
    let power: Int
    let typeOfEngine: types
    var activated: Bool = false
    
    
    enum types: String {
        
        case smallEngine
        case largeEngine
        
        var power: Int {
            switch self{
            case .largeEngine: return 4
            case .smallEngine: return 2
                }
            }
        }
        
    
    init(typeOfEngine:types){
        self.typeOfEngine = typeOfEngine
        self.power = typeOfEngine.power

    }
    
    func switchEngine () -> Bool{
        if activated==false {
            activated = true
            return true
        } else {
            activated = false
            return false
        }
    }

    

}


class Person {
    static var globalID: Int = 1
    
    let id: Int
    let age: Int8
    
    enum Who: String {
        case tourist
        case shipCrew
        case captain
        
    }
    let title: Who
    
    enum Location: String {
        case cabin
        case restaurant
        case bar
    }
    private var personLocation :Location
    
            func getLocation()->Location {
                return personLocation
            }

            func setLocation(location: Location) {
                self.personLocation = location
            }
    
    
    private var friends = [Int: Person]()
    
    init(age:Int8, WhoIsIt who:Who ){
        self.id = Person.globalID
        Person.globalID += 1
        self.age = age
        self.title = who
        self.personLocation = Location.cabin
        
    }
    
    func removeFriends ( friends: [Person]){
        for f in friends {
            self.friends[f.id] = nil
        }
        
    }
    func addFriends (friends: [Person]){
        for f in friends {
            if f.id != id {
                self.friends[f.id] = f
            }
        }
        
    }
    
}



protocol Place {
    var name: String {get}
    var size: Int {get}
}

class EatingPlace: Place{
    
    let name: String
    let size: Int
    var placesLeft: Int
    
    
    init(name: String, size: Int){
        self.name = name
        self.size = size
        self.placesLeft = size
    }
    private var listOfGuests = [Int: Person]()
    
            func getListOfGuests()->[Int: Person]{
                return listOfGuests
            }
            func setListOfGuests(personID: Int, person: Person){
                listOfGuests[personID] = person
            }
    
    
    func removePerson(person: Person) -> Bool {
        
        if listOfGuests.keys.contains(person.id){
            
            listOfGuests[person.id] = nil
            person.setLocation(location: .cabin)
            return true
        }else {return false}
        
    }
    
    func amountOfGuests() -> Int {
        return listOfGuests.count
    }
    
}

class Restaurant:EatingPlace {


    func addPerson( person: Person) -> Bool{
        if !getListOfGuests().keys.contains(person.id) && placesLeft > 0{
            setListOfGuests(personID: person.id, person: person)
            person.setLocation(location: .restaurant)
            placesLeft -= 1
            return true
        }else {
            print("Brak wstepu")
            return false}
        
    }
}

class Bar:EatingPlace {

    func addPerson( person: Person) -> Bool{
        if !getListOfGuests().keys.contains(person.id) && placesLeft>0 && person.age>17{
            setListOfGuests(personID: person.id, person: person)
            person.setLocation(location: .bar)
            placesLeft -= 1
            return true
        }else {
            print("Brak wstepu")
            return false}
        
    }
    
    
}



print("Generalnie sprawdzam jak działa kod")

let Tytanik = Ship(name: "Tytanik")

let guy1 = Person(age: 23, WhoIsIt: .tourist)
let guy2 = Person(age: 23, WhoIsIt: .tourist)
let guy3 = Person(age: 13, WhoIsIt: .tourist)

print(guy3.id)
let Amaro = Restaurant(name: "blabla",size: 300)
print(Amaro.placesLeft)


print(Amaro.placesLeft)

print(Amaro.getListOfGuests())
print(guy3.getLocation())
guy3.setLocation(location: .bar)
guy2.setLocation(location: .bar)
guy1.setLocation(location: .bar)
print(guy3.getLocation())
print("----test dla guy2----")
print(guy2.getLocation())
Amaro.addPerson(person: guy2)
Amaro.addPerson(person: guy1)
Amaro.addPerson(person: guy3)

print(guy2.getLocation())

var klubokawiarnia = Bar(name: "Klubokawiarnia", size: 50)
klubokawiarnia.addPerson(person: guy3)
print(klubokawiarnia.amountOfGuests())

print("----test silników----")
let silnik = Engine(typeOfEngine: .largeEngine)
print(silnik.power)
let silnik2 = Engine(typeOfEngine: .smallEngine)
print(silnik2.power)


print(Person.globalID)
print(Amaro.amountOfGuests())
