Pod::Spec.new do |s|
s.name             = 'ICEImagePickerController'
s.version          = '1.0.0'
s.summary          = '封装对相册和相机的一些常用操作'
s.description      = <<-DESC
TODO: 封装对相册和相机的一些操作, 现有打开相册获取图片,打开相机获取图片
DESC

s.homepage         = 'https://github.com/My-Pod/ICEImagePickerController'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'gumengxiao' => 'rare_ice@163.com' }
s.source           = { :git => 'https://github.com/My-Pod/ICEImagePickerController.git', :tag => s.version.to_s }

s.ios.deployment_target = '7.0'

s.source_files = 'Classes/*.{h,m}'
s.dependency 'ICEPhotoLibrary'

end
