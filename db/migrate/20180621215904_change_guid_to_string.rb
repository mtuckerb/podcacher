class ChangeGuidToString < ActiveRecord::Migration[5.2]
  def change

    change_column :episodes, :guid, :string
  end
end
