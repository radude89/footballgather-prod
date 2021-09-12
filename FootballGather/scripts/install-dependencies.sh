#!/bin/sh

echo "Checking for gems"

cd FootballGather
brew update --verbose

if [ -e "Gemfile" ]; then
  echo "Installing gems"
  gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"
  bundle config path vendor/bundle
  bundle install || echo "Failed to install bundle"
fi
