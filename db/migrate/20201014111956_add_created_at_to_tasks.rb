class AddCreatedAtToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :created_at, :datetime
  end
end
