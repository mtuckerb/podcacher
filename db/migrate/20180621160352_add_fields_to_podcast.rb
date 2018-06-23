class AddFieldsToPodcast < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :author, :string
    add_column :podcasts, :description, :string
    add_column :podcasts, :keywords, :string
    add_column :podcasts, :ext, :string
  end
end
