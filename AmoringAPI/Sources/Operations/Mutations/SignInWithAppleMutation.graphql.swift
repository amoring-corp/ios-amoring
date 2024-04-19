// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignInWithAppleMutation: GraphQLMutation {
  public static let operationName: String = "SignInWithApple"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SignInWithApple($code: String!) { signInWithApple(code: $code) { __typename sessionToken user { __typename id email status createdAt updatedAt } } }"#
    ))

  public var code: String

  public init(code: String) {
    self.code = code
  }

  public var __variables: Variables? { ["code": code] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
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

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.SignInResult }
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

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
          .field("email", String?.self),
          .field("status", GraphQLEnum<AmoringAPI.UserStatus>?.self),
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var email: String? { __data["email"] }
        public var status: GraphQLEnum<AmoringAPI.UserStatus>? { __data["status"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
      }
    }
  }
}
