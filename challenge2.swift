import Foundation



//To do better : 
//Class Engine should have isRunning and power \\
//Person - abstract and do 3 subclasses Tourist, CrewMember and Capitan \\
//Age only to the tourist \\
//Add arrays to the Ship 
//Order as a function wchich takes enum Order or two other functions
//Ship should have two engines
//Capacity is "niekoszerne? :D " -> place with property
//Function to visit and quit place and conditions to enter and isFull

//Assumptions: 
//Ship with 50 shipCrew and 350 -> tourists
//Ship has 2 Engines 2kHP and 4kHP and can work on sunyktabuisly, one at the time or both off
//Every touris is assigned to a 2 or 4 cabin
//Ship has a restarutant and two bars (300, 50, 50)
//Tourist can visit only one attraction or stay in cabin
//Tourist under 18 cannot enter to the bar

class Engine {
    var powerEngine: Double
    var engineStatus: Bool 

    init(powerEngine: Double, engineStatus: Bool){
        self.powerEngine = powerEngine
        self.engineStatus = engineStatus
    }
}


protocol Person {
    var name: String {get}
    var surname: String {get}
    var title: String {get}//capitan, tourist, crew Member    
}


//Dlaczego do tych klas musimy dodawać inity skoro dziedziczy po protocol Person ? (inaczej jest błąd)
class Capitan: Person {

    let name: String
    let surname: String
    var title: String

    init(name: String, surname: String, title: String){
        self.name = name
        self.surname = surname
        self.title = title
    }


    func turnOnEngine(engine: Engine){
        return engine.engineStatus = true
    }

    func turnOffEngine(engine: Engine){
        return engine.engineStatus = false
    }
}

class Tourist: Person {
    let age: Int
    let name: String
    let surname: String
    var title: String
    var location: Facitilies
    var activePlace: String

    init(name: String, surname: String, title: String, age: Int, location: Facitilies, activePlace: String){
        self.name = name
        self.surname = surname
        self.title = title
        self.age = age
        self.location = location
        self.activePlace = activePlace
    }
}

class CrewMember: Person {
      
    let name: String
    let surname: String
    var title: String

    init(name: String, surname: String, title: String){
        self.name = name
        self.surname = surname
        self.title = title
        
    }
}


class Facitilies{

    let capacity: Int
    var currentOccupancy: Int
    let locationName: String //bar or restaurant

    init(capacity: Int, currentOccupancy: Int, locationName: String){
        self.capacity = capacity
        self.currentOccupancy = currentOccupancy
        self.locationName = locationName
    }


    //Lepszym rozwiązaniem byłoby jakby turysta odwiedzał miejsce i tam sprawdzane byłoby occupancy
    func visitPlace(tourist: Tourist){
        if (currentOccupancy != capacity){
           tourist.location.currentOccupancy += 1
           tourist.activePlace = locationName
        }
        else {print("Full. There is no place for more")}
    }

    func quitPlace(tourist: Tourist){
        self.currentOccupancy -= 1
    }

}

class Restaurant: Facitilies{
    
}

class Cabin: Facitilies{
   var whoLivesThere: [Tourist]

    //'super.init' isn't called on all paths before returning from initializer ?? -> Co to znaczy
   init(whoLivesThere: [Tourist], withCapacity capacity: Int, withCurrnetOccupancy currentOccupancy: Int, withName locationName: String){
       self.whoLivesThere = whoLivesThere
       //dlaczego jest potrzebny ten super init ? Jak to działa ? 
       //super init to wywolanie inita z klasy nadrzednej 
       super.init(capacity: capacity, currentOccupancy: currentOccupancy, locationName: locationName)
   }
   
    func addPersonToCabin(tourist: Tourist){
        if(self.capacity != self.currentOccupancy){
            whoLivesThere.append(tourist)
            self.currentOccupancy += 1
        }

        else {
            print("Cabin is full")
        }
    }
    
}

class Bar: Facitilies{

    override func visitPlace(tourist: Tourist){
        if(tourist.age > 18){
            if (currentOccupancy != capacity){
           self.currentOccupancy += 1
           tourist.activePlace = locationName
        }
        else {print("Full. There is no place for more")}
        }
        else {print ("You are too young boii")}
    }
}

class Ship{
    let smallEngine: Engine
    let bigEngine: Engine
    var restarutant: Restaurant
    var firstBar: Bar
    var secondBar: Bar
    let placeOnShip: Int = 400
    let nameOfShip: String

    var crewMember: [CrewMember]
    var tourist: [Tourist]

    init(nameOfShip: String,smallEngine: Engine, bigEngine: Engine, restarutant: Restaurant, firstBar: Bar, secondBar: Bar, crewMember: [CrewMember], tourist: [Tourist]){
        self.nameOfShip = nameOfShip
        self.smallEngine = smallEngine
        self.bigEngine = bigEngine
        self.restarutant = restarutant
        self.firstBar = firstBar
        self.secondBar = secondBar
        self.crewMember = crewMember
        self.tourist = tourist
    }
    

    func workingEngines(smallEngine: Engine, bigEngine: Engine){
        print("Engines status: Small one: \(smallEngine.engineStatus) \n Big one:\(bigEngine.engineStatus)")

        if (smallEngine.engineStatus == true && bigEngine.engineStatus == true){
            print("Current power: \(smallEngine.powerEngine + bigEngine.powerEngine)")
        }

       else if (smallEngine.engineStatus == false && bigEngine.engineStatus == false){
            print("Current power: 0")
        }

        else if (smallEngine.engineStatus == false && bigEngine.engineStatus == true){
            print("Current power: \(bigEngine.powerEngine)")
        }

        else {print("Current power: \(smallEngine.powerEngine)")}

    }

}


var smallEngine = Engine(powerEngine: 2, engineStatus: false)
var bigEngine = Engine(powerEngine: 2, engineStatus: false)

var capitan = Capitan(name: "Capitan", surname: "Morgan", title: "Capitan")
var firstCrewMember = CrewMember(name: "AAA", surname: "BBB", title: "majtek")
var secondCrewMember = CrewMember(name: "", surname: "", title: "lewa burta")

//Błąd turysta nie widzi kabiny
var tourist = Tourist(name: "Bogdan", surname: "Brodacz", 17, location: cabin, activePlace: "None")

//Lub kabina nie będzie widziała turysty bo jeszcze nie istnieje
//Jak to lepiej rozwiązac
var cabin = Cabin(whoLivesThere: tourist,capacity: 4, currentOccupancy: 1, locationName: "Cabin One")

