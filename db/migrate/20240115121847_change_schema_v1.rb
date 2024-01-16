class ChangeSchemaV1 < ActiveRecord::Migration[6.0]
  def change
    create_table :todos, comment: 'Stores todo items created by users' do |t|
      t.integer :recurrence, default: 0

      t.datetime :due_date

      t.string :title

      t.integer :priority, default: 0

      t.text :description

      t.string :category

      t.timestamps null: false
    end

    create_table :todo_tags, comment: 'Associative table to manage tags for todos' do |t|
      t.string :tag

      t.timestamps null: false
    end

    create_table :error_logs, comment: 'Stores error logs for internal use' do |t|
      t.text :error_message

      t.datetime :timestamp

      t.timestamps null: false
    end

    create_table :users, comment: 'Stores user account information' do |t|
      t.string :name

      t.timestamps null: false
    end

    add_reference :error_logs, :user, foreign_key: true

    add_reference :todo_tags, :todo, foreign_key: true

    add_reference :todos, :user, foreign_key: true
  end
end
