// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StartEmailVerificationMutation: GraphQLMutation {
  public static let operationName: String = "StartEmailVerification"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation StartEmailVerification { startEmailVerification { __typename verificationNumber verificationToken } }"#
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("startEmailVerification", StartEmailVerification.self),
    ] }

    public var startEmailVerification: StartEmailVerification { __data["startEmailVerification"] }

    /// StartEmailVerification
    ///
    /// Parent Type: `VerificationRequestResult`
    public struct StartEmailVerification: AmoringAPI.SelectionSet {
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
