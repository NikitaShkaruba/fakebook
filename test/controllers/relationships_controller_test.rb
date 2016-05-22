require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test 'create should require logged-in user' do
    assert_no_difference 'Relationship.count' do
      post relationships_path
    end
    assert_redirected_to login_path
  end

  test 'destroy should require logged-in user' do
    assert_no_difference 'Relationship.count' do
      delete relationship_path(:one)
    end
    assert_redirected_to login_path
  end
end
