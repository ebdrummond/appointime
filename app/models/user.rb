class User < ActiveRecord::Base
  has_secure_password
  include PgSearch
  pg_search_scope :search_by_full_name_or_email, :against => [:first_name, :last_name, :email]

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
                        :password_digest

  validate :valid_phone_number

  has_many :appointments

  def valid_phone_number
    clean_number = self.phone.gsub(/\D/, "")

    if clean_number.length == 10
      self.phone = clean_number
    elsif clean_number.length == 11 && clean_number[0] == "1"
      self.phone = clean_number[1..10]
    else
      errors.add(:phone, "number is incorrect.  Please input phone in this format: (202) 222-2222")
    end
  end

  #where('first_name || '' || last_name) - look up PG concat

  def full_name
    [self.first_name, self.last_name].join(" ")
  end

  def self.search(query)
    if query
      where('name ILIKE ?', "%#{query}%")
    else
      all
    end
  end
end
