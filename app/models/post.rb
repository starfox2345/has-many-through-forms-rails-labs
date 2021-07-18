class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories, :comments

  def categories_attributes=(categories_attributes)
    categories_attributes.values.each do |attr|
      # byebug
      if !attr[:name].empty?
        category = Category.find_or_create_by(name: attr[:name])
        self.categories << category
      end
    end
  end
end
