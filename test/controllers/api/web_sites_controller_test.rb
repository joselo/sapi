require 'test_helper'

class Api::WebSitesControllerTest < ActionDispatch::IntegrationTest

  def raw_web_site_json(web_site)
    json = <<-JSON
      {"id":"#{web_site.id}","type":"web-sites","links":{"self":"http://www.example.com/api/web-sites/#{web_site.id}"},"attributes":{"url":"#{web_site.url}","content":"#{web_site.content}"}}
    JSON
    json.strip
  end

  def raw_pagination
    json = <<-JSON
    "links":{"first":"http://www.example.com/api/web-sites?page%5Bnumber%5D=1&page%5Bsize%5D=10","last":"http://www.example.com/api/web-sites?page%5Bnumber%5D=1&page%5Bsize%5D=10"}
    JSON
    json.strip
  end

  def web_site_json(web_site)
    json = <<-JSON
      {"data":#{raw_web_site_json(web_site)}}
    JSON
    json.strip
  end

  def web_sites_json(web_sites)
    json_fragments = web_sites.map {|web_site| raw_web_site_json(web_site) }
    json = <<-JSON
      {"data":[#{json_fragments.join(',')}],#{raw_pagination}}
    JSON
    json.strip
  end

  setup do
    WebSite.any_instance.stubs(:recraw).returns(true)

    @ruby = web_sites(:ruby)
    @rust = web_sites(:rust)
  end

  test 'should get index' do
    get api_web_sites_url
    assert_response :success

    web_sites = WebSite.order(id: :asc)
    assert_equal web_sites_json(web_sites), @response.body
  end

  test 'should create website' do
    url = 'https://unsplash.com'

    assert_difference('WebSite.count') do
      post api_web_sites_url, params: {
        data: {
          type: 'web-sites',
          attributes: {
            url: url
          }
        }
      },
      as: :json,
      headers: {
        'Accept' => JSONAPI::MEDIA_TYPE,
        'Content-Type' => JSONAPI::MEDIA_TYPE
      }
    end

    assert_response :created

    new_web_site = WebSite.order(created_at: :desc).first
    assert_equal(new_web_site.url, url)

    assert_equal web_site_json(new_web_site), @response.body
  end

end
