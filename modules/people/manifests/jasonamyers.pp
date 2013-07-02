class people::jasonamyers {
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
        'python'
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

  exec { 'dotfilessubmodules':
    command => 'cd /Users/jasonamyers/my/dotfiles && git submodule init && git submodule update'
  }
}