platform :ios, '9.0'

plugin 'cocoapods-keys', {
  :project => "Atlas",
  :keys => [
  ]}

def core
  pod 'Log', '= 0.5.0'
end

def test_pods
  pod 'Quick', '= 0.9.1'
  pod 'Nimble', '= 4.0.1'
end

target 'Atlas' do
  use_frameworks!

  core
  pod 'Moya/RxSwift', '= 7.0.1'
  pod 'RealmSwift', '= 1.0.2'
  pod 'Result', '= 2.1.3'
  pod 'ObjectMapper', '= 1.3.0'
  pod 'PINRemoteImage', '= 2.1.4'

  target 'AtlasTests' do
    inherit! :search_paths

    core
    test_pods
  end

  target 'AtlasTests-Integration' do
    inherit! :search_paths

    core
    test_pods
  end
end
