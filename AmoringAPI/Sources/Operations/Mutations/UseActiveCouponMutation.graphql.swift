// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UseActiveCouponMutation: GraphQLMutation {
  public static let operationName: String = "UseActiveCoupon"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UseActiveCoupon($id: String!) { useActiveCoupon(id: $id) { __typename ...ActiveCouponFragment } }"#,
      fragments: [ActiveCouponFragment.self, CouponFragment.self]
    ))

  public var id: String

  public init(id: String) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("useActiveCoupon", UseActiveCoupon?.self, arguments: ["id": .variable("id")]),
    ] }

    public var useActiveCoupon: UseActiveCoupon? { __data["useActiveCoupon"] }

    /// UseActiveCoupon
    ///
    /// Parent Type: `ActiveCoupon`
    public struct UseActiveCoupon: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ActiveCoupon }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(ActiveCouponFragment.self),
      ] }

      public var id: String { __data["id"] }
      public var coupon: Coupon { __data["coupon"] }
      public var expiredAt: AmoringAPI.DateTime? { __data["expiredAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var activeCouponFragment: ActiveCouponFragment { _toFragment() }
      }

      /// UseActiveCoupon.Coupon
      ///
      /// Parent Type: `Coupon`
      public struct Coupon: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Coupon }

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
  }
}
