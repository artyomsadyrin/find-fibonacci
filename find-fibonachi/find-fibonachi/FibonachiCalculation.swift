//
//  FibonachiCalculation.swift
//  find-fibonachi
//
//  Created by Artsiom Sadyryn on 2/12/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation
import BigInt

class FibonachiCalculation {
    
    private var num1: BigInt = 0
    private var num2: BigInt = 1
    
    func getFibonachiNumber(_ n: Int) -> String {
        var result = String()
        
        //DispatchQueue.global(qos: .userInitiated).async {
            for _ in 0..<n {
                num1 += num2
                num2 = num1 - num2
            }
        //}
        result = "Fib \(n): \(num1)"
        
        return result
    }
    
    
    func createFibonachiArray(_ index: Int) -> [String] {
        var temp = [String]()
        for i in 1...index {
            temp.append(getFibonachiNumber(i))
        }
        return temp
    }
}
