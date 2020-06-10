//
//  File.swift
//  
//
//  Created by avinance on 6/10/20.
//

import Foundation

public protocol PageInteractorDelegate: class {
    func pageInteractor<T>(_ pageInteractor: PageInteractor<T>, fetchDataForPage page: Int, onDoneAppends: @escaping ([Any]) -> Void)
}
