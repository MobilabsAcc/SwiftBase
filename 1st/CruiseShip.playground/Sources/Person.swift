import Foundation

open class Person {
    
    let dateOfBirth: Date
    let name: String
    let lastName: String
    var description : String {
        return "Name: \(name) Last Name: \(lastName)"
    }
    
    public init(dateOfBirthString: String, name: String, lastName: String){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.dateOfBirth = dateFormatter.date(from: dateOfBirthString)!
        
        self.name = name
        self.lastName = lastName
    }
    
    public func getAge() -> Int {
        let calendar = Calendar.current
        let today = Date()
        
        let components = calendar.dateComponents([.year, .month, .day], from: self.dateOfBirth, to: today)
        return components.year ?? 0
    }
}

extension Person : Hashable {
    public static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.lastName == rhs.lastName
    }
    public func hash(into hasher: inout Hasher){
        hasher.combine(name)
        hasher.combine(lastName)
    }
    
}
