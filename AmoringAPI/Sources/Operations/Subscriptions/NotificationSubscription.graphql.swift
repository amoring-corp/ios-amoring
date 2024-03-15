// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class NotificationSubscription: GraphQLSubscription {
  public static let operationName: String = "Notification"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription Notification { messageSent { __typename ...MessageInfo } }"#,
      fragments: [MessageInfo.self]
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("messageSent", MessageSent?.self),
    ] }

    public var messageSent: MessageSent? { __data["messageSent"] }

    /// MessageSent
    ///
    /// Parent Type: `Message`
    public struct MessageSent: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Message }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(MessageInfo.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var conversationId: String? { __data["conversationId"] }
      public var body: String { __data["body"] }
      public var senderId: String? { __data["senderId"] }
      public var senderAvatarUrl: String? { __data["senderAvatarUrl"] }
      public var senderName: String? { __data["senderName"] }
      public var sender: Sender? { __data["sender"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var messageInfo: MessageInfo { _toFragment() }
      }

      public typealias Sender = MessageInfo.Sender
    }
  }
}
