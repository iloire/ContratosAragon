class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.string :title
      t.string :description
      t.string :contract_type
      t.string :procedure
      t.string :budget_announced
      t.string :budget_adjudicated
      t.integer :idweb
      t.string :company_name
      t.string :department
      t.string :signed_by
      t.string :resolution_date

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
