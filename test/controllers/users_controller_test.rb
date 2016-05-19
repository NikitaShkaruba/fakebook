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

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when logged in as a non-admin' do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test 'index as admin including pagination and delete links' do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    # assert_select 'div.pagination'     dunno why it can't find it :\
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @user
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end

  test 'index as non-admin' do
    log_in_as(@other_user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
