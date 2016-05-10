require 'test_helper'

class PeopleLoginTest < ActionDispatch::IntegrationTest
  def setup
    @person = people(:fedor)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { mail: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?

    get root_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get login_path

    # login
    # I dunno why, but he can't find fedor
    post login_path, session: { mail: @person.mail, password: 'password' }
    assert_redirected_to @person
    assert is_logged_in?
    follow_redirect!
    assert_template 'people/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', person_path(@person)

    # logout
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path,      count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end
end
