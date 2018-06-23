class AddEmailToPodcast < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :email, :string
  end
end
