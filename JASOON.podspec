Pod::Spec.new do |s|
  s.name             = 'JASOON'
  s.version          = '0.1.1'
  s.summary          = 'Library to parse JSON to objects and Objects to JSON with operators.'

  s.description      = <<-DESC
Library to parse JSON to objects and Objets to JSON with operators. Parsing infering types. Stop using `guard let`.
This library also will use throws to handling errors. Provide very useful errors for debug.
                       DESC

  s.homepage         = 'https://github.com/julianAlonso/JASOON'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'julianAlonso' => 'julian.alonso.dev@gmail.com' }
  s.source           = { :git => 'https://github.com/julianAlonso/JASOON.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/maisterjuli'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Sources/**/*'

end
