#!/usr/bin/env ruby
#
require "bundler/setup"
require "capybara"
require "capybara/dsl"
require "capybara/poltergeist"
require "launchy"

Capybara.run_server = false
Capybara.current_driver = :poltergeist
Capybara.app_host = "http://www.lookcyzone.com/"

module Test
  class Cyzone
    include Capybara::DSL

    USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1944.0 Safari/537.36"

    def vote(email, password)
      page.driver.add_header("User-Agent", USER_AGENT)
      visit '/favorita-perfil.aspx?p=4'
      save_screenshot("1_visit_page.png")
      find(:css, '#voto_participante').click
      save_screenshot("2_click_button.png")
      within_frame(find(:css, "#fancybox-frame")) do
        fill_in "txt_nickname", with: email
        fill_in "txt_pass", with: password
        save_screenshot("3_fill_login.png")
        click_button "btnEnviar"
      end
      save_screenshot("4_click_login.png")
    end
  end
end

bot = Test::Cyzone.new
bot.vote "manzana1144@hotmail.com", "123456"
