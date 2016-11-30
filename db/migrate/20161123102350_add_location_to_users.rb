class AddLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
  end
end
#rails g migration add_location_to_users location:string