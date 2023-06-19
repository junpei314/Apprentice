require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get todos_create_url
    assert_response :success
  end
end
