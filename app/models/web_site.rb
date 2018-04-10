class WebSite < ApplicationRecord
  include Recrawler

  has_many :tags, class_name: 'WebSite::Tag', foreign_key: 'web_site_id'

  validates :url, presence: true,
                  uniqueness: true,
                  length: { maximum: 255 },
                  format: {
                    with: URL_REGEXP, message: I18n.t('invalid_url', default: 'The Url is not valid')
                  }

  def content
    tags.map(&:content).join(' ')
  end

end
