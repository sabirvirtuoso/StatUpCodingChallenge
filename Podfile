# Uncomment the next line to define a global platform for your project

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!

def pods

    pod 'MBProgressHUD', '1.0.0'
    pod 'Alamofire', '4.0.1'
    pod 'ObjectMapper', '2.2.1'
    pod 'AWSCognito'
    pod 'AWSCognitoIdentityProvider'
    pod 'AWSSNS'
    pod 'CocoaLumberjack/Swift', '3.0.0'

end

target 'StatUpCodingChallenge' do
    pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
