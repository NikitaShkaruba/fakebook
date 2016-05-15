require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fedor)
    @other_user = users(:michael)
  end

  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test 'should redirect update when not logged in' do
    patch user_path(@user), params: { user: { id: @user, name: @user.name, mail: @user.mail } }
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@user)

    get edit_user_path(@other_user)
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@user)

    patch user_path(@other_user), params: { user: { id: @user, name: @user.name, mail: @user.mail } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect index when not loged in' do
    get users_path
    assert_redirected_to login_path
  end
end
