import Foundation

class Engine {
    var serialNumber: Int
    var power: Int
    var description : String {
        return "Engine serial number: \(serialNumber) power: \(power)"
    }
    
    public init(power: Int, serialNumber: Int){
        self.serialNumber = serialNumber
        self.power = power
    }
}

extension Engine : Hashable {
    static func == (lhs: Engine, rhs: Engine) ->  Bool {
        return lhs.power == rhs.power && lhs.serialNumber == rhs.serialNumber
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(power)
        hasher.combine(serialNumber)
    }
}
