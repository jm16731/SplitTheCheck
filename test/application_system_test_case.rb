require "test_helper"
require "capybara"
require 'helpers/firefox_helper'
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
   driven_by :headless_firefox
end


#require "test_helper"

#class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
#  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
#end
