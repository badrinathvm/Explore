//
//  Service.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/25/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation



//enum CodingKeys: String, CodingKey {
//    case id = "id_name"
//}

enum Result<Model> {
    case success(Model)
    case failure(Error)
}


class Service {
    
    static func makeaBackendCall(completion  : @escaping (Result<Model>) -> Void) {
        
        guard let url = URL.init(string: "https://my-json-server.typicode.com/badrinathvm/service/db") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }else if let data = data {
                    let decoder = JSONDecoder()
                    do{
                        let model = try decoder.decode(Model.self, from: data)
                        print(model)
                        completion(.success(model))
                    }catch let error {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
}
