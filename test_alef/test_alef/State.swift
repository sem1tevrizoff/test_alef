//
//  State.swift
//  test_alef
//
//  Created by sem1 on 25.10.22.
//

import Foundation

struct State {
    
    struct PersonalInformation {
        var name: String
        var age: Int
    }
    
    var people: PersonalInformation?
    var children: [PersonalInformation] = []
    
    private let maxChildren = 5
    
    var childrenCount: Int {
        children.count
    }
    
    var canAddChild: Bool {
        childrenCount < maxChildren
    }
    
    mutating func removeChild(at section: Int) {
        children.remove(at: section)
    }
    
    mutating func removeAll() {
        children.removeAll()
    }
    
    mutating func addEmptyChild() {
        children.append(PersonalInformation(name: "", age: 0))
    }
    
}
