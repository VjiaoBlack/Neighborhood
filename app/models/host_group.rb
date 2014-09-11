class HostingGroup < ActiveRecord::Base
    belongs_to :event, :class_name => 'Host', :foreign_key => 'hosts_id'
    has_many :users, through: :host_appointments

end
