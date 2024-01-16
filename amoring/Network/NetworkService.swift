//
//  NetworkService.swift
//  amoring
//
//  Created by 이준녕 on 12/8/23.
//

import Foundation
import Apollo
import Network



//final class NetworkService {
//
//    static let shared = NetworkService()
//    
//    private(set) lazy var amoring: ApolloClient = {
//        let url = URL(string: "https://amoring-be.antonmaker.com/graphql")!
//        
//        let configuration = URLSessionConfiguration.default
//        guard let sessionToken = UserDefaults.standard.string(forKey: "sessionToken") else {
//            return ApolloClient(url: URL(string: "https://amoring-be.antonmaker.com/graphql")!)
//        }
//        print(sessionToken)
//        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(sessionToken)"] // Add your headers here
//        
//        let client = URLSessionClient(sessionConfiguration: configuration)
//        let store = ApolloStore(cache: InMemoryNormalizedCache())
//        let provider = DefaultInterceptorProvider(client: client, store: store)
//        let networkTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
//        
//        return ApolloClient(networkTransport: networkTransport, store: store)
//    }()
//    
//    func amoring(token: String) -> ApolloClient {
//        let url = URL(string: "https://amoring-be.antonmaker.com/graphql")!
//        
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
//        
//        let client = URLSessionClient(sessionConfiguration: configuration)
//        let store = ApolloStore(cache: InMemoryNormalizedCache())
//        let provider = DefaultInterceptorProvider(client: client, store: store)
//        let networkTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
//        
//        return ApolloClient(networkTransport: networkTransport, store: store)
//    }
//    
//    private init() { }
//}
