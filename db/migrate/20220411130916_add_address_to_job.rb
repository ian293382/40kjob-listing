class AddAddressToJob < ActiveRecord::Migration[5.0]
  def change
    #location_job
    add_column :jobs, :address, :string

    #require column map
    add_column :jobs, :latitude, :float
      add_column :jobs, :longitude, :float
  end
end
