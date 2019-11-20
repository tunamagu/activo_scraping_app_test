class CreateJobOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :job_offers do |t|
      t.string :title
      t.string :owner_name
      t.text :url

      t.timestamps
    end
  end
end
