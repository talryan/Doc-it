class User< ActiveRecord::Base
    has_many :appointments
    has_secure_password
    validates :username, presence: true, uniqueness: { message: "%{value} is already in use. Please select another or login."}
end
