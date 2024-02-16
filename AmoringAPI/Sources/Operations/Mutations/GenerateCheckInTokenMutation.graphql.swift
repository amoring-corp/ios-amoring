// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GenerateCheckInTokenMutation: GraphQLMutation {
  public static let operationName: String = "GenerateCheckInToken"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation GenerateCheckInToken { generateCheckInToken { __typename token createdAt expiresAt } }"#
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("generateCheckInToken", GenerateCheckInToken.self),
    ] }

    public var generateCheckInToken: GenerateCheckInToken { __data["generateCheckInToken"] }

    /// GenerateCheckInToken
    ///
    /// Parent Type: `CheckInToken`
    public struct GenerateCheckInToken: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.CheckInToken }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("token", String.self),
        .field("createdAt", AmoringAPI.DateTime.self),
        .field("expiresAt", AmoringAPI.DateTime.self),
      ] }

      public var token: String { __data["token"] }
      public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
      public var expiresAt: AmoringAPI.DateTime { __data["expiresAt"] }
    }
  }
}
