require 'test_helper'

class Api::WebSitesRoutesTest < ActionDispatch::IntegrationTest

  setup do
    @ruby = web_sites(:ruby)
  end

  test 'GET /api/web-sites' do
    assert_routing(
      { method: 'get', path: 'api/web-sites' },
      { controller: 'api/web_sites', action: 'index' }
    )
  end

  test 'POST /api/web-sites' do
    assert_routing(
      { method: 'post', path: 'api/web-sites' },
      { controller: 'api/web_sites', action: 'create' }
    )
  end

  test 'should raise for GET /api/web-sites/:id' do
    path = "/api/web-sites/#{@ruby.id}"

    assert_raises { get path }
  end

  test 'should raise for PATCH /api/web-sites/:id' do
    path = "api/web-sites/#{@ruby.id}"

    assert_raises { patch path }
  end

  test 'should raise for PUT /api/web-sites/:id' do
    path = "api/web-sites/#{@ruby.id}"

    assert_raises { put path }
  end

  test 'should raise for DELETE /api/web-sites/:id' do
    path = "api/web-sites/#{@ruby.id}"

    assert_raises { delete path }
  end

end
