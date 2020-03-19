import UIKit

enum Service: String, CustomStringConvertible {
    case youTube
    case netflix
    case hbo
    
    var description: String {
        return rawValue
    }
}

//    Protocol
protocol TVInterface: CustomStringConvertible {
    
    var activeChannel: Int? { get } // gettable/settable
    var activeService: Service? { get }
    
    func set(channel: Int)
    func start(service: Service)
}

// Protocol extensions
extension TVInterface {
    func start(service: Service) {    }
    
//    Computed property
    var description: String {
//        String interpolation
        return "tv: activeChannel: \(activeChannel), activeService: \(activeService)"
    }
}

class TVSet: TVInterface {
    
    let supports4K: Bool
    var activeChannel: Int?
//    Composition
    var activeService: Service? {
        willSet {
            print("Starting \(newValue)! Hold on!")
        }
        didSet {
            print("Yeeaahh! \(activeService) is started! Previously was \(oldValue) on")
        }
    }
    
    
    init(supports4K: Bool) {
        self.supports4K = supports4K
    }
    
    func set(channel: Int) {
        activeChannel = channel
    }
    
    func start(service: Service) {
        activeService = service
    }
    
    func reset(){
        activeChannel = nil
        activeService = nil
    }
}

class VintageTV: TVInterface {
    
    let blackAndWhiteOnly: Bool
    var activeChannel: Int?
    var activeService: Service?
    
    init(blackAndWhiteOnly: Bool) {
        self.blackAndWhiteOnly = blackAndWhiteOnly
    }
    
    func set(channel: Int) {
        activeChannel = channel
    }
}

class MediaHub {
    
    var numberOftvs: Int {
        return tvs.count
    }
//    Polymorphism + Access Control + read only
    private (set) var tvs: [TVInterface] = []
    
    func install(tv: TVInterface) {
        tvs.append(tv)
    }
    
    func removeTV(at idx: Int) -> Bool {
        guard idx >= 0 && idx < tvs.count else {
            print("\(idx) is an invalid tv idx, broo")
            return false
        }
        let removedTV = tvs.remove(at: idx)
        print("\(removedTV) was removed!")
        return true
    }
    
    func printAll() {
        
//        Different loops
        
//        for i in 0..<tvs.count {
//            let tv = tvs[i]
//            print(tv)
//        }
//        for tv in tvs {
//            print(tv)
//        }
//        tvs.forEach({ tv in
//            print(tv)
//        })
//        tvs.forEach{ print($0) }
        
        var idx = 0
        while idx < tvs.count {
            let tv = tvs[idx]
            print(tv)
            idx += 1
        }
    }
    
}

let grandpaTV = VintageTV(blackAndWhiteOnly: true)
let uncleBobTV = TVSet(supports4K: false)

let hubster = MediaHub()

hubster.install(tv: grandpaTV)
hubster.install(tv: uncleBobTV)


print(hubster.numberOftvs)

// Inheritance
class VirtualTV: TVSet {
    
//    method overriding
    override func set(channel: Int) {
        guard start3DEngine() else {
            print("Loool, failed to start 3d engine :/")
            return
        }
        print("WOILAA, engine running! enjoy XD")
        activeChannel = channel
    }
    
    private func start3DEngine() -> Bool {
        return Int.random(in: 0...1) == 0
    }
}

let myTV = VirtualTV(supports4K: true)
myTV.set(channel: 11)
myTV.start(service: .netflix)

print(myTV.activeChannel)

hubster.install(tv: myTV)
hubster.printAll()

hubster.removeTV(at: 1)
