require 'test_helper'

class BgChecksControllerTest < ActionController::TestCase
  setup do
    @bg_check = bg_checks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bg_checks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bg_check" do
    assert_difference('BgCheck.count') do
      post :create, bg_check: { child_abuse_date: @bg_check.child_abuse_date, criminal_date: @bg_check.criminal_date, date_approved: @bg_check.date_approved, status: @bg_check.status, verification_date: @bg_check.verification_date }
    end

    assert_redirected_to bg_check_path(assigns(:bg_check))
  end

  test "should show bg_check" do
    get :show, id: @bg_check
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bg_check
    assert_response :success
  end

  test "should update bg_check" do
    patch :update, id: @bg_check, bg_check: { child_abuse_date: @bg_check.child_abuse_date, criminal_date: @bg_check.criminal_date, date_approved: @bg_check.date_approved, status: @bg_check.status, verification_date: @bg_check.verification_date }
    assert_redirected_to bg_check_path(assigns(:bg_check))
  end

  test "should destroy bg_check" do
    assert_difference('BgCheck.count', -1) do
      delete :destroy, id: @bg_check
    end

    assert_redirected_to bg_checks_path
  end
end
