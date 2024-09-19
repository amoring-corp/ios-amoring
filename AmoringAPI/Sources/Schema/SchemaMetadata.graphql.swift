// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == AmoringAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == AmoringAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == AmoringAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == AmoringAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Mutation": return AmoringAPI.Objects.Mutation
    case "VerificationRequestResult": return AmoringAPI.Objects.VerificationRequestResult
    case "SignInResult": return AmoringAPI.Objects.SignInResult
    case "User": return AmoringAPI.Objects.User
    case "Profile": return AmoringAPI.Objects.Profile
    case "CheckIn": return AmoringAPI.Objects.CheckIn
    case "Business": return AmoringAPI.Objects.Business
    case "BusinessType": return AmoringAPI.Objects.BusinessType
    case "BusinessHours": return AmoringAPI.Objects.BusinessHours
    case "BusinessImage": return AmoringAPI.Objects.BusinessImage
    case "File": return AmoringAPI.Objects.File
    case "ProfileImage": return AmoringAPI.Objects.ProfileImage
    case "Interest": return AmoringAPI.Objects.Interest
    case "InterestCategory": return AmoringAPI.Objects.InterestCategory
    case "ActiveCoupon": return AmoringAPI.Objects.ActiveCoupon
    case "Coupon": return AmoringAPI.Objects.Coupon
    case "Subscription": return AmoringAPI.Objects.Subscription
    case "Message": return AmoringAPI.Objects.Message
    case "Reaction": return AmoringAPI.Objects.Reaction
    case "Conversation": return AmoringAPI.Objects.Conversation
    case "PasswordResetRequestResult": return AmoringAPI.Objects.PasswordResetRequestResult
    case "Query": return AmoringAPI.Objects.Query
    case "Purchase": return AmoringAPI.Objects.Purchase
    case "SignUpResult": return AmoringAPI.Objects.SignUpResult
    case "CheckInToken": return AmoringAPI.Objects.CheckInToken
    case "UserDevice": return AmoringAPI.Objects.UserDevice
    case "Report": return AmoringAPI.Objects.Report
    case "BusinessDistrict": return AmoringAPI.Objects.BusinessDistrict
    case "BusinessesList": return AmoringAPI.Objects.BusinessesList
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
