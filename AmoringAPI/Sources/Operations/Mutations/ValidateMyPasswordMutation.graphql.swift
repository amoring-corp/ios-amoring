// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ValidateMyPasswordMutation: GraphQLMutation {
  public static let operationName: String = "ValidateMyPassword"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ValidateMyPassword($password: String!) { validateMyPassword(password: $password) }"#
    ))

  public var password: String

  public init(password: String) {
    self.password = password
  }

  public var __variables: Variables? { ["password": password] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("validateMyPassword", Bool.self, arguments: ["password": .variable("password")]),
    ] }

    public var validateMyPassword: Bool { __data["validateMyPassword"] }
  }
}
