// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignUpMutation: GraphQLMutation {
  public static let operationName: String = "signUp"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation signUp($email: String!, $password: String!) { signUp(data: { email: $email, password: $password, role: business }) { __typename confirmationNumber emailConfirmationToken user { __typename ...UserInfo } } }"#,
      fragments: [BusinessHoursInfo.self, BusinessInfo.self, ImageFragment.self, ProfileInfo.self, UserInfo.self]
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

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var userInfo: UserInfo { _toFragment() }
        }

        /// SignUp.User.Profile
        ///
        /// Parent Type: `Profile`
        public struct Profile: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Profile }

          public var id: AmoringAPI.ID { __data["id"] }
          public var userId: String { __data["userId"] }
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

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var profileInfo: ProfileInfo { _toFragment() }
          }

          /// SignUp.User.Profile.Image
          ///
          /// Parent Type: `ProfileImage`
          public struct Image: AmoringAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.ProfileImage }

            public var id: AmoringAPI.ID { __data["id"] }
            public var file: File { __data["file"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var imageFragment: ImageFragment { _toFragment() }
            }

            public typealias File = ImageFragment.File
          }

          public typealias Interest = ProfileInfo.Interest
        }

        /// SignUp.User.Business
        ///
        /// Parent Type: `Business`
        public struct Business: AmoringAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AmoringAPI.Objects.Business }

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

          /// SignUp.User.Business.BusinessHour
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
  }
}
