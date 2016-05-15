require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fedor)
  end

  test 'unsuccessful edit' do
    log_in_as @user
    get edit_user_path(@user)

    assert_template 'users/edit'
    patch user_path(@user), params: {
                              user: {
                                name:                  '',
                                surname:               '',
                                password:              'foo',
                                password_confirmation: 'bar'
                              }
                            }
    assert_template 'users/edit'
  end

  test 'successful edit with firendly forwarding' do
    get edit_user_path(@user)
    log_in_as @user
    assert_redirected_to edit_user_path(@user)

    newName = 'NotFedor'
    newSurname = 'NotBaranenko'
    newStatus = 'Swag B)'
    newPhoneNumber = '+7-918-777-66-55'
    newCity = 'Moscow'
    newDateOfBirth = '1996-04-12'
    newProfession = 'DJ'
    newRelationshipStatus = 'Single'
    newGender = 'female'

    patch user_path(@user), params: {
                       user: {
                          name: newName,
                          surname: newSurname,
                          status: newStatus,
                          phone_number: newPhoneNumber,
                          city: newCity,
                          date_of_birth: newDateOfBirth,
                          profession: newProfession,
                          relationship: newRelationshipStatus,
                          gender: newGender
                       }
                     }
    assert_not flash.empty?
    assert_redirected_to @user

    # reload database values
    @user.reload
    assert_equal newName, @user.name
    assert_equal newSurname, @user.surname
    assert_equal newStatus, @user.status
    assert_equal newPhoneNumber, @user.phone_number
    assert_equal newCity, @user.city
    assert_equal DateTime.parse(newDateOfBirth), @user.date_of_birth
    assert_equal newProfession, @user.profession
    assert_equal newRelationshipStatus, @user.relationship
    assert_equal newGender, @user.gender
  end
end

