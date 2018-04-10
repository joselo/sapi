require 'test_helper'

class RecrawlerTest < ActiveSupport::TestCase

  setup do
    page = File.read(File.join(Rails.root, 'test', 'fixtures', 'page.html'))

    @rust = web_sites(:rust)

    @tempfile = Tempfile.new
    @doc = Nokogiri::HTML(page)

    @doc_h1 = Nokogiri::HTML("<h1>foo<h1>").css('h1').first
    @doc_a = Nokogiri::HTML("<a href='http://www.url.com' target='_blank'></a>").css('a').first

    @doc_h1_empty = Nokogiri::HTML("<h1><h1>").css('h1').first
    @doc_a_empty = Nokogiri::HTML("<a></a>").css('a').first
  end

  test '#open_url' do
    @rust.stub :open, 'foo' do
      assert_equal @rust.open_url, 'foo'
    end
  end

  test '#doc' do
    @rust.stub :open_url, @tempfile do
      assert_instance_of Nokogiri::HTML::Document, @rust.doc
    end

    @tempfile.close
    @tempfile.unlink
  end

  test '#css_content' do
    tag_h1 = @rust.css_content('h1', @doc_h1)
    assert_equal tag_h1, @doc_h1.content

    tag_a = @rust.css_content('a', @doc_a)
    assert_equal tag_a, @doc_a.attribute('href').value

    tag_h1_empty = @rust.css_content('h1', @doc_h1_empty)
    assert_nil tag_h1_empty

    tag_a_empty = @rust.css_content('a', @doc_a_empty)
    assert_nil tag_a_empty
  end

  test '#build_tag' do
    tag_h1 = @rust.build_tag('h1', @doc_h1)
    tag_a = @rust.build_tag('a', @doc_a)

    assert_equal @rust.tags.size, 2
  end

  test '#recraw' do
    @rust.stub :doc, @doc do
      @rust.recraw
    end

    assert_equal @rust.tags.size, 16
  end

end
