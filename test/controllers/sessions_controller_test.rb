require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "get login page" do
    get( login_path )
    assert_response :success
    assert_template( 'sessions/new' )
  end

end
