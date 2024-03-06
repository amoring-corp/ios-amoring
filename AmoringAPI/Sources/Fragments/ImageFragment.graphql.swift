// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct ImageFragment: AmoringAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ImageFragment on ProfileImage { __typename id file { __typename url } }"#
  }

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

  /// File
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
