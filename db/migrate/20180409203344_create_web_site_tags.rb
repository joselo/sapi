class CreateWebSiteTags < ActiveRecord::Migration[5.2]
  def change
    create_table :web_site_tags do |t|
      t.references :web_site, foreign_key: true
      t.string :name
      t.text :content

      t.timestamps
    end
    add_index :web_site_tags, :name
  end
end
