require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    invalid_params = {
      params: {
        person: {
          name: '',
          mail: 'person@invalid',
          password: 'foo',
          password_confirmation: 'bar'
        }
      }
    }

    assert_no_difference 'Person.count' do
      get people_path
      post(people_path, invalid_params)
    end
  end

  test 'valid signup information' do
    valid_post_params = {
      params: {
        person: {
          name: 'Person',
          surname: 'THEPERSON',
          mail: 'person_name@example.ru',
          password: 'foobarbar',
          password_confirmation: 'foobarbar'
        }
      }
    }

    assert_difference('Person.count', 1) do
        get people_path
        post people_path, valid_post_params
        follow_redirect!
    end
  end
end
