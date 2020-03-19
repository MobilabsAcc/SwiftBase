import UIKit

var str = "Hello, playground"
var person = Person(dateOfBirthString: "26/06/1997", name: "George", lastName: "Bush")
var person2 = Person(dateOfBirthString: "26/06/1997", name: "Anna", lastName: "Sath")
var person3 = Person(dateOfBirthString: "26/06/2011", name: "Laura", lastName: "Smith")

person3.getAge()


var service = Service()

service.runEngine(type: 2)
service.addPersontoACabin(guestToAdd: person2)
service.enterBar(type: 1, person: person3)
