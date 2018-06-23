class AddExplicitToPodcast < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :explicit, :boolean
  end
end
