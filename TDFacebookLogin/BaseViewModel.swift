//
//  BaseViewModel.swift
//  TDFacebookLogin
//
//  Created by Teodor Dermendzhiev on 1/18/17.
//  Copyright © 2017 Teodor Dermendzhiev. All rights reserved.
//

import Foundation

enum ViewModelState: CustomStringConvertible, Equatable {
    case Idle
    case Loading
    case Error
    
    var description: String {
        switch self {
        case .Error: return "Error"
        case .Idle: return "Idle"
        case .Loading: return "Loading"
        }
    }
    
}

func == (a: ViewModelState, b: ViewModelState) -> Bool {
    switch (a, b) {
    case (.Idle, .Idle): return true
    case (.Loading, .Loading): return true
    case (.Error, .Error): return true
    default: return false
    }
}

protocol ViewModel {
    associatedtype ViewModelType = Self
    var state: ViewModelState { get }
    var willUpdateData: ((ViewModelType) -> Void)? { get set}
    var didUpdateData: ((ViewModelType) -> Void)? { get set}
    func update() -> Void
}

extension ViewModel {
    internal func callWillUpdateData() {
        DispatchQueue.main.async {
            if let this = self as? ViewModelType {
                self.willUpdateData?(this)
            }
        }
    }
    
    internal func callDidUpdateData() {
        DispatchQueue.main.async {
            if let this = self as? ViewModelType {
                self.didUpdateData?(this)
            }
        }
    }
}
