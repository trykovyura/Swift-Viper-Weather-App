# Uncomment the next line to define a global platform for your project
 platform :ios, '10.2'

target 'weather' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for weather

  # Utils
  pod 'Swinject', '~>2.4.0'
  pod 'ViperMcFlurry', '~>1.5.2'
  pod 'SwiftLint', '~> 0.33.0'

  # UI
  pod 'TableKit', '~>2.6.0'
  pod "ESPullToRefresh", '~>2.7.0'

  # Network
  pod 'Moya/RxSwift', '~>11.0.2'

  # Storage
  pod 'RealmSwift', '~>3.7.1'

end

# Post install hook for generating acknowledgements in settings bundle
post_install do | installer |
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-weather/Pods-weather-acknowledgements.plist', 'Settings.bundle/Acknowledgements.plist', :remove_destination => true)
end
