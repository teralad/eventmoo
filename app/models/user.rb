class User < ApplicationRecord
  validates :phone, presence: { message: 'should be present' },
                    numericality: true,
                    length: { minimum: 10, maximum: 15 }
                    # telephone_number: { country: proc{|user_record| user_record.country_iso},
                    #                     types: [:mobile] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: { message: 'should be valid' }
  validates_presence_of :username

  has_many :bookings
end
