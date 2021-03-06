# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links, id: :uuid do |t|
      t.text :url
      t.string :slug
      t.integer :click_count, default: 0

      t.timestamps
    end
  end
end
