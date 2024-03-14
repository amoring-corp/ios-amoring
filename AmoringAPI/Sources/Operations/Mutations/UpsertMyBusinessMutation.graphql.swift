// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpsertMyBusinessMutation: GraphQLMutation {
  public static let operationName: String = "UpsertMyBusiness"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpsertMyBusiness($data: BusinessUpdateInput!) { upsertMyBusiness(data: $data) { __typename ...BusinessInfo } }"#,
      fragments: [BusinessHoursInfo.self, BusinessInfo.self, ImageFragment.self]
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
        .fragment(BusinessInfo.self),
      ] }

      public var id: AmoringAPI.ID { __data["id"] }
      public var ownerId: String? { __data["ownerId"] }
      public var businessName: String? { __data["businessName"] }
      public var businessType: String? { __data["businessType"] }
      public var businessIndustry: String? { __data["businessIndustry"] }
      public var businessCategory: String? { __data["businessCategory"] }
      public var businessHours: [BusinessHour?]? { __data["businessHours"] }
      public var address: String? { __data["address"] }
      public var addressBname: String? { __data["addressBname"] }
      public var addressDetails: String? { __data["addressDetails"] }
      public var addressJibun: String? { __data["addressJibun"] }
      public var addressSido: String? { __data["addressSido"] }
      public var addressSigungu: String? { __data["addressSigungu"] }
      public var addressSigunguCode: String? { __data["addressSigunguCode"] }
      public var addressSigunguEnglish: String? { __data["addressSigunguEnglish"] }
      public var addressZonecode: String? { __data["addressZonecode"] }
      public var bio: String? { __data["bio"] }
      public var representativeTitle: String? { __data["representativeTitle"] }
      public var representativeName: String? { __data["representativeName"] }
      public var phoneNumber: String? { __data["phoneNumber"] }
      public var registrationNumber: String? { __data["registrationNumber"] }
      public var images: [Image?]? { __data["images"] }
      public var activeCheckIns: [ActiveCheckIn?] { __data["activeCheckIns"] }
      public var latitude: Double? { __data["latitude"] }
      public var longitude: Double? { __data["longitude"] }
      public var createdAt: AmoringAPI.DateTime? { __data["createdAt"] }
      public var updatedAt: AmoringAPI.DateTime? { __data["updatedAt"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var businessInfo: BusinessInfo { _toFragment() }
      }

      /// UpsertMyBusiness.BusinessHour
      ///
      /// Parent Type: `BusinessHours`
      public struct BusinessHour: AmoringAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.BusinessHours }

        public var openAt: AmoringAPI.LocalTime { __data["openAt"] }
        public var closeAt: AmoringAPI.LocalTime { __data["closeAt"] }
        public var day: GraphQLEnum<AmoringAPI.Day> { __data["day"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var businessHoursInfo: BusinessHoursInfo { _toFragment() }
        }
      }

      public typealias Image = BusinessInfo.Image

      public typealias ActiveCheckIn = BusinessInfo.ActiveCheckIn
    }
  }
}
