// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignInWithGoogleMutation: GraphQLMutation {
  public static let operationName: String = "signInWithGoogle"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation signInWithGoogle($idToken: String!) { signInWithGoogle(idToken: $idToken) { __typename sessionToken user { __typename id email status role userProfile { __typename id userId name age birthYear height weight mbti education occupation bio gender images { __typename id profileId fileId sort file { __typename id name mimetype url path createdAt updatedAt } createdAt updatedAt } interests { __typename id name categoryId category { __typename id name interests { __typename id } createdAt updatedAt } createdAt updatedAt } createdAt updatedAt } business { __typename id } createdAt updatedAt } } }"#
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
      .field("signInWithGoogle", SignInWithGoogle.self, arguments: ["idToken": .variable("idToken")]),
    ] }

    public var signInWithGoogle: SignInWithGoogle { __data["signInWithGoogle"] }

    /// SignInWithGoogle
    ///
    /// Parent Type: `SignInResult`
    public struct SignInWithGoogle: AmoringAPI.SelectionSet {
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

      /// SignInWithGoogle.User
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
          .field("userProfile", UserProfile?.self),
          .field("business", Business?.self),
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var email: String? { __data["email"] }
        public var status: GraphQLEnum<AmoringAPI.UserStatus>? { __data["status"] }
        public var role: GraphQLEnum<AmoringAPI.UserRole>? { __data["role"] }
        public var userProfile: UserProfile? { __data["userProfile"] }
        public var business: Business? { __data["business"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        /// SignInWithGoogle.User.UserProfile
        ///
        /// Parent Type: `UserProfile`
        public struct UserProfile: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.UserProfile }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", AmoringAPI.ID.self),
            .field("userId", Int.self),
            .field("name", String?.self),
            .field("age", Int?.self),
            .field("birthYear", Int?.self),
            .field("height", Int?.self),
            .field("weight", Int?.self),
            .field("mbti", String?.self),
            .field("education", String?.self),
            .field("occupation", String?.self),
            .field("bio", String?.self),
            .field("gender", GraphQLEnum<AmoringAPI.Gender>?.self),
            .field("images", [Image?]?.self),
            .field("interests", [Interest?]?.self),
            .field("createdAt", AmoringAPI.DateTime?.self),
            .field("updatedAt", AmoringAPI.DateTime?.self),
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
          public var userId: Int { __data["userId"] }
          public var name: String? { __data["name"] }
          public var age: Int? { __data["age"] }
          public var birthYear: Int? { __data["birthYear"] }
          public var height: Int? { __data["height"] }
          public var weight: Int? { __data["weight"] }
          public var mbti: String? { __data["mbti"] }
          public var education: String? { __data["education"] }
          public var occupation: String? { __data["occupation"] }
          public var bio: String? { __data["bio"] }
          public var gender: GraphQLEnum<AmoringAPI.Gender>? { __data["gender"] }
          public var images: [Image?]? { __data["images"] }
          public var interests: [Interest?]? { __data["interests"] }
          public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
          public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

          /// SignInWithGoogle.User.UserProfile.Image
          ///
          /// Parent Type: `UserProfileImage`
          public struct Image: AmoringAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.UserProfileImage }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", AmoringAPI.ID.self),
              .field("profileId", Int.self),
              .field("fileId", Int.self),
              .field("sort", Int.self),
              .field("file", File.self),
              .field("createdAt", AmoringAPI.DateTime?.self),
              .field("updatedAt", AmoringAPI.DateTime?.self),
            ] }

            public var id: AmoringAPI.ID { __data["id"] }
            public var profileId: Int { __data["profileId"] }
            public var fileId: Int { __data["fileId"] }
            public var sort: Int { __data["sort"] }
            public var file: File { __data["file"] }
            public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
            public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

            /// SignInWithGoogle.User.UserProfile.Image.File
            ///
            /// Parent Type: `File`
            public struct File: AmoringAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.File }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("id", AmoringAPI.ID.self),
                .field("name", String?.self),
                .field("mimetype", String?.self),
                .field("url", String?.self),
                .field("path", String?.self),
                .field("createdAt", AmoringAPI.DateTime?.self),
                .field("updatedAt", AmoringAPI.DateTime?.self),
              ] }

              public var id: AmoringAPI.ID { __data["id"] }
              public var name: String? { __data["name"] }
              public var mimetype: String? { __data["mimetype"] }
              public var url: String? { __data["url"] }
              public var path: String? { __data["path"] }
              public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
              public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
            }
          }

          /// SignInWithGoogle.User.UserProfile.Interest
          ///
          /// Parent Type: `Interest`
          public struct Interest: AmoringAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Interest }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", AmoringAPI.ID.self),
              .field("name", String?.self),
              .field("categoryId", Int.self),
              .field("category", Category?.self),
              .field("createdAt", AmoringAPI.DateTime?.self),
              .field("updatedAt", AmoringAPI.DateTime?.self),
            ] }

            public var id: AmoringAPI.ID { __data["id"] }
            public var name: String? { __data["name"] }
            public var categoryId: Int { __data["categoryId"] }
            public var category: Category? { __data["category"] }
            public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
            public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

            /// SignInWithGoogle.User.UserProfile.Interest.Category
            ///
            /// Parent Type: `InterestCategory`
            public struct Category: AmoringAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.InterestCategory }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("id", AmoringAPI.ID.self),
                .field("name", String?.self),
                .field("interests", [Interest?]?.self),
                .field("createdAt", AmoringAPI.DateTime?.self),
                .field("updatedAt", AmoringAPI.DateTime?.self),
              ] }

              public var id: AmoringAPI.ID { __data["id"] }
              public var name: String? { __data["name"] }
              public var interests: [Interest?]? { __data["interests"] }
              public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
              public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

              /// SignInWithGoogle.User.UserProfile.Interest.Category.Interest
              ///
              /// Parent Type: `Interest`
              public struct Interest: AmoringAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Interest }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("id", AmoringAPI.ID.self),
                ] }

                public var id: AmoringAPI.ID { __data["id"] }
              }
            }
          }
        }

        /// SignInWithGoogle.User.Business
        ///
        /// Parent Type: `Business`
        public struct Business: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", AmoringAPI.ID.self),
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
        }
      }
    }
  }
}
