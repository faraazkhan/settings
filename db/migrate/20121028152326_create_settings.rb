class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :scope
      t.text :configuration_settings

      t.timestamps
    end
  end
end
