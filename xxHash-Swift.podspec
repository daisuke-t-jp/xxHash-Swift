Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "xxHash-Swift"
  spec.version      = "1.0.6"
  spec.summary      = "xxHash framework in Swift."

  spec.description  = <<-DESC
                   xxHash framework in Swift.
                   A framework includes xxHash 32/64 bit functions.
 
                   Original xxHash algorithm created by Yann Collet.
                   https://cyan4973.github.io/xxHash/
                   DESC

  spec.homepage     = "https://github.com/daisuke-t-jp/xxHash-Swift"
  spec.screenshots  = "https://raw.githubusercontent.com/daisuke-t-jp/xxHash-Swift/master/doc/header.png"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author       = { "daisuke-t-jp" => "daisuke.t.jp@gmail.com" }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.ios.deployment_target = "10.0"
  spec.osx.deployment_target = "10.12"
  spec.tvos.deployment_target = "12.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/daisuke-t-jp/xxHash-Swift.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "Sources/xxHash/*.{swift}"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.swift_version = "4.2"
  spec.requires_arc = true

end
