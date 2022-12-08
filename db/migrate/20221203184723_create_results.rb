class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results, id: false do |t|
      t.integer :n
      t.string :sequence, primary_key: true, unique: true
      t.json :result_sequences
      t.integer :max_sequence, array: true
      t.timestamps
    end
  end
end
