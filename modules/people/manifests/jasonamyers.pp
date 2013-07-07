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

  git::config::global { 'user.email':
    value => 'jason@jasonamyers.com'
  }

  git::config::global { 'user.name':
    value => 'Jason Myers'
  }

  git::config::global { 'push.default':
    value => 'current'
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
}
