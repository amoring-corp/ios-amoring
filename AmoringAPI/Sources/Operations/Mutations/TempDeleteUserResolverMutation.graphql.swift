// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class TempDeleteUserResolverMutation: GraphQLMutation {
  public static let operationName: String = "TempDeleteUserResolver"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation TempDeleteUserResolver($id: ID!) { tempDeleteUserResolver(id: $id) { __typename id email } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("tempDeleteUserResolver", TempDeleteUserResolver.self, arguments: ["id": .variable("id")]),
    ] }

    public var tempDeleteUserResolver: TempDeleteUserResolver { __data["tempDeleteUserResolver"] }

    /// TempDeleteUserResolver
    ///
    /// Parent Type: `User`
    public struct TempDeleteUserResolver: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("email", String?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var email: String? { __data["email"] }
    }
  }
}
