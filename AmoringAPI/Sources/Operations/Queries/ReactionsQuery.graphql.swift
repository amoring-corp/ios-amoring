// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ReactionsQuery: GraphQLQuery {
  public static let operationName: String = "Reactions"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Reactions { reactions(type: like) { __typename ...ReactionInfo } }"#,
      fragments: [BusinessHoursInfo.self, BusinessInfo.self, CheckInInfo.self, ImageFragment.self, ProfileInfo.self, ReactionInfo.self]
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("reactions", [Reaction?].self, arguments: ["type": "like"]),
    ] }

    public var reactions: [Reaction?] { __data["reactions"] }

    /// Reaction
    ///
    /// Parent Type: `Reaction`
    public struct Reaction: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Reaction }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(ReactionInfo.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var byProfileId: String { __data["byProfileId"] }
      public var byProfile: ByProfile { __data["byProfile"] }
      public var toProfileId: String { __data["toProfileId"] }
      public var toProfile: ToProfile { __data["toProfile"] }
      public var type: GraphQLEnum<AmoringAPI.ReactionType> { __data["type"] }
      public var matchedWithId: String? { __data["matchedWithId"] }
      public var isMatched: Bool { __data["isMatched"] }
      public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var reactionInfo: ReactionInfo { _toFragment() }
      }

      public typealias ByProfile = ReactionInfo.ByProfile

      public typealias ToProfile = ReactionInfo.ToProfile
    }
  }
}
