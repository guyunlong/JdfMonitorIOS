source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
def shared_pods
    pod 'Masonry'
end

target 'JdfMonitorIOS' do
    shared_pods
end


post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      config.build_settings['VALID_ARCHS'] = 'arm64 i386'
    end
  end
end





