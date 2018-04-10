require 'test_helper'

class WebSiteTest < ActiveSupport::TestCase

  setup do
    @website = WebSite.new

    @ruby = web_sites(:ruby)
    @rust = web_sites(:rust)
  end

  test "url should be present" do
    assert_not @website.valid?
    assert_includes @website.errors.messages[:url], I18n.t(".errors.messages.blank")
  end

  test "url should be unique" do
    @website.url = @ruby.url
    assert_not @website.valid?

    assert_includes @website.errors.messages[:url], I18n.t(".errors.messages.taken")
  end

  test "url should be invalid valid" do
    @website.url = "http://rbrb"
    assert_not @website.valid?
    assert_includes @website.errors.messages[:url], I18n.t('invalid_url')

    @website.url = "http:www.com"
    assert_not @website.valid?
    assert_includes @website.errors.messages[:url], I18n.t('invalid_url')

    @website.url = "http://"
    assert_not @website.valid?
    assert_includes @website.errors.messages[:url], I18n.t('invalid_url')
  end

  test "url should have a maximum of 255 characters" do
    @website.url = "https://www.ruby-lang.org/en/#{ 'a' * 256 }"
    assert_not @website.valid?
    assert_includes @website.errors.messages[:url],
                    I18n.t(".errors.messages.too_long", count: 255)
  end

  test "url should be accepted" do
    @website.url = 'https://www.ruby-lang-2.org/en/'
    assert @website.valid?
  end

  test "should save a valid website" do
    @website.url = 'https://www.ruby-lang-2.org/en/'

    @website.stub :recraw, true do
      assert @website.save
    end
  end

  test 'should has many tags' do
    assert_equal @ruby.tags.count, 4
  end

  test '#content' do
    ruby_content = "Second Title Sub Title Link Title"
    assert_equal @ruby.content, ruby_content

    rust_content = ""
    assert_equal @rust.content, rust_content
  end

end
