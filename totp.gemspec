Gem::Specification.new do |s|
  s.name              = "totp"
  s.version           = "1.0.1"
  s.summary           = "Time-based One-Time Passwords"
  s.description       = "Time-based One-Time Passwords"
  s.authors           = ["Michel Martens"]
  s.email             = ["michel@soveran.com"]
  s.homepage          = "http://github.com/soveran/totp"

  s.files = `git ls-files`.split("\n")

  s.add_dependency "base32"
  s.add_development_dependency "cutest"
end
