#!/usr/bin/env bash
# Set start time so we know how long the bootstrap takes
T="$(date +%s)"

echo 'Updating'
sudo apt-get -y update
sudo apt-get -y install virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
sudo apt-get -y install build-essential

echo 'Installing Zip/Unzip'
sudo apt-get -y install zip unzip

echo 'Installing XVFB'
sudo apt-get -y install xvfb
sudo apt-get -y install -f

#echo 'Installing Google Chrome'
#sudo apt-get -y install google-chrome-stable
#wget -nv https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo dpkg -i google-chrome-stable_current_amd64.deb
#sudo apt-get -y install -f
sudo apt-get -y install firefox
sudo apt-get -y install -f

echo 'Downloading and Moving the ChromeDriver to /usr/local/bin'
cd /tmp
wget -nv "http://chromedriver.storage.googleapis.com/2.8/chromedriver_linux64.zip"
unzip chromedriver_linux64.zip
mv chromedriver /usr/local/bin

#echo 'Installing JRE'
#sudo apt-get -y install default-jdk
#sudo apt-get -y install -f
echo 'Installing ruby'
sudo apt-get install -y ruby
sudo apt-get -y install -f

echo 'Installing Selenium'
sudo gem install selenium-webdriver
sudo gem install rspec
#wget "https://selenium.googlecode.com/files/selenium-server-standalone-2.35.0.jar"
#mv selenium-server-standalone-2.35.0.jar /usr/local/bin



#echo "Starting Xvfb ..."
#export DISPLAY=:10
#cd /vagrant #TODO: do we need this line?
#Xvfb :10 -screen 0 1366x768x24 -ac &
#
#echo "Starting Google Chrome ..."
#google-chrome --remote-debugging-port=9222 &
#echo "Starting Selenium ..."
#cd /usr/local/bin
#java -jar selenium-server-standalone-2.35.0.jar

# Print how long the bootstrap script took to run
T="$(($(date +%s)-T))"
echo "Time bootstrap took: ${T} seconds"

