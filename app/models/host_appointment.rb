class HostAppointment < ActiveRecord::Base
    belongs_to :host_group
    belongs_to :user
end
