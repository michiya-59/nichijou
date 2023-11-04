# frozen_string_literal: true

class AddIndexToPostsViewCount < ActiveRecord::Migration[7.1]
  def change
    add_index :posts, :view_count
  end
end
