// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class QueryAuthenticatedUserQuery: GraphQLQuery {
  public static let operationName: String = "QueryAuthenticatedUser"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query QueryAuthenticatedUser { authenticatedUser { __typename id email status role userProfile { __typename id userId name age birthYear height weight mbti education occupation bio gender images { __typename id file { __typename url } } interests { __typename id name } createdAt updatedAt } business { __typename id ownerId businessName businessType businessIndustry businessCategory address bio representativeTitle representativeName phoneNumber registrationNumber latitude images { __typename id file { __typename url } } longitude createdAt updatedAt } createdAt updatedAt } }"#
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("authenticatedUser", AuthenticatedUser?.self),
    ] }

    public var authenticatedUser: AuthenticatedUser? { __data["authenticatedUser"] }

    /// AuthenticatedUser
    ///
    /// Parent Type: `User`
    public struct AuthenticatedUser: AmoringAPI.SelectionSet {
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

      /// AuthenticatedUser.UserProfile
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

        /// AuthenticatedUser.UserProfile.Image
        ///
        /// Parent Type: `UserProfileImage`
        public struct Image: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.UserProfileImage }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", AmoringAPI.ID.self),
            .field("file", File.self),
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
          public var file: File { __data["file"] }

          /// AuthenticatedUser.UserProfile.Image.File
          ///
          /// Parent Type: `File`
          public struct File: AmoringAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.File }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("url", String?.self),
            ] }

            public var url: String? { __data["url"] }
          }
        }

        /// AuthenticatedUser.UserProfile.Interest
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
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
          public var name: String? { __data["name"] }
        }
      }

      /// AuthenticatedUser.Business
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
          .field("bio", String?.self),
          .field("representativeTitle", String?.self),
          .field("representativeName", String?.self),
          .field("phoneNumber", String?.self),
          .field("registrationNumber", String?.self),
          .field("latitude", Double?.self),
          .field("images", [Image?]?.self),
          .field("longitude", Double?.self),
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
        public var bio: String? { __data["bio"] }
        public var representativeTitle: String? { __data["representativeTitle"] }
        public var representativeName: String? { __data["representativeName"] }
        public var phoneNumber: String? { __data["phoneNumber"] }
        public var registrationNumber: String? { __data["registrationNumber"] }
        public var latitude: Double? { __data["latitude"] }
        public var images: [Image?]? { __data["images"] }
        public var longitude: Double? { __data["longitude"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        /// AuthenticatedUser.Business.Image
        ///
        /// Parent Type: `BusinessImage`
        public struct Image: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessImage }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", AmoringAPI.ID.self),
            .field("file", File.self),
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
          public var file: File { __data["file"] }

          /// AuthenticatedUser.Business.Image.File
          ///
          /// Parent Type: `File`
          public struct File: AmoringAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.File }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("url", String?.self),
            ] }

            public var url: String? { __data["url"] }
          }
        }
      }
    }
  }
}
