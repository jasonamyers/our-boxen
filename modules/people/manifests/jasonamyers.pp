class people::jasonamyers {
notify { 'class people::jasonamyers declared': }
  include alfred
  include sysctl
  include chrome
  include sublime_text_2
  include iterm2::dev
  include postgresql
  include dropbox
  include mou
  include evernote
  include libreoffice
  include postbox
  include spectacle

  git::config::global {
    'user.email': value => 'jason@jasonamyers.com';
    'user.name': value => 'Jason Myers';
    'push.default': value => 'current';
    'color.ui': value => 'auto';
    'core.autocrlf': value => 'input';
    'alias.lg': value => "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --all";
    'alias.pu': value => 'git fetch origin -v; git fetch upstream -v; git merge upstream/master';
  }

  $home     = "/Users/${::luser}"
  $my       = "${home}/my"
  $dotfiles = "${my}/dotfiles"

  file { $my:
    ensure => "directory",
  }

  repository { $dotfiles:
    source  => 'jasonamyers/dotfiles',
    require => File[$my]
  }

  heroku::plugin { 'accounts':
    source => 'ddollar/heroku-accounts'
  } 
  package {
    [
        'bash-completion',
        'curl',
        'libevent',
        'mysql',
        'tree',
        'sqlite',
        'gdbm',
        'cmake',
        'pkg-config',
        'readline',
        'python',
        'postgis',
        'geos',
        'proj',
        'gdal'
      ]:
  }
  
  file { "${home}/.bashrc":
    ensure => 'link',
    target => "${dotfiles}/bashrc",
  }

  file { "${home}/.bash_profile":
    ensure => 'link',
    target => "${dotfiles}/bash_profile",
  }
 
  file { "${home}/.vim":
    ensure => 'link',
    target => "${dotfiles}/vimfolder",
  }

  file { "${home}/.vimrc":
    ensure => 'link',
    target => "${dotfiles}/vimrc",
  }

  file { "${home}/.zshrc":
    ensure => 'link',
    target => "${dotfiles}/zshrc",
  }

  file { "${home}/.zsh":
    ensure => 'link',
    target => "${dotfiles}/zsh",
  }

  file { "${home}/.oh-my-zsh":
    ensure => 'link',
    target => "${dotfiles}/oh-my-zsh",
  }

  file { "${home}/.virtualenv":
    ensure => 'link',
    target => "${dotfiles}/virtualenv",
  }

  /*exec { 'dotfiles':*/
    /*command => 'cd ~/my/dotfiles && ./bootstrap.sh'*/
  /*}*/

  exec { 'pythonbrewlink':
    command => 'brew link python --overwrite'
  }

  exec { 'pipinstallvirtualenvwrapper':
    command => 'pip install virtualenvwrapper'
  }

  exec { 'pipinstallflake8':
    command => 'pip install flake8'
  }

  exec { 'pipinstallipython':
    command => 'pip install ipython'
  }

  exec { 'pipinstallnumpy':
    command => 'pip install numpy'
  }

  exec { 'dotfilessubmodules':
    command => 'cd /Users/jasonamyers/my/dotfiles && git submodule init && git submodule update'
  }

  # Changes the default shell to the zsh version we get from Homebrew
  # Uses the osx_chsh type out of boxen/puppet-osx
  osx_chsh { $::luser:
    shell   => '/opt/boxen/homebrew/bin/zsh',
    require => Package['zsh'],
  }

  file_line { 'add zsh to /etc/shells':
    path    => '/etc/shells',
    line    => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh'],
  }

 # Disable Gatekeeper so you can install any package you want
  property_list_key { 'Disable Gatekeeper':
    ensure => present,
    path   => '/var/db/SystemPolicy-prefs.plist',
    key    => 'enabled',
    value  => 'no',
  }

  $my_homedir = "/Users/${::luser}"

  # NOTE: Dock prefs only take effect when you restart the dock
  property_list_key { 'Hide the dock':
    ensure     => present,
    path       => "${my_homedir}/Library/Preferences/com.apple.dock.plist",
    key        => 'autohide',
    value      => true,
    value_type => 'boolean',
    notify     => Exec['Restart the Dock'],
  }

  property_list_key { 'Align the Dock Left':
    ensure     => present,
    path       => "${my_homedir}/Library/Preferences/com.apple.dock.plist",
    key        => 'orientation',
    value      => 'left',
    notify     => Exec['Restart the Dock'],
  }

  property_list_key { 'Lower Right Hotcorner - Screen Saver':
    ensure     => present,
    path       => "${my_homedir}/Library/Preferences/com.apple.dock.plist",
    key        => 'wvous-br-corner',
    value      => 10,
    value_type => 'integer',
    notify     => Exec['Restart the Dock'],
  }

  property_list_key { 'Lower Right Hotcorner - Screen Saver - modifier':
    ensure     => present,
    path       => "${my_homedir}/Library/Preferences/com.apple.dock.plist",
    key        => 'wvous-br-modifier',
    value      => 0,
    value_type => 'integer',
    notify     => Exec['Restart the Dock'],
  }

  exec { 'Restart the Dock':
    command     => '/usr/bin/killall -HUP Dock',
    refreshonly => true,
  }

  file { 'Dock Plist':
    ensure  => file,
    require => [
                 Property_list_key['Lower Right Hotcorner - Screen Saver - modifier'],
                 Property_list_key['Hide the dock'],
                 Property_list_key['Align the Dock Left'],
                 Property_list_key['Lower Right Hotcorner - Screen Saver'],
                 Property_list_key['Lower Right Hotcorner - Screen Saver - modifier'],
               ],
    path    => "${my_homedir}/Library/Preferences/com.apple.dock.plist",
    mode    => '0600',
    notify     => Exec['Restart the Dock'],
  }
}
