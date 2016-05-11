require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    invalid_params = {
      params: {
          user: {
          name: '',
          mail: 'person@invalid',
          password: 'foo',
          password_confirmation: 'bar'
        }
      }
    }

    assert_no_difference 'User.count' do
      get users_path
      post(users_path, invalid_params)
    end
  end

  test 'valid signup information' do
    valid_post_params = {
      params: {
          user: {
          name: 'User',
          surname: 'THEPERSON',
          mail: 'person_name@example.ru',
          password: 'foobarbar',
          password_confirmation: 'foobarbar'
        }
      }
    }

    assert_difference('User.count', 1) do
        get users_path
        post users_path, valid_post_params
        follow_redirect!
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end
