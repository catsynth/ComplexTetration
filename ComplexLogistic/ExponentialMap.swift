//
//  ExponentialMap.swift
//  ComplexTetration
//
//  Created by Amanda Chaudhary on 6/15/23.
//

import Foundation

import Foundation
import ComplexModule
import RealModule
import Accelerate


// the simple version

func exponentialMap (_ a : Complex<Double>) -> Int16 {
    let iterations = 2048
    
    var seen = Set<Complex<Double>>()
    var cycleCandidate : Complex<Double>? = nil
    var cycleLength : Int16? = nil
    
    var i = 0
    var z =  a
    while i <= iterations {
        z = Complex.pow(a,z)
        if cycleCandidate == nil {
            if seen.contains(z) {
                cycleCandidate = z
                cycleLength = 0
            }
        } else {
            if z.isApproximatelyEqual(to: cycleCandidate!, relativeTolerance: 0.00001) {
                return cycleLength!
            }
        }
        if z.real * z.real + z.imaginary * z.imaginary > 1e15 {
            return 0
        }
        seen.insert(z)
        i += 1
        if cycleLength != nil {
            cycleLength = cycleLength! + 1
        }        
    }
    return 10

}



func exponentialMapV (_ a : ArraySlice<Complex<Double>>) -> [Int16]  {
    return a.map(exponentialMap)
}
