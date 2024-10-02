// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignUpUserMutation: GraphQLMutation {
  public static let operationName: String = "signUpUser"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation signUpUser($email: String!, $password: String!) { signUp(data: { email: $email, password: $password, role: user }) { __typename confirmationNumber emailConfirmationToken user { __typename ...UserInfo } } }"#,
      fragments: [ActiveCouponFragment.self, BusinessHoursInfo.self, BusinessInfo.self, CheckInInfo.self, CouponFragment.self, ImageFragment.self, ProfileInfo.self, UserInfo.self]
    ))

  public var email: String
  public var password: String

  public init(
    email: String,
    password: String
  ) {
    self.email = email
    self.password = password
  }

  public var __variables: Variables? { [
    "email": email,
    "password": password
  ] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("signUp", SignUp.self, arguments: ["data": [
        "email": .variable("email"),
        "password": .variable("password"),
        "role": "user"
      ]]),
    ] }

    public var signUp: SignUp { __data["signUp"] }

    /// SignUp
    ///
    /// Parent Type: `SignUpResult`
    public struct SignUp: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AmoringAPI.Objects.SignUpResult }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("confirmationNumber", String.self),
        .field("emailConfirmationToken", String.self),
        .field("user", User.self),
      ] }

      public var confirmationNumber: String { __data["confirmationNumber"] }
      public var emailConfirmationToken: String { __data["emailConfirmationToken"] }
      public var user: User { __data["user"] }

      /// SignUp.User
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
