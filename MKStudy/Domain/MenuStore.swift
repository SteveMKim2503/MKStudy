//
//  MenuStore.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2020/01/05.
//  Copyright © 2020 MK. All rights reserved.
//

import Foundation
import RxSwift

protocol MenuFetchable {
    func fetchMenus() -> Observable<[MenuItem]>
}

class MenuStore: MenuFetchable {
    
    func fetchMenus() -> Observable<[MenuItem]> {
        struct Response: Decodable {
            let menus: [MenuItem]
        }
        
        return APIService.fetchAllMenusRx()
            .map { data in
                guard let decodedData = try? JSONDecoder().decode(Response.self, from: data) else {
                    throw NSError(domain: "Decoding error", code: -1, userInfo: nil)
                }
                return decodedData.menus
        }
    }
    
}
