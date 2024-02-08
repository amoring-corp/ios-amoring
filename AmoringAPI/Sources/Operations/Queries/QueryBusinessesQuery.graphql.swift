// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class QueryBusinessesQuery: GraphQLQuery {
  public static let operationName: String = "QueryBusinesses"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query QueryBusinesses { businesses { __typename id ownerId owner { __typename id email status role createdAt updatedAt } businessName businessType businessIndustry businessCategory address addressBname addressDetails addressJibun addressSido addressSigungu addressSigunguCode addressSigunguEnglish addressZonecode latitude longitude representativeTitle representativeName phoneNumber registrationNumber category bio images { __typename id businessId fileId sort createdAt updatedAt file { __typename url } } businessHours { __typename openAt closeAt day } createdAt updatedAt } }"#
    ))

  public init() {}

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("businesses", [Business?].self),
    ] }

    public var businesses: [Business?] { __data["businesses"] }

    /// Business
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
        .field("owner", Owner?.self),
        .field("businessName", String?.self),
        .field("businessType", String?.self),
        .field("businessIndustry", String?.self),
        .field("businessCategory", String?.self),
        .field("address", String?.self),
        .field("addressBname", String?.self),
        .field("addressDetails", String?.self),
        .field("addressJibun", String?.self),
        .field("addressSido", String?.self),
        .field("addressSigungu", String?.self),
        .field("addressSigunguCode", String?.self),
        .field("addressSigunguEnglish", String?.self),
        .field("addressZonecode", String?.self),
        .field("latitude", Double?.self),
        .field("longitude", Double?.self),
        .field("representativeTitle", String?.self),
        .field("representativeName", String?.self),
        .field("phoneNumber", String?.self),
        .field("registrationNumber", String?.self),
        .field("category", String?.self),
        .field("bio", String?.self),
        .field("images", [Image?]?.self),
        .field("businessHours", [BusinessHour?]?.self),
        .field("createdAt", AmoringAPI.DateTime?.self),
        .field("updatedAt", AmoringAPI.DateTime?.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var ownerId: Int? { __data["ownerId"] }
      public var owner: Owner? { __data["owner"] }
      public var businessName: String? { __data["businessName"] }
      public var businessType: String? { __data["businessType"] }
      public var businessIndustry: String? { __data["businessIndustry"] }
      public var businessCategory: String? { __data["businessCategory"] }
      public var address: String? { __data["address"] }
      public var addressBname: String? { __data["addressBname"] }
      public var addressDetails: String? { __data["addressDetails"] }
      public var addressJibun: String? { __data["addressJibun"] }
      public var addressSido: String? { __data["addressSido"] }
      public var addressSigungu: String? { __data["addressSigungu"] }
      public var addressSigunguCode: String? { __data["addressSigunguCode"] }
      public var addressSigunguEnglish: String? { __data["addressSigunguEnglish"] }
      public var addressZonecode: String? { __data["addressZonecode"] }
      public var latitude: Double? { __data["latitude"] }
      public var longitude: Double? { __data["longitude"] }
      public var representativeTitle: String? { __data["representativeTitle"] }
      public var representativeName: String? { __data["representativeName"] }
      public var phoneNumber: String? { __data["phoneNumber"] }
      public var registrationNumber: String? { __data["registrationNumber"] }
      public var category: String? { __data["category"] }
      public var bio: String? { __data["bio"] }
      public var images: [Image?]? { __data["images"] }
      public var businessHours: [BusinessHour?]? { __data["businessHours"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      /// Business.Owner
      ///
      /// Parent Type: `User`
      public struct Owner: AmoringAPI.SelectionSet {
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

      /// Business.Image
      ///
      /// Parent Type: `BusinessImage`
      public struct Image: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessImage }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", AmoringAPI.ID.self),
          .field("businessId", Int.self),
          .field("fileId", Int.self),
          .field("sort", Int.self),
          .field("createdAt", AmoringAPI.DateTime?.self),
          .field("updatedAt", AmoringAPI.DateTime?.self),
          .field("file", File.self),
        ] }

        public var id: AmoringAPI.ID { __data["id"] }
        public var businessId: Int { __data["businessId"] }
        public var fileId: Int { __data["fileId"] }
        public var sort: Int { __data["sort"] }
        public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
        public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }
        public var file: File { __data["file"] }

        /// Business.Image.File
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

      /// Business.BusinessHour
      ///
      /// Parent Type: `BusinessHours`
      public struct BusinessHour: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessHours }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("openAt", AmoringAPI.LocalTime.self),
          .field("closeAt", AmoringAPI.LocalTime.self),
          .field("day", GraphQLEnum<AmoringAPI.Day>.self),
        ] }

        public var openAt: AmoringAPI.LocalTime { __data["openAt"] }
        public var closeAt: AmoringAPI.LocalTime { __data["closeAt"] }
        public var day: GraphQLEnum<AmoringAPI.Day> { __data["day"] }
      }
    }
  }
}
