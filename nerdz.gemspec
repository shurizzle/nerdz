Gem::Specification.new {|g|
    g.name          = 'nerdz'
    g.version       = '0.0.1'
    g.author        = 'shura'
    g.email         = 'shura1991@gmail.com'
    g.homepage      = 'http://github.com/shurizzle/nerdz'
    g.platform      = Gem::Platform::RUBY
    g.description   = 'pretty as tiny library to play with nerdz.eu API'
    g.summary       = g.description.dup
    g.files         = Dir.glob('lib/**/*')
    g.require_path  = 'lib'
    g.executables   = []
    g.has_rdoc      = true

    g.add_dependency('cookiejar')
}
