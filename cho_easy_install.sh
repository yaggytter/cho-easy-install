#!/bin/sh

OS="Linux"
if which apt-get >/dev/null; then
	PKGCMD="sudo apt-get -y install"
else
	PKGCMD="sudo yum -y install"
fi

# MacOSX
if [ "$(uname)" == 'Darwin' ]; then
	PKGCMD="brew install"
	OS="OSX"
fi

# Initialize Linux
if [ "${OS}" == "Linux" ]; then
	${PKGCMD} git ruby python curl
fi	

# Initialize OSX
## Homebrew
if [ "${OS}" == "OSX" ]; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	${PKGCMD} git ruby python curl
fi

# Initialize All OS
## pip
curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | sudo python

# Install package
${PKGCMD} $1
if [ $? -eq 0 ] ; then
  exit 0
fi

sudo pip install $1
if [ $? -eq 0 ] ; then
  exit 0
fi

sudo gem install --no-ri --no-rdoc $1
if [ $? -eq 0 ] ; then
  exit 0
fi
