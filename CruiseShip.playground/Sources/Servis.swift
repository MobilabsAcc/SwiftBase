import Foundation

open class Service{
    
    var shipToOperate: Ship
    
    public init(){
        shipToOperate = Ship()
    }
    public func addPersontoACabin(guestToAdd: Person){
        guard let cabin = shipToOperate.freeCabin(numberOfPeople: 1) else {
            print("No room left")
            return
        }
        cabin.addGuest(person: guestToAdd)
    }
    
    public func runEngine(type: Int){
        switch type{
            case 2:
                shipToOperate.shipEngine.runEngine(engine: shipToOperate.engine2kHP)
            case 4:
                shipToOperate.shipEngine.runEngine(engine: shipToOperate.engine4kHP)
            default:
                print("No such an engine. Ship has only 2 or 4 kHP")
        }
    }
    
    public func stopEngine(type: Int){
        switch type{
             case 2:
                 shipToOperate.shipEngine.stopEngine(engine: shipToOperate.engine2kHP)
             case 4:
                 shipToOperate.shipEngine.stopEngine(engine: shipToOperate.engine4kHP)
             default:
                 print("No such an engine. Ship has only 2 or 4 kHP")
         }
    }
    
    public func enterBar(type: Int, person: Person){
        switch type{
        case 1:
            shipToOperate.barOne.enter(enter: person)
        case 2:
            shipToOperate.barTwo.enter(enter: person)
        default:
            print("We just have bar 1 or 2")
        }
        
    }
    
    public func leaveBar(type: Int, person: Person){
        switch type{
        case 1:
            shipToOperate.barOne.leave(person: person)
        case 2:
            shipToOperate.barTwo.leave(person: person)
        default:
            print("We just have bar 1 or 2")
        }
    }
    
    public func enterRestaurant(person: Person){
        shipToOperate.restaurant.enter(enter: person)
    }
    
    public func leaveRestaurant(person: Person){
        shipToOperate.restaurant.enter(enter: person)
    }
}
