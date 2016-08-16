require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get nopage" do
    get :nopage
    assert_response :success
  end

end
