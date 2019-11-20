class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :job_offer_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
