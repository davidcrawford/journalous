require 'test_helper'

class PromptsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prompts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prompt" do
    assert_difference('Prompt.count') do
      post :create, :prompt => { }
    end

    assert_redirected_to prompt_path(assigns(:prompt))
  end

  test "should show prompt" do
    get :show, :id => prompts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => prompts(:one).to_param
    assert_response :success
  end

  test "should update prompt" do
    put :update, :id => prompts(:one).to_param, :prompt => { }
    assert_redirected_to prompt_path(assigns(:prompt))
  end

  test "should destroy prompt" do
    assert_difference('Prompt.count', -1) do
      delete :destroy, :id => prompts(:one).to_param
    end

    assert_redirected_to prompts_path
  end
end
