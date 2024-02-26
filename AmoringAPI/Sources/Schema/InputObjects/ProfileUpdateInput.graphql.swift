// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct ProfileUpdateInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    name: GraphQLNullable<String> = nil,
    birthYear: GraphQLNullable<Int> = nil,
    height: GraphQLNullable<Int> = nil,
    weight: GraphQLNullable<Int> = nil,
    mbti: GraphQLNullable<String> = nil,
    education: GraphQLNullable<String> = nil,
    occupation: GraphQLNullable<String> = nil,
    bio: GraphQLNullable<String> = nil,
    gender: GraphQLNullable<GraphQLEnum<Gender>> = nil,
    images: GraphQLNullable<[ProfileImageInput?]> = nil
  ) {
    __data = InputDict([
      "name": name,
      "birthYear": birthYear,
      "height": height,
      "weight": weight,
      "mbti": mbti,
      "education": education,
      "occupation": occupation,
      "bio": bio,
      "gender": gender,
      "images": images
    ])
  }

  public var name: GraphQLNullable<String> {
    get { __data["name"] }
    set { __data["name"] = newValue }
  }

  public var birthYear: GraphQLNullable<Int> {
    get { __data["birthYear"] }
    set { __data["birthYear"] = newValue }
  }

  public var height: GraphQLNullable<Int> {
    get { __data["height"] }
    set { __data["height"] = newValue }
  }

  public var weight: GraphQLNullable<Int> {
    get { __data["weight"] }
    set { __data["weight"] = newValue }
  }

  public var mbti: GraphQLNullable<String> {
    get { __data["mbti"] }
    set { __data["mbti"] = newValue }
  }

  public var education: GraphQLNullable<String> {
    get { __data["education"] }
    set { __data["education"] = newValue }
  }

  public var occupation: GraphQLNullable<String> {
    get { __data["occupation"] }
    set { __data["occupation"] = newValue }
  }

  public var bio: GraphQLNullable<String> {
    get { __data["bio"] }
    set { __data["bio"] = newValue }
  }

  public var gender: GraphQLNullable<GraphQLEnum<Gender>> {
    get { __data["gender"] }
    set { __data["gender"] = newValue }
  }

  public var images: GraphQLNullable<[ProfileImageInput?]> {
    get { __data["images"] }
    set { __data["images"] = newValue }
  }
}
