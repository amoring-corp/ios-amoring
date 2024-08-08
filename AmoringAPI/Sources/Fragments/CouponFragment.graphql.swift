// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CouponFragment: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CouponFragment on Coupon { __typename category name shortDescription description validFrom validUntil }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Coupon }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("category", String.self),
    .field("name", String.self),
    .field("shortDescription", String.self),
    .field("description", String.self),
    .field("validFrom", AmoringAPI.DateTime?.self),
    .field("validUntil", AmoringAPI.DateTime?.self),
  ] }

  public var category: String { __data["category"] }
  public var name: String { __data["name"] }
  public var shortDescription: String { __data["shortDescription"] }
  public var description: String { __data["description"] }
  public var validFrom: AmoringAPI.DateTime? { __data["validFrom"] }
  public var validUntil: AmoringAPI.DateTime? { __data["validUntil"] }
}
