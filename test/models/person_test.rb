require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = Person.new(name: 'Alex', surname: 'Vazovsky', mail: 'Alex@example.com',
                         password: "foobar", password_confirmation: "foobar")
  end

  test 'should be valid' do
    assert @person.valid?
  end

  test 'name should be present' do
    @person.name = '      '
    assert_not @person.valid?
  end

  test 'surnamename should be present' do
    @person.surname = '      '
    assert_not @person.valid?
  end

  test 'name should be not longer then 10' do
    @person.name = 'q'*11
    assert_not @person.valid?
  end

  test 'surname should be not longer then 10' do
    @person.surname = 'q'*21
    assert_not @person.valid?
  end

  test 'email validation  should accept valid adresses' do
    valid_addresses = %W[me@example.com ME@example.COM A-USER@foo.bar.example.com hi.there@example.com]

    valid_addresses.each do |address|
      @person.mail = address
      assert @person.valid?, "#{address.inspect} should be valid!"
    end
  end

  test 'email addresses should be unique and not case sensitive' do
    duplicate_person = @person.dup
    duplicate_person.mail = @person.mail.upcase
    @person.save

    assert_not duplicate_person.valid?
  end

  test 'password should be present (nonblank)' do
    @person.password = @person.password_confirmation = ' ' * 6
    assert_not @person.valid?
  end

  test 'password should have a minimum length' do
    @person.password = @person.password_confirmation = 'a'
    assert_not @person.valid?
  end
end
