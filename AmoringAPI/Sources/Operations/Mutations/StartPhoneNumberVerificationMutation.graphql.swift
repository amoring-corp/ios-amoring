// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StartPhoneNumberVerificationMutation: GraphQLMutation {
  public static let operationName: String = "StartPhoneNumberVerification"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation StartPhoneNumberVerification($phoneNumber: String!) { startPhoneNumberVerification(phoneNumber: $phoneNumber) { __typename verificationNumber verificationToken } }"#
    ))

  public var phoneNumber: String

  public init(phoneNumber: String) {
    self.phoneNumber = phoneNumber
  }

  public var __variables: Variables? { ["phoneNumber": phoneNumber] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("startPhoneNumberVerification", StartPhoneNumberVerification.self, arguments: ["phoneNumber": .variable("phoneNumber")]),
    ] }

    public var startPhoneNumberVerification: StartPhoneNumberVerification { __data["startPhoneNumberVerification"] }

    /// StartPhoneNumberVerification
    ///
    /// Parent Type: `VerificationRequestResult`
    public struct StartPhoneNumberVerification: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.VerificationRequestResult }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("verificationNumber", String.self),
        .field("verificationToken", String.self),
      ] }

      public var verificationNumber: String { __data["verificationNumber"] }
      public var verificationToken: String { __data["verificationToken"] }
    }
  }
}
