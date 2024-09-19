// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RequestUserPasswordResetMutation: GraphQLMutation {
  public static let operationName: String = "RequestUserPasswordReset"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RequestUserPasswordReset($email: String!) { requestUserPasswordReset(email: $email) { __typename confirmationToken } }"#
    ))

  public var email: String

  public init(email: String) {
    self.email = email
  }

  public var __variables: Variables? { ["email": email] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("requestUserPasswordReset", RequestUserPasswordReset.self, arguments: ["email": .variable("email")]),
    ] }

    public var requestUserPasswordReset: RequestUserPasswordReset { __data["requestUserPasswordReset"] }

    /// RequestUserPasswordReset
    ///
    /// Parent Type: `PasswordResetRequestResult`
    public struct RequestUserPasswordReset: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.PasswordResetRequestResult }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("confirmationToken", String.self),
      ] }

      public var confirmationToken: String { __data["confirmationToken"] }
    }
  }
}
