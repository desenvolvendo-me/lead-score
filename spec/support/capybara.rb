require 'selenium-webdriver'
require 'capybara/rails'

if ENV.key? 'SELENIUM_DRIVER_URL'
  # FIXME: Fazer o capybara funcionar com o selenium OU
  # Fazer o capybara funcionar dentro de um docker
  Capybara.register_driver :selenium_remote do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-gpu')

    Capybara::Selenium::Driver.new(app,
                                   browser: :remote,
                                   url: "http://#{ENV['SELENIUM_SERVER_URL']}:4444/wd/hub",
                                   options: options)
  end

  Capybara.default_driver = :selenium_remote
  Capybara.javascript_driver = :selenium_remote
else
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app,
                                   browser: :chrome)
  end

  Capybara.javascript_driver = :selenium
  Capybara.default_driver = :selenium
end
