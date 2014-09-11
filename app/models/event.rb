class Event < ActiveRecord::Base
    has_one :creator, :class_name => 'User', :foreign_key => 'creator_id'
    belongs_to :host_group, :class_name => 'HostGroup', :foreign_key => 'hosts_id'


    attr_accessible :name, :description

end
