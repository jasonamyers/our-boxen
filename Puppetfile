# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

def github(name, version, options = nil)
  options ||= {}
  options[:repo] ||= "boxen/puppet-#{name}"
  mod name, version, :github_tarball => options[:repo]
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "2.3.5"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "dnsmasq",    "1.0.0"
github "gcc",        "1.0.0"
github "git",        "1.2.2"
github "homebrew",   "1.1.2"
github "hub",        "1.0.0"
github "inifile",    "0.9.0", :repo => "cprice404/puppetlabs-inifile"
github "repository", "2.0.2"
github "stdlib",     "4.0.2", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",       "1.0.0"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.
github "osx",           "1.4.0"
github "chrome",        "1.0.0"
github "sublime_text_2","1.0.0"
github "iterm2",        "1.0.0" 
github "heroku",        "1.0.0"
github "dropbox",       "1.0.0"
github "caffeine",      "1.0.0"
github "postgresql",    "1.0.0"
github "sysctl",        "1.0.0"
github "firefox",       "1.0.1"
github "alfred",        "1.1.1"
github "mou",           "1.0.0", :repo => "jasonamyers/puppet-mou"
github "evernote",      "2.0.3", :repo => "jasonamyers/puppet-evernote"
github "libreoffice",   "4.0.4", :repo => "jasonamyers/puppet-libreoffice"
github "postbox",       "3.0.8", :repo => "jasonamyers/puppet-postbox"
github "spectacle",     "1.0.0", :repo => "jasonamyers/puppet-spectacle"
mod "property_list_key",  "0.1.0",   :github_tarball => "glarizza/puppet-property_list_key"

