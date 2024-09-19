// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ConversationQuery: GraphQLQuery {
  public static let operationName: String = "Conversation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Conversation($id: ID!) { conversation(id: $id) { __typename ...ConversationInfo } }"#,
      fragments: [ActiveCouponFragment.self, BusinessHoursInfo.self, BusinessInfo.self, CheckInInfo.self, ConversationInfo.self, CouponFragment.self, ImageFragment.self, MessageInfo.self, ProfileInfo.self, UserInfo.self]
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("conversation", Conversation?.self, arguments: ["id": .variable("id")]),
    ] }

    public var conversation: Conversation? { __data["conversation"] }

    /// Conversation
    ///
    /// Parent Type: `Conversation`
    public struct Conversation: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Conversation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(ConversationInfo.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var status: GraphQLEnum<AmoringAPI.ConversationStatus> { __data["status"] }
      public var checkIns: [CheckIn?] { __data["checkIns"] }
      public var participants: [Participant?] { __data["participants"] }
      public var messages: [Message?] { __data["messages"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var archivedAt: AmoringAPI.DateTime? { __data["archivedAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var conversationInfo: ConversationInfo { _toFragment() }
      }

      public typealias CheckIn = ConversationInfo.CheckIn

      public typealias Participant = ConversationInfo.Participant

      public typealias Message = ConversationInfo.Message
    }
  }
}
