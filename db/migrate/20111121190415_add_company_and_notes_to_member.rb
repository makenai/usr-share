class AddCompanyAndNotesToMember < ActiveRecord::Migration
  def change
    add_column :members, :company, :string
    add_column :members, :notes, :text
  end
end
