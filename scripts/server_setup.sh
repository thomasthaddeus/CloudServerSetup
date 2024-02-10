#!/bin/bash

# Check if required tools are installed
command -v apt >/dev/null 2>&1 || { echo "apt is required but it's not installed. Exiting."; exit 1; }
command -v git >/dev/null 2>&1 || { echo "git is required but it's not installed. Exiting."; exit 1; }

# Update and install necessary packages
sudo apt update
sudo apt install -y git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev curl gnupg2 build-essential libssl-dev libreadline-dev zlib1g-dev

# Install asdf
sudo apt-get install -y nodejs
sudo apt-get install gcc g++ make
curl -fsSL https://asdf-vm.com/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/asdf-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/asdf-keyring.gpg] https://asdf-vm.com/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/asdf.list > /dev/null
sudo apt update
sudo apt install -y asdf yarn

# Clone asdf and set it up
cd
git clone https://github.com/excid3/asdf.git ~/.asdf
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc
echo 'legacy_version_file = yes' >> ~/.asdfrc
echo 'export EDITOR="code --wait"' >> ~/.bashrc
source "$HOME/.asdf/asdf.sh"

# Set up asdf for the current session
. /usr/share/asdf/asdf.sh

# Install yarn using asdf
asdf plugin add yarn
asdf install yarn 1.22.17
asdf global yarn 1.22.17

# Install and set up Ruby
asdf plugin add ruby
asdf install ruby 3.2.2
asdf global ruby 3.2.2

# Install bundler
gem install bundler

# Update Rubygems
gem update --system

# Install yarn
npm install -g yarn

# Prompt for Git credentials
read -p "Enter your Git username: " MUNAME
read -p "Enter your Git email: " MYEMAIL

# Configure Git
git config --global color.ui true
git config --global user.name "$MYUNAME"
git config --global user.email "$MYEMAIL"

# Generate SSH key for Git
ssh-keygen -t ed25519 -C "$MYEMAIL"
echo "Your new public key is:"
cat ~/.ssh/id_ed25519.pub
echo "Please add this public key to your GitHub account. Press enter once done."
read

# Test SSH connection to GitHub
ssh -T git@github.com

# Install Rails
gem install rails -v 7.0.7

# Install MySQL
sudo apt install -y mysql-server mysql-client libmysqlclient-dev

# Create a new Rails app with MySQL (if it doesn't exist)
if [ ! -d "myapp" ]; then
    rails new myapp -d mysql
    cd myapp

    # Create the database
    rake db:create
else
    echo "Rails app 'myapp' already exists. Skipping creation."
fi

# Start the Rails server
rails server
