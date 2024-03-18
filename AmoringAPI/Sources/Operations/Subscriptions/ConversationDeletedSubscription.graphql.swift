// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ConversationDeletedSubscription: GraphQLSubscription {
  public static let operationName: String = "ConversationDeleted"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription ConversationDeleted { conversationDeleted { __typename id deletedBy { __typename profile { __typename ...ProfileInfo } } } }"#,
      fragments: [ImageFragment.self, ProfileInfo.self]
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("conversationDeleted", ConversationDeleted?.self),
    ] }

    public var conversationDeleted: ConversationDeleted? { __data["conversationDeleted"] }

    /// ConversationDeleted
    ///
    /// Parent Type: `Conversation`
    public struct ConversationDeleted: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Conversation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("deletedBy", DeletedBy?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var deletedBy: DeletedBy? { __data["deletedBy"] }

      /// ConversationDeleted.DeletedBy
      ///
      /// Parent Type: `User`
      public struct DeletedBy: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("profile", Profile?.self),
        ] }

        public var profile: Profile? { __data["profile"] }

        /// ConversationDeleted.DeletedBy.Profile
        ///
        /// Parent Type: `Profile`
        public struct Profile: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(ProfileInfo.self),
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
          public var userId: String { __data["userId"] }
          public var name: String? { __data["name"] }
          public var age: Int? { __data["age"] }
          public var birthYear: Int? { __data["birthYear"] }
          public var height: Int? { __data["height"] }
          public var weight: Int? { __data["weight"] }
          public var mbti: String? { __data["mbti"] }
          public var education: String? { __data["education"] }
          public var occupation: String? { __data["occupation"] }
          public var bio: String? { __data["bio"] }
          public var gender: GraphQLEnum<AmoringAPI.Gender>? { __data["gender"] }
          public var images: [Image?]? { __data["images"] }
          public var interests: [Interest?]? { __data["interests"] }
          public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
          public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var profileInfo: ProfileInfo { _toFragment() }
          }

          /// ConversationDeleted.DeletedBy.Profile.Image
          ///
          /// Parent Type: `ProfileImage`
          public struct Image: AmoringAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }

            public var id: AmoringAPI.ID { __data["id"] }
            public var file: File { __data["file"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var imageFragment: ImageFragment { _toFragment() }
            }

            public typealias File = ImageFragment.File
          }

          public typealias Interest = ProfileInfo.Interest
        }
      }
    }
  }
}
