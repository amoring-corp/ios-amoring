// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignInWithAppleMutation: GraphQLMutation {
  public static let operationName: String = "SignInWithApple"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SignInWithApple($code: String!) { signInWithApple(code: $code) { __typename sessionToken user { __typename ...UserInfo } } }"#,
      fragments: [ActiveCouponFragment.self, BusinessHoursInfo.self, BusinessInfo.self, CheckInInfo.self, CouponFragment.self, ImageFragment.self, ProfileInfo.self, UserInfo.self]
    ))

  public var code: String

  public init(code: String) {
    self.code = code
  }

  public var __variables: Variables? { ["code": code] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("signInWithApple", SignInWithApple.self, arguments: ["code": .variable("code")]),
    ] }

    public var signInWithApple: SignInWithApple { __data["signInWithApple"] }

    /// SignInWithApple
    ///
    /// Parent Type: `SignInResult`
    public struct SignInWithApple: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.SignInResult }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("sessionToken", String?.self),
        .field("user", User?.self),
      ] }

      public var sessionToken: String? { __data["sessionToken"] }
      public var user: User? { __data["user"] }

      /// SignInWithApple.User
      ///
      /// Parent Type: `User`
      public struct User: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(UserInfo.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var email: String? { __data["email"] }
        public var status: GraphQLEnum<AmoringAPI.UserStatus>? { __data["status"] }
        public var role: GraphQLEnum<AmoringAPI.UserRole>? { __data["role"] }
        public var profile: Profile? { __data["profile"] }
        public var business: Business? { __data["business"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
        public var usedLikesCount: Int { __data["usedLikesCount"] }
        public var maxLikes: Int { __data["maxLikes"] }
        public var likesCredit: Int? { __data["likesCredit"] }
        public var loungePassExpiredAt: AmoringAPI.DateTime? { __data["loungePassExpiredAt"] }
        public var invisiblePassExpiredAt: AmoringAPI.DateTime? { __data["invisiblePassExpiredAt"] }
        public var visibleReactionsPassExpiredAt: AmoringAPI.DateTime? { __data["visibleReactionsPassExpiredAt"] }
        public var isPhoneNumberVerified: Bool? { __data["isPhoneNumberVerified"] }
        public var isEmailVerified: Bool? { __data["isEmailVerified"] }
        public var activeCoupons: [ActiveCoupon?]? { __data["activeCoupons"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var userInfo: UserInfo { _toFragment() }
        }

        public typealias Profile = UserInfo.Profile

        public typealias Business = UserInfo.Business

        public typealias ActiveCoupon = UserInfo.ActiveCoupon
      }
    }
  }
}
