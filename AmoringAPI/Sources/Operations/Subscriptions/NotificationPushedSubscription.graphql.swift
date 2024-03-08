// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class NotificationPushedSubscription: GraphQLSubscription {
  public static let operationName: String = "NotificationPushed"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription NotificationPushed { notificationPushed { __typename id message { __typename ...MessageInfo } } }"#,
      fragments: [MessageInfo.self]
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("notificationPushed", NotificationPushed?.self),
    ] }

    public var notificationPushed: NotificationPushed? { __data["notificationPushed"] }

    /// NotificationPushed
    ///
    /// Parent Type: `Notification`
    public struct NotificationPushed: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Notification }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("message", Message?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var message: Message? { __data["message"] }

      /// NotificationPushed.Message
      ///
      /// Parent Type: `Message`
      public struct Message: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Message }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(MessageInfo.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var body: String { __data["body"] }
        public var senderId: String? { __data["senderId"] }
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
}
