require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_1)
  end

  test 'micropost interface' do
    log_in_as(@user)
    get user_path(@user)

    # TODO: fix NO HTTP_REFERRER ERROR

    # Invalid submission
    #assert_no_difference 'Post.count' do
    #  setup do
    #    @request.env['HTTP_REFERER'] = user_path(@user)
    #    post posts_path, params: { post: { content: ''} }
    #  end
    #end
    #assert_not flash.empty?

    # Valid submission
    #content = 'This micropost really ties the room together'
    #assert_difference 'Post.count', 1 do
    #  post posts_path, params: { post: { content: content } }
    #end
    #assert_match content, response.body

    # Delete a post.
    #assert_select 'a', text: 'delete'
    #first_post = @user.posts.paginate(page: 1).first
    #assert_difference 'Post.count', -1 do
    #  delete post_path(first_post)
    #end

    # Visit a different user.
    get user_path(users(:user_2))
    assert_select 'a', text: 'delete', count: 0
  end
end
