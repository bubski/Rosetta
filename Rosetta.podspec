Pod::Spec.new do |spec|
  spec.name                  = 'Rosetta'
  spec.version               = '1.1.0'
  spec.summary               = 'Swift JSON mapper'
  spec.homepage              = 'https://github.com/bartekchlebek/Rosetta'
  spec.license               = { :type => 'MIT' }
  spec.author                = { 'Bartek Chlebek' => 'bartek.chlebek@gmail.com' }
  spec.social_media_url      = 'http://twitter.com/bartekchlebek'
  spec.source                = { :git => 'https://github.com/bartekchlebek/Rosetta.git', :tag => "#{spec.version}" }
  spec.source_files          = 'Rosetta/*.swift'
  spec.requires_arc          = true
  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.10'
end
