import UIKit

var greeting = "Hello, playground"

func largestAltitude(_ gain: [Int]) -> Int {
    var max: Int = 0
    var sum: Int = 0
    
    for alt in gain {
        sum += alt
        if sum > max { max = sum }
    }
    
    return max
}

largestAltitude([-5,1,5,0,-7])
