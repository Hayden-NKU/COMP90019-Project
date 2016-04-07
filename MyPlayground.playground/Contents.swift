//: Playground - noun: a place where people can play

import UIKit

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String, side:Int) {
        self.name = name
        self.numberOfSides = side
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var x = NamedShape(name: "Triangle", side: 3)
x.simpleDescription()