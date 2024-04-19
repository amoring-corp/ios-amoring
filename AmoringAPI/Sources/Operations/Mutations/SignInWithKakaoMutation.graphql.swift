// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignInWithKakaoMutation: GraphQLMutation {
  public static let operationName: String = "SignInWithKakao"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SignInWithKakao($idToken: String!) { signInWithKakao(idToken: $idToken) { __typename sessionToken user { __typename id email status role createdAt updatedAt } } }"#
    ))

  public var idToken: String

  public init(idToken: String) {
    self.idToken = idToken
  }

  public var __variables: Variables? { ["idToken": idToken] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("signInWithKakao", SignInWithKakao.self, arguments: ["idToken": .variable("idToken")]),
    ] }

    public var signInWithKakao: SignInWithKakao { __data["signInWithKakao"] }

    /// SignInWithKakao
    ///
    /// Parent Type: `SignInResult`
    public struct SignInWithKakao: AmoringAPI.SelectionSet {
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

      /// SignInWithKakao.User
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
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var email: String? { __data["email"] }
        public var status: GraphQLEnum<AmoringAPI.UserStatus>? { __data["status"] }
        public var role: GraphQLEnum<AmoringAPI.UserRole>? { __data["role"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
      }
    }
  }
}
