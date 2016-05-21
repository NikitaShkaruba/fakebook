require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:user_1)
  end

  test 'password resets' do
    get new_password_reset_path
    assert_template 'password_resets/new'

    # Invalid email
    post password_resets_path, params: { password_reset: { mail: ''} }
    assert_not flash.empty?
    assert_template 'password_resets/new'

    # Valid email
    post password_resets_path, params: { password_reset: { mail: @user.mail } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_path

    # Password reset form
    user = assigns(:user)

    # Wrong email
    get edit_password_reset_path(user.reset_token, mail: '')
    assert_redirected_to root_path

    # Inactive user
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, mail: user.mail)
    assert_redirected_to root_path
    user.toggle!(:activated)

    # Right email, wrong token
    get edit_password_reset_path('wrong token', mail: user.mail)
    assert_redirected_to root_path

    # Right email, right token
    get edit_password_reset_path(user.reset_token, mail: user.mail)
    assert_template 'password_resets/edit'
    assert_select 'input[name=mail][type=hidden][value=?]', user.mail

    # Invalid password & confirmation
    patch password_reset_path(user.reset_token), params: {
          mail: user.mail,
          user: { password: 'foobaz',
                  password_confirmation: 'barquux'}
    }
    assert_select 'div#error_explanation'

    # Empty password
    patch password_reset_path(user.reset_token), params: {
          mail: user.mail,
          user: { password: '',
                  password_confirmation: ''}
    }
    assert_select 'div#error_explanation'

    # Valid password & confirmation
    patch password_reset_path(user.reset_token), params: {
                                                   mail: user.mail,
                                                   user: { password: 'foobaz', password_confirmation: 'foobaz'}
                                                 }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
end
