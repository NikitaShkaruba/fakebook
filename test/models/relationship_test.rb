require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:user_1).id, followed_id: users(:user_2).id)
  end

  test 'should be valid' do
    assert @relationship.valid?
  end

  test 'should require a follower_id' do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test 'should require a followed_id' do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
