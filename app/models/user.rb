class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :first_name,
                  :last_name,
                  :email,
                  :password,
                  :password_confirmation,
                  :phone

  validates_uniqueness_of :email

  validates_presence_of :first_name,
                        :last_name,
                        :email,
                        :phone,
                        :password

  validate :end_date_cannot_be_earlier_than_start_date

end
