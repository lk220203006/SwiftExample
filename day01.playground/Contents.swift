//: A UIKit based Playground for presenting user interface
import UIKit

var myString = "Hello World"
print(myString)
print(myString.characters.count)

var myString2:String?
if myString2 != nil {
    print(myString2!)
}
else{
    print("字符串为nil")
}

let names = ["AT","AE","D","S","BE"]
var reversed = names.sorted { (s1, s2) -> Bool in
    return s1 > s2
}
print(reversed)

var reversed2 = names.sorted(by:>)
print(reversed2)


func makeIncrementor(forIncrement amount:Int) -> () ->Int{
    var runningTotal = 0
    func incrementor() -> Int{
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)
print(incrementByTen())
print(incrementByTen())

class student{
    var studentname:String
    var mark:Int
    var mark2:Int
    init(name:String,mark:Int,mark2:Int) {
        self.studentname = name
        self.mark = mark
        self.mark2 = mark2
    }
}

let studrecord = student(name: "Test", mark: 50, mark2: 60)
print("姓名 \(studrecord.studentname), 成绩 \(studrecord.mark) \(studrecord.mark2)")

