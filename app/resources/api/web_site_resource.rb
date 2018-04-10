class Api::WebSiteResource < Api::ApplicationResource
  model_name 'WebSite'

  attributes :url, :content

  def content
    @model.content
  end

  def self.read_fields
    [:content]
  end

end
