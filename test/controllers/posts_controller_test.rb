require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:orange)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: 'I cant create post, right?' } }
    end
    assert_redirected_to login_path
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_path
  end

  test 'should redirect destroy for wrong post' do
    log_in_as(users(:user_1))
    post = posts(:ants) # ants is not user_1's post, it's user_2's
    assert_no_difference 'Post.count' do
      delete post_path(post)
    end
    assert_redirected_to root_path
  end
end
