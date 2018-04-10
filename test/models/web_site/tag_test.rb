require 'test_helper'

class WebSite::TagTest < ActiveSupport::TestCase

  setup do
    @ruby = web_sites(:ruby)
    @tag = WebSite::Tag.new

    @h1 = web_site_tags(:h1)
  end

  test "name should be present" do
    assert_not @tag.valid?
    assert_includes @tag.errors.messages[:name], I18n.t(".errors.messages.blank")
  end

  test "name should inclusion only h1, h2, h3, and a html tags" do
    @tag.name = 'p'
    assert_not @tag.valid?
    assert_includes @tag.errors.messages[:name], I18n.t(".errors.messages.inclusion")
  end

  test "name should have a maximum of 255 characters" do
    @tag.name = 'a' * 256
    assert_not @tag.valid?
    assert_includes @tag.errors.messages[:name],
                    I18n.t(".errors.messages.too_long", count: 255)
  end

  test "content should be present" do
    assert_not @tag.valid?
    assert_includes @tag.errors.messages[:content], I18n.t(".errors.messages.blank")
  end

  test "website should be present" do
    assert_not @tag.valid?
    assert_includes @tag.errors.messages[:web_site], I18n.t(".errors.messages.required")
  end

  test "should save a valid tag" do
    @tag.web_site_id = @ruby.id
    @tag.name = 'h1'
    @tag.content = 'fo'

    assert @tag.save
  end

  test "tag belongs to website" do
    assert @h1.web_site, @ruby
  end

end
