// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct ActiveCouponFragment: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ActiveCouponFragment on ActiveCoupon { __typename id coupon { __typename ...CouponFragment } expiredAt }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ActiveCoupon }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", String.self),
    .field("coupon", Coupon.self),
    .field("expiredAt", AmoringAPI.DateTime?.self),
  ] }

  public var id: String { __data["id"] }
  public var coupon: Coupon { __data["coupon"] }
  public var expiredAt: AmoringAPI.DateTime? { __data["expiredAt"] }

  /// Coupon
  ///
  /// Parent Type: `Coupon`
  public struct Coupon: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Coupon }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(CouponFragment.self),
    ] }

    public var category: String { __data["category"] }
    public var name: String { __data["name"] }
    public var shortDescription: String { __data["shortDescription"] }
    public var description: String { __data["description"] }
    public var validFrom: AmoringAPI.DateTime? { __data["validFrom"] }
    public var validUntil: AmoringAPI.DateTime? { __data["validUntil"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var couponFragment: CouponFragment { _toFragment() }
    }
  }
}
