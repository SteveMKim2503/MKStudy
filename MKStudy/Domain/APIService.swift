//
//  APIService.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2020/01/02.
//  Copyright © 2020 MK. All rights reserved.
//

import Foundation
import RxSwift
//import Moya
import Alamofire

let MenuUrl = "https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936"

class APIService {
    static func fetchAllMenusRx() -> Observable<Data> {
        return Observable.create { emitter -> Disposable in
            fetchAllMenus { result in
                switch result {
                    case .success(let data):
                        emitter.onNext(data)
                        emitter.onCompleted()
                    case .failure(let err):
                        emitter.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
    static func fetchAllMenus() {
        Alamofire.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
        Alamofire.request(URL(string: MenuUrl)!)
            .response { response in
                if let error = response.error {
                    
                }
                guard let data = response.data else {
                    
                }
                
        }
    }
    
//    static func fetchAllMenus(onComplete: @escaping (Result<Data, Error>) -> Void) {
//        URLSession.shared.dataTask(with: URL(string: MenuUrl)!) { (data, response, err) in
//            if let err = err {
//                onComplete(.failure(err))
//                return
//            }
//            guard let data = data else {
//                let httpResponse = response as! HTTPURLResponse
//                onComplete(.failure(NSError(domain: "no data",
//                                            code: httpResponse.statusCode,
//                                            userInfo: nil))
//                )
//                return
//            }
//            onComplete(.success(data))
//        }.resume()
//    }
}

