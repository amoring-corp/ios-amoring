// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct ConversationInfo: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ConversationInfo on Conversation { __typename id status checkIns { __typename ...CheckInInfo } participants { __typename ...UserInfo } messages(take: 100, skip: 0) { __typename ...MessageInfo } createdAt archivedAt updatedAt }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Conversation }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", AmoringAPI.ID.self),
    .field("status", GraphQLEnum<AmoringAPI.ConversationStatus>.self),
    .field("checkIns", [CheckIn?].self),
    .field("participants", [Participant?].self),
    .field("messages", [Message?].self, arguments: [
      "take": 100,
      "skip": 0
    ]),
    .field("createdAt", AmoringAPI.DateTime?.self),
    .field("archivedAt", AmoringAPI.DateTime?.self),
    .field("updatedAt", AmoringAPI.DateTime?.self),
  ] }

  public var id: AmoringAPI.ID { __data["id"] }
  public var status: GraphQLEnum<AmoringAPI.ConversationStatus> { __data["status"] }
  public var checkIns: [CheckIn?] { __data["checkIns"] }
  public var participants: [Participant?] { __data["participants"] }
  public var messages: [Message?] { __data["messages"] }
  public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
  public var archivedAt: AmoringAPI.DateTime? { __data["archivedAt"] }
  public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

  /// CheckIn
  ///
  /// Parent Type: `CheckIn`
  public struct CheckIn: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.CheckIn }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(CheckInInfo.self),
    ] }

    public var id: AmoringAPI.ID { __data["id"] }
    public var businessId: String { __data["businessId"] }
    public var business: Business? { __data["business"] }
    public var profileId: String { __data["profileId"] }
    public var status: GraphQLEnum<AmoringAPI.CheckInStatus> { __data["status"] }
    public var hasTable: Bool { __data["hasTable"] }
    public var checkedInAt: AmoringAPI.DateTime? { __data["checkedInAt"] }
    public var checkedOutAt: AmoringAPI.DateTime? { __data["checkedOutAt"] }
    public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
    public var updatedAt: AmoringAPI.DateTime { __data["updatedAt"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var checkInInfo: CheckInInfo { _toFragment() }
    }

    public typealias Business = CheckInInfo.Business
  }

  /// Participant
  ///
  /// Parent Type: `User`
  public struct Participant: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.User }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(UserInfo.self),
    ] }

    public var id: AmoringAPI.ID { __data["id"] }
    public var email: String? { __data["email"] }
    public var status: GraphQLEnum<AmoringAPI.UserStatus>? { __data["status"] }
    public var role: GraphQLEnum<AmoringAPI.UserRole>? { __data["role"] }
    public var profile: Profile? { __data["profile"] }
    public var business: Business? { __data["business"] }
    public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
    public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
    public var usedLikesCount: Int { __data["usedLikesCount"] }
    public var maxLikes: Int { __data["maxLikes"] }
    public var likesCredit: Int? { __data["likesCredit"] }
    public var loungePassExpiredAt: AmoringAPI.DateTime? { __data["loungePassExpiredAt"] }
    public var invisiblePassExpiredAt: AmoringAPI.DateTime? { __data["invisiblePassExpiredAt"] }
    public var visibleReactionsPassExpiredAt: AmoringAPI.DateTime? { __data["visibleReactionsPassExpiredAt"] }
    public var isPhoneNumberVerified: Bool? { __data["isPhoneNumberVerified"] }
    public var isEmailVerified: Bool? { __data["isEmailVerified"] }
    public var activeCoupons: [ActiveCoupon?]? { __data["activeCoupons"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var userInfo: UserInfo { _toFragment() }
    }

    public typealias Profile = UserInfo.Profile

    public typealias Business = UserInfo.Business

    public typealias ActiveCoupon = UserInfo.ActiveCoupon
  }

  /// Message
  ///
  /// Parent Type: `Message`
  public struct Message: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Message }
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
