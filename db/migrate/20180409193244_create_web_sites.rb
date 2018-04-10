class CreateWebSites < ActiveRecord::Migration[5.2]
  def change
    create_table :web_sites do |t|
      t.string :url

      t.timestamps
    end
    add_index :web_sites, :url
  end
end
