Pod::Spec.new do |s|
  s.name             = "Ripe"
  s.version          = "0.1.0"
  s.summary          = "The iOS RIPE SDK."
  s.description      = <<-DESC
                       The iOS RIPE SDK.
                       DESC
  s.homepage         = "https://github.com/ripe-tech/ripe-sdk-ios"
  s.license          = "Apache License, Version 2.0"
  s.author           = { "platforme" => "tech@platforme.com" }
  s.source           = { :git => "https://github.com/ripe-tech/ripe-sdk-ios.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hivesolutions'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'src/classes'
  s.public_header_files = 'src/classes/*.h'
end
