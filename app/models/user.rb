class User < ApplicationRecord
  self.table_name = "users"
  self.primary_key = 'id'

  default_scope -> { where(deleted_at: nil) }

  # setter
  def soft_delete
    update_attribute(:deleted_at, Time.now)
  end

  # validation
  validates :name,
    presence: true,
    allow_blank: false,
    length: { minimum: 3 }
  
  validates :email,
    presence: true,
    uniqueness: true,
    allow_blank: false,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
    presence: true,
    allow_blank: false,
    length: { minimum: 6 },
    on: :create
  
  validates :phone_number,
    presence: true,
    allow_blank: false,
    length: { maximum: 14 }

=begin
  column of users table
  - id
  - name
  - email
  - password
  - phone_number
  - created_at
  - updated_at
=end
end