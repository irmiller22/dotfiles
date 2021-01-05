brew install gpg2

gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby

rvm install 3.0.0
rvm use 3.0.0 --default

gem install consular
gem install consular-osx
gem install lunchy
gem install pygmentize
