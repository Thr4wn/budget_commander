require "json"
require "selenium-webdriver"
require "rspec"
require "fileutils"
include RSpec::Expectations

require 'yaml'
secrets = YAML.load_file('../data/secrets.yml')

USERNAME = secrets['username']
PASSWORD = secrets['password']
CHALLANGE_ANSWER = secrets['challange_answer']

describe "AccountActivity" do

  before(:each) do
    #profile = Selenium::WebDriver::Firefox::Profile.new
    #profile["browser.download.folderList"] = 2
    #profile["browser.download.manager.showWhenStarting"] = false
    #profile["browser.download.dir"] = File.dirname(__FILE__)
    #profile["browser.helperApps.neverAsk.saveToDisk"] = "text/csv"

    #@driver = Selenium::WebDriver.for :firefox #, :profile => profile
    #@driver = Selenium::WebDriver.for :phantomjs
    #@driver = Selenium::WebDriver.for :remote, url: 'http://localhost:4444/wd/hub', desired_capabilities: :firefox
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.pnc.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  if false
  it "test_account_activity" do

    wait = Selenium::WebDriver::Wait.new(:timeout => 10)

    @driver.get(@base_url + "/en/personal-banking.html")
    wait.until{ @driver.find_element(:id=>"userId") }
    #@driver.pause(3000)
    @driver.find_element(:id, "userId").clear
    @driver.find_element(:id, "userId").send_keys USERNAME
    @driver.find_element(:id, "olb-btn").click
    #@driver.pause(4000)
    @driver.find_element(:name, "answer").clear
    @driver.find_element(:name, "answer").send_keys CHALLANGE_ANSWER
    @driver.find_element(:name, "Continue").click
    #@driver.pause(4000)
    @driver.find_element(:name, "password").clear
    @driver.find_element(:name, "password").send_keys PASSWORD
    @driver.find_element(:css, "input.formButton").click
    #@driver.pause(4000)
    @driver.find_element(:link, "Account Activity").click
    #@driver.pause(4000)
    @driver.find_element(:id, "accountactivityTab").click
    #@driver.pause(4000)
    @driver.find_element(:id, "exportBtn").click
    #@driver.pause(2000)
    puts "before clicking download"
    @driver.find_element(:link, "Microsoft Excel (.CSV)").click
    puts "after clicking download"
    #@driver.pause(6000)
  end
  end
  
  def element_present?(how, what)
    $receiver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    $receiver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = $receiver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
