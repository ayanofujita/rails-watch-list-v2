class AddColumnsToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :year, :integer
    add_column :movies, :rated, :string
    add_column :movies, :released, :date
    add_column :movies, :runtime, :integer
    add_column :movies, :director, :string
  end
end
