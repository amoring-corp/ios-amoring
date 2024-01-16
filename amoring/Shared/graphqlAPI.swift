//
//  graphqlAPI.swift
//  amoring
//
//  Created by 이준녕 on 1/16/24.
//

import Foundation
import Apollo
import AmoringAPI

final class GraphqlAPI {
    var amoring: ApolloClient = {
        let url = URL(string: "https://amoring-be.antonmaker.com/graphql")!
        
        let configuration = URLSessionConfiguration.default
        guard let sessionToken = UserDefaults.standard.string(forKey: "sessionToken") else {
            return ApolloClient(url: URL(string: "https://amoring-be.antonmaker.com/graphql")!)
        }
        print(sessionToken)
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(sessionToken)"] // Add your headers here
        
        let client = URLSessionClient(sessionConfiguration: configuration)
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let provider = DefaultInterceptorProvider(client: client, store: store)
        let networkTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        return ApolloClient(networkTransport: networkTransport, store: store)
    }()
    
    func authenticatedUserQuery(completion: @escaping (QueryAuthenticatedUserQuery.Data.AuthenticatedUser?) -> Void) {
        amoring.fetch(query: QueryAuthenticatedUserQuery()) { result in
                print("getting session .... ")
                
                switch result {
                case .success(let value):
                    guard value.errors == nil else {
                        print(value.errors)
                        completion(nil)
                        return
                    }
                    
                    guard let data = value.data else {
                        print("WRONG DATA")
                        completion(nil)
                        return
                    }
                    
                    guard let authUser = data.authenticatedUser else {
                        print("NO USER")
                        completion(nil)
                        return
                    }
                    completion(authUser)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(nil)
                }
        }
    }
}
