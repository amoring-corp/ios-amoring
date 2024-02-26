// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpsertMyBusinessMutation: GraphQLMutation {
  public static let operationName: String = "UpsertMyBusiness"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpsertMyBusiness($data: BusinessUpdateInput!) { upsertMyBusiness(data: $data) { __typename id ownerId owner { __typename id email status role createdAt updatedAt } businessName businessType businessIndustry businessCategory address latitude longitude representativeTitle representativeName phoneNumber registrationNumber category bio createdAt updatedAt } }"#
    ))

  public var data: BusinessUpdateInput

  public init(data: BusinessUpdateInput) {
    self.data = data
  }

  public var __variables: Variables? { ["data": data] }

  public struct Data: AmoringAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("upsertMyBusiness", UpsertMyBusiness.self, arguments: ["data": .variable("data")]),
    ] }

    public var upsertMyBusiness: UpsertMyBusiness { __data["upsertMyBusiness"] }

    /// UpsertMyBusiness
    ///
    /// Parent Type: `Business`
    public struct UpsertMyBusiness: AmoringAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", AmoringAPI.ID.self),
        .field("ownerId", String?.self),
        .field("owner", Owner?.self),
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
      public var ownerId: String? { __data["ownerId"] }
      public var owner: Owner? { __data["owner"] }
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

      /// UpsertMyBusiness.Owner
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
    }
  }
}
