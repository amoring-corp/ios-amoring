// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RedeemUserPasswordResetTokenMutation: GraphQLMutation {
  public static let operationName: String = "RedeemUserPasswordResetToken"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RedeemUserPasswordResetToken($confirmationToken: String!, $confirmationNumber: String!, $email: String!, $password: String!) { redeemUserPasswordResetToken( confirmationToken: $confirmationToken confirmationNumber: $confirmationNumber email: $email password: $password ) }"#
    ))

  public var confirmationToken: String
  public var confirmationNumber: String
  public var email: String
  public var password: String

  public init(
    confirmationToken: String,
    confirmationNumber: String,
    email: String,
    password: String
  ) {
    self.confirmationToken = confirmationToken
    self.confirmationNumber = confirmationNumber
    self.email = email
    self.password = password
  }

  public var __variables: Variables? { [
    "confirmationToken": confirmationToken,
    "confirmationNumber": confirmationNumber,
    "email": email,
    "password": password
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("redeemUserPasswordResetToken", Bool.self, arguments: [
        "confirmationToken": .variable("confirmationToken"),
        "confirmationNumber": .variable("confirmationNumber"),
        "email": .variable("email"),
        "password": .variable("password")
      ]),
    ] }

    public var redeemUserPasswordResetToken: Bool { __data["redeemUserPasswordResetToken"] }
  }
}
