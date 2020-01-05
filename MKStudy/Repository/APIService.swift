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
    
    static func fetchAllMenus(onComplete: @escaping (Swift.Result<Data, Error>) -> Void) {
        Alamofire.request(URL(string: MenuUrl)!)
            .response { response in
                if let error = response.error {
                    onComplete(.failure(error))
                    return
                }
                guard let data = response.data else {
                    onComplete(.failure(NSError(domain: "no data",
                                                code: response.response!.statusCode,
                                                userInfo: nil))
                    )
                    return
                }
                onComplete(.success(data))
                return
        }
    }
    
//    static func fetchAllMenusRx() -> Observable<Data> {
//        return Observable.create { emitter -> Disposable in
//            fetchAllmenus { response in
//                if let err = response.error {
//                    emitter.onError(err)
//                    return
//                }
//                guard let data = response.data else {
//                    let error = NSError(domain: "no data",
//                                        code: response.response!.statusCode,
//                                        userInfo: nil)
//                    emitter.onError(error)
//                    return
//                }
//                emitter.onNext(data)
//                emitter.onCompleted()
//            }
//            return Disposables.create()
//        }
//    }
        
        
//    static func fetchAllmenus(onComplete: @escaping (DefaultDataResponse) -> Void) {
//        Alamofire.request(URL(string: MenuUrl)!,
//                          method: .get,
//                          parameters: nil,
//                          encoding: URLEncoding.default,
//                          headers: nil
//        ).response { response in
//            onComplete(response)
//            return
//        }
//    }
    
    
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

