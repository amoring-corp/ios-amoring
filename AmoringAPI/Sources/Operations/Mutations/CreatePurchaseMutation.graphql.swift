// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreatePurchaseMutation: GraphQLMutation {
  public static let operationName: String = "CreatePurchase"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreatePurchase($transactionId: String!) { createPurchase(transactionId: $transactionId) { __typename id } }"#
    ))

  public var transactionId: String

  public init(transactionId: String) {
    self.transactionId = transactionId
  }

  public var __variables: Variables? { ["transactionId": transactionId] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createPurchase", CreatePurchase?.self, arguments: ["transactionId": .variable("transactionId")]),
    ] }

    public var createPurchase: CreatePurchase? { __data["createPurchase"] }

    /// CreatePurchase
    ///
    /// Parent Type: `Purchase`
    public struct CreatePurchase: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Purchase }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID?.self),
      ] }

      public var id: AmoringAPI.ID? { __data["id"] }
    }
  }
}
