import UIKit

protocol Duck {
    func fly()
    func quack()
}

class MallardDuck: Duck {
    func fly() {
        print("I'm flying")
    }
    
    func quack() {
        print("quack")
    }
}

protocol Turkey {
    func gobble()
    func fly()
}

class WildTurkey: Turkey {
    func gobble() {
        print("gobble")
    }
    
    func fly() {
        print("I'm flying a short distance")
    }
}

struct TurkeyAdapter: Duck {
    let turkey: Turkey
    
    func fly() {
        for _ in 0..<5 {
            turkey.fly()
        }
    }
    
    func quack() {
        turkey.gobble()
    }
}
