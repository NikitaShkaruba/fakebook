require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Alex', surname: 'Vazovsky', mail: 'Alex@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '      '
    assert_not @user.valid?
  end

  test 'surnamename should be present' do
    @user.surname = '      '
    assert_not @user.valid?
  end

  test 'name should be not longer then 10' do
    @user.name = 'q'*11
    assert_not @user.valid?
  end

  test 'surname should be not longer then 10' do
    @user.surname = 'q'*21
    assert_not @user.valid?
  end

  test 'email validation  should accept valid adresses' do
    valid_addresses = %W[me@example.com ME@example.COM A-USER@foo.bar.example.com hi.there@example.com]

    valid_addresses.each do |address|
      @user.mail = address
      assert @user.valid?, "#{address.inspect} should be valid!"
    end
  end

  test 'email addresses should be unique and not case sensitive' do
    duplicate_person = @user.dup
    duplicate_person.mail = @user.mail.upcase
    @user.save

    assert_not duplicate_person.valid?
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a'
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?(nil)
  end
end