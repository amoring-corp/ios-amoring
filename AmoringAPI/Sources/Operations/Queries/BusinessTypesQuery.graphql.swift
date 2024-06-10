// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class BusinessTypesQuery: GraphQLQuery {
  public static let operationName: String = "BusinessTypes"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query BusinessTypes { businessTypes { __typename id name } }"#
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("businessTypes", [BusinessType]?.self),
    ] }

    public var businessTypes: [BusinessType]? { __data["businessTypes"] }

    /// BusinessType
    ///
    /// Parent Type: `BusinessType`
    public struct BusinessType: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessType }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("name", String.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var name: String { __data["name"] }
    }
  }
}
