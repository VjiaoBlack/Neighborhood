class User < ActiveRecord::Base
    has_secure_password

    validates_uniqueness_of :email

    attr_accessible :name, :email, :password, :password_confirmation

    has_many :events
    has_many :host_groups, through: :host_appointments
end
