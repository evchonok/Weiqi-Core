require "test_helper"

class MenuControllerTest < ActionDispatch::IntegrationTest
  test "should get tasks" do
    get menu_tasks_url
    assert_response :success
  end

  test "should get game" do
    get menu_game_url
    assert_response :success
  end

  test "should get minigames" do
    get menu_minigames_url
    assert_response :success
  end
end
