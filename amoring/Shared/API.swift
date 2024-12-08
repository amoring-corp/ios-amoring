//
//  API.swift
//  amoring
//
//  Created by Sergey Li on 12/3/24.
//

import Apollo
import ApolloAPI
import ApolloWebSocket
import SwiftUI

class API {
    @AppStorage("sessionToken") static var sessionToken: String = UserDefaults.standard.string(forKey: "sessionToken") ?? ""

    
    static let split: ApolloClient = {
        
        let webSocketEndpointURL = URL(string: "wss://api.amoring.info/graphql")!
        let webSocketClient = WebSocket(url: webSocketEndpointURL, protocol: .graphql_transport_ws)
        let token = UserDefaults.standard.string(forKey: "sessionToken") ?? ""
        let authPayload: JSONEncodableDictionary = ["Authorization": "Bearer \(token)"]
        let config = WebSocketTransport.Configuration(connectingPayload: authPayload)
        let WSTransport = WebSocketTransport(websocket: webSocketClient, config: config)
        
        let store = ApolloStore()
        let endpointURL = URL(string: "https://api.amoring.info/graphql")!
        let httpTransport = RequestChainNetworkTransport(
            interceptorProvider: NetworkInterceptorsProvider(
                interceptors: [TokenInterceptor(id: "", token: UserDefaults.standard.string(forKey: "sessionToken") ?? "")],
                store: store
            ),
            endpointURL: endpointURL
        )
        
        let splitTransport = SplitNetworkTransport(
            uploadingNetworkTransport: httpTransport,
            webSocketNetworkTransport: WSTransport
        )
        
        return ApolloClient(networkTransport: splitTransport, store: store)
    }()
    
    static let req: ApolloClient = {
        let endpointURL = URL(string: "https://api.amoring.info/graphql")!
        let store = ApolloStore()
        let interceptorProvider = NetworkInterceptorsProvider(
            interceptors: [TokenInterceptor(id: "", token: UserDefaults.standard.string(forKey: "sessionToken") ?? "")],
            store: store
        )
        let networkTransport = RequestChainNetworkTransport(
            interceptorProvider: interceptorProvider, endpointURL: endpointURL
        )
        return ApolloClient(networkTransport: networkTransport, store: store)
    }()
    
    
}

class ApolloManager {
    static let shared = ApolloManager()

    private let store = ApolloStore()
    private let httpEndpoint = URL(string: "https://api.amoring.info/graphql")!
    private let websocketEndpoint = URL(string: "wss://api.amoring.info/graphql")!

    private var token: String = {
        UserDefaults.standard.string(forKey: "sessionToken") ?? ""
    }()

    // HTTP Transport
    private lazy var interceptorProvider: NetworkInterceptorsProvider = {
        return NetworkInterceptorsProvider(
            interceptors: [TokenInterceptor(id: "", token: token)],
            store: store
        )
    }()
    
    private lazy var httpTransport: RequestChainNetworkTransport = {
        return RequestChainNetworkTransport(
            interceptorProvider: interceptorProvider,
            endpointURL: httpEndpoint
        )
    }()

    // WebSocket Transport
    private lazy var websocketTransport: WebSocketTransport = {
        let webSocketClient = WebSocket(url: websocketEndpoint, protocol: .graphql_transport_ws)
        let token = UserDefaults.standard.string(forKey: "sessionToken") ?? ""
        let authPayload: JSONEncodableDictionary = ["Authorization": "Bearer \(token)"]
        let config = WebSocketTransport.Configuration(connectingPayload: authPayload)
    
        return WebSocketTransport(websocket: webSocketClient, config: config)
    }()

    // Split Network Transport
    private lazy var splitTransport: SplitNetworkTransport = {
        return SplitNetworkTransport(
            uploadingNetworkTransport: httpTransport,
            webSocketNetworkTransport: websocketTransport
        )
    }()

    lazy var client = ApolloClient(networkTransport: splitTransport, store: store)

    // Method to update the token for both HTTP and WebSocket
    func updateToken(newToken: String) {
        // Save the token
        self.token = newToken
        UserDefaults.standard.set(newToken, forKey: "sessionToken")

        // Update HTTP transport
        if let interceptor = interceptorProvider.interceptors.first(where: { $0 is TokenInterceptor }) as? TokenInterceptor {
            interceptor.token = newToken
        }

        // Update WebSocket transport
        websocketTransport.updateHeaderValues(["Authorization":newToken])
        websocketTransport.closeConnection()
        websocketTransport.resumeWebSocketConnection()
        
        self.client = ApolloClient(networkTransport: splitTransport, store: store)
    }
}

class NetworkInterceptorsProvider: DefaultInterceptorProvider {
    
    let interceptors: [ApolloInterceptor]
    
    init(interceptors: [ApolloInterceptor], store: ApolloStore) {
        self.interceptors = interceptors
        super.init(store: store)
    }
    
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        self.interceptors.forEach { interceptor in
            interceptors.insert(interceptor, at: 0)
        }
        return interceptors
    }
}

class TokenInterceptor: ApolloInterceptor {
    var id: String
    
    
    var token: String
    
    init(id: String, token: String) {
        self.id = id
        self.token = token
    }
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {
            print("TokenInterceptor: \(token)")
            request.addHeader(name: "Authorization", value: "Bearer \(token)")
            chain.proceedAsync(request: request, response: response, completion: completion)
    }
    
}
