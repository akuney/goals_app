class ChangePrivateToHidden < ActiveRecord::Migration
  def change
    remove_column :goals, :private
    add_column :goals, :hidden, :boolean, {default: false}
  end
end
