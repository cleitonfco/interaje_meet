class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :twitter
      t.string :site
      t.string :company

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
