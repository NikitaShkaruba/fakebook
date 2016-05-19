require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'account_activation' do
    user = users(:user_1)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal 'Account confirmation', mail.subject
    assert_equal [user.mail], mail.to
    assert_equal ['noreply@example.com'], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.mail),  mail.body.encoded
  end

end
