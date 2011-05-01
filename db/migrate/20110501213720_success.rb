class Success < ActiveRecord::Migration
  def self.up
    add_column :contracts, :success, :boolean
  end

  def self.down
    remove_column :contracts, :success
  end
end
