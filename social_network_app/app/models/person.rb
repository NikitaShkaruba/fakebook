class Person < ApplicationRecord
  validates :name, presence: true, length: { maximum: 10}
  validates :surname, presence: true, length: { maximum: 20}
  validates :mail, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, presence:true, length: { minimum: 6}

  before_save { self.mail = mail.downcase }

  has_secure_password
end
