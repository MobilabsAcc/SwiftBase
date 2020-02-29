import Foundation

class ShipEngine {
    //list of ship's engines and the bool to see if it's currently working or not
    var listOfEngine : [Engine : Bool]
     
    init(){
        listOfEngine = [:]
    }
    
    func addEngine(engine: Engine){
        listOfEngine[engine] = false
    }
    
    func runEngine(engine: Engine) {
        if listOfEngine[engine] == false {
            listOfEngine[engine] = true
            print("\(engine.description) is now running")
        }else {
            print("\(engine.description) was already running.")
        }
    }
    
    func stopEngine(engine: Engine){
        if listOfEngine[engine] == true{
            listOfEngine[engine] = false
            print("\(engine.description) was turned off.")
        }else {
            print("\(engine.description) wasn't working in a first place.")
        }
    }
}
