require 'open-uri'

module Recrawler
  extend ActiveSupport::Concern

  included do
    before_save :recraw
  end

  def open_url
    open(url)
  end

  def doc
    @doc ||= Nokogiri::HTML(open_url)
  end

  def css_content(name, css)
    case name
      when 'a'
        if css.attribute('href') and css.attribute('href').value.present?
          css.attribute('href').value
        end
      else
        css.content.strip if css.content.strip.present?
    end
  end

  def build_tag(name, css)
    content = css_content(name, css)

    tags.build(name: name, content: content) if content.present?
  end

  def recraw
    WEB_SITE_TAGS.each do |tag|
      doc.css(tag).each do |css|
        build_tag(tag, css)
      end
    end
  end

end
