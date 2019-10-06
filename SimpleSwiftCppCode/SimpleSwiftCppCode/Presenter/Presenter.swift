//
//  Presenter.swift
//  SimpleSwiftCppCode
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import Foundation

protocol PresneterProtocol {
    var serviceCall: ServiceCall? { get set }
    var delegate: ViewControllerProtocol? { get set }
    func fetchNumbers(completion: @escaping ([TableViewData])-> Void)
}
struct TableViewData {
    let key: UInt8
    let value: [(UInt8,Bool)]
}
class Presenter: PresneterProtocol {

    var numberParser = NumberParser()
    var delegate: ViewControllerProtocol?
    var serviceCall: ServiceCall?
    var data: [UInt8:[(UInt8,Bool)]] = [:]

    func fetchNumbers(completion: @escaping ([TableViewData])-> Void) {
        
        serviceCall?.fetchNumbers { [weak self] result in
            switch result {
            case .success(let numberData):
                guard let numbers = numberData.numbers else {
                    DispatchQueue.main.async {
                        self?.delegate?.showErrorMessage(message: "Bad data input.")
                    }
                    return
                }
                for number in numbers {
                    if  let item = self?.numberParser.getItem(number),
                        let section = self?.numberParser.getSection(number),
                        let checkMark = self?.numberParser.isChecked(number) {
                        
                        if self?.data[section] != nil {
                            self?.data[section]?.append((item, checkMark))
                        } else {
                            self?.data[section] = [(item, checkMark)]
                        }
                    }
                    
                }
                let tableViewData = self?.data.enumerated().sorted {
                    //let (offset, (key, value)) = arg0
                    return $0.element.key < $1.element.key
                    }.map { items -> TableViewData in
                        let values = items.element.value.sorted { (arg0, arg1) -> Bool in
                            return arg0.0 < arg1.0
                        }
                        return TableViewData(key: items.element.key, value: values)
                }
                
                DispatchQueue.main.async {
                    if let tableViewData = tableViewData {
                        completion(tableViewData)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.showErrorMessage(message: error.localizedDescription)
                }
            }
        }
    }
}
