class WebSite::Tag < ApplicationRecord

  belongs_to :web_site, counter_cache: true

  validates :name, presence: true,
                   inclusion: { in: WEB_SITE_TAGS },
                   length: { maximum: 255 }

  validates :content, presence: true

end
