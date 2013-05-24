class CreateSocializerVerbs < ActiveRecord::Migration
  def change
    create_table :socializer_verbs do |t|
      t.string :name

      t.timestamps
    end
    add_index :socializer_verbs, :name, unique: true
  end
end
