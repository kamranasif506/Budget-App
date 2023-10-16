class CreateRecordItems < ActiveRecord::Migration[7.1]
  def change
    create_table :record_items do |t|

      t.timestamps
    end
  end
end
