// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class VerifyPhoneNumberMutation: GraphQLMutation {
  public static let operationName: String = "VerifyPhoneNumber"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation VerifyPhoneNumber($phoneNumber: String!, $verificationNumber: String!, $verificationToken: String!) { verifyPhoneNumber( phoneNumber: $phoneNumber verificationNumber: $verificationNumber verificationToken: $verificationToken ) }"#
    ))

  public var phoneNumber: String
  public var verificationNumber: String
  public var verificationToken: String

  public init(
    phoneNumber: String,
    verificationNumber: String,
    verificationToken: String
  ) {
    self.phoneNumber = phoneNumber
    self.verificationNumber = verificationNumber
    self.verificationToken = verificationToken
  }

  public var __variables: Variables? { [
    "phoneNumber": phoneNumber,
    "verificationNumber": verificationNumber,
    "verificationToken": verificationToken
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("verifyPhoneNumber", Bool.self, arguments: [
        "phoneNumber": .variable("phoneNumber"),
        "verificationNumber": .variable("verificationNumber"),
        "verificationToken": .variable("verificationToken")
      ]),
    ] }

    public var verifyPhoneNumber: Bool { __data["verifyPhoneNumber"] }
  }
}
