// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ActiveCheckInQuery: GraphQLQuery {
  public static let operationName: String = "ActiveCheckIn"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ActiveCheckIn { activeCheckIn { __typename id businessId business { __typename id ownerId businessName businessType businessIndustry businessCategory address addressJibun addressSido addressSigungu addressSigunguCode addressSigunguEnglish addressBname addressZonecode addressDetails latitude longitude representativeTitle representativeName phoneNumber registrationNumber category bio images { __typename id file { __typename url } } checkedInProfiles { __typename id userId name birthYear height weight mbti education occupation bio gender images { __typename id file { __typename url } } interests { __typename id name } age createdAt updatedAt } createdAt updatedAt } profileId status checkedInAt checkedOutAt createdAt updatedAt } }"#
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("activeCheckIn", ActiveCheckIn?.self),
    ] }

    public var activeCheckIn: ActiveCheckIn? { __data["activeCheckIn"] }

    /// ActiveCheckIn
    ///
    /// Parent Type: `CheckIn`
    public struct ActiveCheckIn: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.CheckIn }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("businessId", Int.self),
        .field("business", Business.self),
        .field("profileId", Int.self),
        .field("status", GraphQLEnum<AmoringAPI.CheckInStatus>.self),
        .field("checkedInAt", AmoringAPI.DateTime?.self),
        .field("checkedOutAt", AmoringAPI.DateTime?.self),
        .field("createdAt", AmoringAPI.DateTime.self),
        .field("updatedAt", AmoringAPI.DateTime.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var businessId: Int { __data["businessId"] }
      public var business: Business { __data["business"] }
      public var profileId: Int { __data["profileId"] }
      public var status: GraphQLEnum<AmoringAPI.CheckInStatus> { __data["status"] }
      public var checkedInAt: AmoringAPI.DateTime? { __data["checkedInAt"] }
      public var checkedOutAt: AmoringAPI.DateTime? { __data["checkedOutAt"] }
      public var createdAt: AmoringAPI.DateTime { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime { __data["updatedAt"] }

      /// ActiveCheckIn.Business
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
          .field("addressJibun", String?.self),
          .field("addressSido", String?.self),
          .field("addressSigungu", String?.self),
          .field("addressSigunguCode", String?.self),
          .field("addressSigunguEnglish", String?.self),
          .field("addressBname", String?.self),
          .field("addressZonecode", String?.self),
          .field("addressDetails", String?.self),
          .field("latitude", Double?.self),
          .field("longitude", Double?.self),
          .field("representativeTitle", String?.self),
          .field("representativeName", String?.self),
          .field("phoneNumber", String?.self),
          .field("registrationNumber", String?.self),
          .field("category", String?.self),
          .field("bio", String?.self),
          .field("images", [Image?]?.self),
          .field("checkedInProfiles", [CheckedInProfile?]?.self),
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
        public var addressJibun: String? { __data["addressJibun"] }
        public var addressSido: String? { __data["addressSido"] }
        public var addressSigungu: String? { __data["addressSigungu"] }
        public var addressSigunguCode: String? { __data["addressSigunguCode"] }
        public var addressSigunguEnglish: String? { __data["addressSigunguEnglish"] }
        public var addressBname: String? { __data["addressBname"] }
        public var addressZonecode: String? { __data["addressZonecode"] }
        public var addressDetails: String? { __data["addressDetails"] }
        public var latitude: Double? { __data["latitude"] }
        public var longitude: Double? { __data["longitude"] }
        public var representativeTitle: String? { __data["representativeTitle"] }
        public var representativeName: String? { __data["representativeName"] }
        public var phoneNumber: String? { __data["phoneNumber"] }
        public var registrationNumber: String? { __data["registrationNumber"] }
        public var category: String? { __data["category"] }
        public var bio: String? { __data["bio"] }
        public var images: [Image?]? { __data["images"] }
        public var checkedInProfiles: [CheckedInProfile?]? { __data["checkedInProfiles"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

        /// ActiveCheckIn.Business.Image
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

          /// ActiveCheckIn.Business.Image.File
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

        /// ActiveCheckIn.Business.CheckedInProfile
        ///
        /// Parent Type: `Profile`
        public struct CheckedInProfile: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", AmoringAPI.ID.self),
            .field("userId", Int.self),
            .field("name", String?.self),
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
            .field("age", Int?.self),
            .field("createdAt", AmoringAPI.DateTime?.self),
            .field("updatedAt", AmoringAPI.DateTime?.self),
          ] }

          public var id: AmoringAPI.ID { __data["id"] }
          public var userId: Int { __data["userId"] }
          public var name: String? { __data["name"] }
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
          public var age: Int? { __data["age"] }
          public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
          public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

          /// ActiveCheckIn.Business.CheckedInProfile.Image
          ///
          /// Parent Type: `ProfileImage`
          public struct Image: AmoringAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", AmoringAPI.ID.self),
              .field("file", File.self),
            ] }

            public var id: AmoringAPI.ID { __data["id"] }
            public var file: File { __data["file"] }

            /// ActiveCheckIn.Business.CheckedInProfile.Image.File
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

          /// ActiveCheckIn.Business.CheckedInProfile.Interest
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
      }
    }
  }
}