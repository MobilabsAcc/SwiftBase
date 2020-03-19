import Foundation

protocol Entertainable {
    var capacity: Int { get }
    
    func enter(enter person: Person)
    func leave(person: Person)
    func roomLeft() -> Int
}
