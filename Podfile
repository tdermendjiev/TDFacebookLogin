source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target "TDFacebookLogin" do
    pod 'Alamofire', '~> 4.0'
    pod 'SnapKit', '~> 3.0.0'
    pod 'Realm', '~> 2.0.2'
    pod 'RealmSwift', '~> 2.0.2'
    pod 'SDWebImage', '~>3.8'
    pod 'SwiftyJSON'
    pod 'HexColors'
    pod 'Agrume', :git => 'https://github.com/JanGorman/Agrume.git'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
