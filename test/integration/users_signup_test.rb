require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end


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
      get signup_path
      post(users_path, invalid_params)
    end
  end

  test 'valid signup information with user authentication' do
    get signup_path

    assert_difference('User.count', 1) do
      post users_path, params: {
                         user: {
                           name: 'User',
                           surname: 'THEPERSON',
                           mail: 'person_name@example.ru',
                           password: 'foobarbar',
                           password_confirmation: 'foobarbar'
                         }
                       }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?

    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?

    # Invalid activation token
    get edit_account_activation_path('invalid token')
    assert_not is_logged_in?

    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, mail: 'wrong')
    assert_not is_logged_in?

    # Valid activation token
    get edit_account_activation_path(user.activation_token, mail: user.mail)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
