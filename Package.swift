// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

import Foundation
import PackageDescription

let sdkName = "FBAudienceNetwork"
let sdkVersion = "6.21.1"
let sdkCdnBaseUrl = "https://github.com/hershalle/FBAudienceNetwork/releases/download"
let sdkChecksum = "bc372b223bec0d922f51c97acc355653f89e8e5e857edf8a85a582364feb0005"

let package = Package(
  name: sdkName,
  platforms: [.iOS(.v13)],
  products: [
    .ansdk
  ],
  dependencies: [
    .package(url: "https://github.com/facebookincubator/QuickLayout", .branch("main"))
  ],
  targets: [
    .wrapper,
    .ansdk
  ]
)

extension Product {
  static let ansdk = library(name: sdkName, targets: ["\(sdkName)Wrapper"])
}

extension Target {
  static let wrapper = target(
    name: "\(sdkName)Wrapper",
    dependencies: [
      "\(sdkName)Binary",
      .product(name: "QuickLayout", package: "QuickLayout"),
      .product(name: "FastResultBuilder", package: "QuickLayout"),
    ],
    path: "Sources"
  )

  static let ansdk = binaryTarget(
    name: "\(sdkName)Binary",
    url: "\(sdkCdnBaseUrl)/\(sdkVersion)/\(sdkName)-\(sdkVersion)-SPM.zip",
    checksum: sdkChecksum
  )
}
