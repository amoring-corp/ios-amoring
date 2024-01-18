// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignUpMutation: GraphQLMutation {
  public static let operationName: String = "signUp"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation signUp($email: String!, $password: String!) { signUp(data: { email: $email, password: $password, role: business }) { __typename confirmationNumber emailConfirmationToken user { __typename id email status role business { __typename id ownerId businessName businessType businessIndustry businessCategory address latitude longitude representativeTitle representativeName phoneNumber registrationNumber category bio createdAt updatedAt } createdAt updatedAt } } }"#
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

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("signUp", SignUp.self, arguments: ["data": [
        "email": .variable("email"),
        "password": .variable("password"),
        "role": "business"
      ]]),
    ] }

    public var signUp: SignUp { __data["signUp"] }

    /// SignUp
    ///
    /// Parent Type: `SignUpResult`
    public struct SignUp: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.SignUpResult }
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

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
          .field("email", String?.self),
          .field("status", GraphQLEnum<AmoringAPI.UserStatus>?.self),
          .field("role", GraphQLEnum<AmoringAPI.UserRole>?.self),
          .field("business", Business?.self),
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var email: String? { __data["email"] }
        public var status: GraphQLEnum<AmoringAPI.UserStatus>? { __data["status"] }
        public var role: GraphQLEnum<AmoringAPI.UserRole>? { __data["role"] }
        public var business: Business? { __data["business"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        /// SignUp.User.Business
        ///
        /// Parent Type: `Business`
        public struct Business: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", AmoringAPI.ID.self),
            .field("ownerId", Int?.self),
            .field("businessName", String?.self),
            .field("businessType", String?.self),
            .field("businessIndustry", String?.self),
            .field("businessCategory", String?.self),
            .field("address", String?.self),
            .field("latitude", Double?.self),
            .field("longitude", Double?.self),
            .field("representativeTitle", String?.self),
            .field("representativeName", String?.self),
            .field("phoneNumber", String?.self),
            .field("registrationNumber", String?.self),
            .field("category", String?.self),
            .field("bio", String?.self),
            .field("createdAt", AmoringAPI.DateTime?.self),
            .field("updatedAt", AmoringAPI.DateTime?.self),
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
          public var ownerId: Int? { __data["ownerId"] }
          public var businessName: String? { __data["businessName"] }
          public var businessType: String? { __data["businessType"] }
          public var businessIndustry: String? { __data["businessIndustry"] }
          public var businessCategory: String? { __data["businessCategory"] }
          public var address: String? { __data["address"] }
          public var latitude: Double? { __data["latitude"] }
          public var longitude: Double? { __data["longitude"] }
          public var representativeTitle: String? { __data["representativeTitle"] }
          public var representativeName: String? { __data["representativeName"] }
          public var phoneNumber: String? { __data["phoneNumber"] }
          public var registrationNumber: String? { __data["registrationNumber"] }
          public var category: String? { __data["category"] }
          public var bio: String? { __data["bio"] }
          public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
          public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
        }
      }
    }
  }
}
