class AddMonthlyDebitDateToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :monthly_debit_date, :integer, default: 1  end
end
