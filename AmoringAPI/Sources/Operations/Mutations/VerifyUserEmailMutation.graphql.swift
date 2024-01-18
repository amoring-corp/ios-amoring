// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class VerifyUserEmailMutation: GraphQLMutation {
  public static let operationName: String = "verifyUserEmail"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation verifyUserEmail($userId: ID!, $confirmationCode: String!, $emailConfirmationToken: String!) { verifyUserEmailResolver( userId: $userId confirmationNumber: $confirmationCode emailConfirmationToken: $emailConfirmationToken ) }"#
    ))

  public var userId: ID
  public var confirmationCode: String
  public var emailConfirmationToken: String

  public init(
    userId: ID,
    confirmationCode: String,
    emailConfirmationToken: String
  ) {
    self.userId = userId
    self.confirmationCode = confirmationCode
    self.emailConfirmationToken = emailConfirmationToken
  }

  public var __variables: Variables? { [
    "userId": userId,
    "confirmationCode": confirmationCode,
    "emailConfirmationToken": emailConfirmationToken
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("verifyUserEmailResolver", Bool.self, arguments: [
        "userId": .variable("userId"),
        "confirmationNumber": .variable("confirmationCode"),
        "emailConfirmationToken": .variable("emailConfirmationToken")
      ]),
    ] }

    public var verifyUserEmailResolver: Bool { __data["verifyUserEmailResolver"] }
  }
}
