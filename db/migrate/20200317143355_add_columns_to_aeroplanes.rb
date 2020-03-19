class AddColumnsToAeroplanes < ActiveRecord::Migration[6.0]
  def change
    add_column :aeroplanes, :first_class_rows, :integer
    add_column :aeroplanes, :first_class_columns, :integer
    add_column :aeroplanes, :first_class_base_fare, :bigint
    add_column :aeroplanes, :business_rows, :integer
    add_column :aeroplanes, :business_columns, :integer
    add_column :aeroplanes, :business_base_fare, :bigint
    add_column :aeroplanes, :economy_rows, :integer
    add_column :aeroplanes, :economy_columns, :integer
    add_column :aeroplanes, :economy_base_fare, :bigint
  end
end
