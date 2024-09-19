// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct DistrictFragment: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment DistrictFragment on BusinessDistrict { __typename id code name count }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.BusinessDistrict }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", AmoringAPI.ID.self),
    .field("code", String.self),
    .field("name", String.self),
    .field("count", Int.self),
  ] }

  public var id: AmoringAPI.ID { __data["id"] }
  public var code: String { __data["code"] }
  public var name: String { __data["name"] }
  public var count: Int { __data["count"] }
}
