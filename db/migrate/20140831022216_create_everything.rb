class CreateEverything < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :name
        t.string :email
        t.string :password_digest
        t.timestamps
    end

    create_table :events do |t|
        t.string :name
        t.string :description
        t.float :lat
        t.float :lon
        t.references :host_group, index: true
        t.references :user, index: true
        t.timestamps
    end

    create_table :host_appointments do |t|
        t.references :user, index: true
        t.references :host_group, index: true

        t.timestamps
    end

    create_table :host_groups do |t|
        t.references :event, index: true

        t.timestamps
    end
  end
end
