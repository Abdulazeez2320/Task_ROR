class ChangeNameToTitleInTask < ActiveRecord::Migration[7.1]
  def change
    change_table :tasks do |t|
      t.rename :name, :title
    end
  end
end
