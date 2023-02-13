//
//  Observable.swift
//  Weather
//
//  Created by Berire Şen Ayvaz on 25.01.2023.
//

import Foundation
class Observable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
    
}
