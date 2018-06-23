class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :url
      t.integer :guid
      t.datetime :published_on
      t.text :description

      t.timestamps
    end
  end
end
