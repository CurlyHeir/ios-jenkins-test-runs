platform :ios, :deployment_target => '8.0'
inhibit_all_warnings!
link_with 'integration-example'
source 'https://github.com/CocoaPods/Specs.git'
pod 'AFNetworking', '~>3.0.4'
pod 'Typhoon', '~> 3.4.5'
pod 'ReactiveCocoa', '~>2.4'

target :IntegrationTests, :exclusive => true do
 link_with 'IntegrationTests'
 pod 'KIF', '~> 3.3.1'
 pod 'OCMockito', '~> 1.4'
end