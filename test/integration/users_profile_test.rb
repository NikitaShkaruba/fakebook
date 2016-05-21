require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:user_1)
  end

  test 'profile display' do
    get user_path(@user)
    assert_template 'users/show'
    assert_match @user.posts.count.to_s, response.body
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end
end
