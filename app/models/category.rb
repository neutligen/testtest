class Category < ActiveRecord::Base
	has_many :to_do_lists, dependent: :destroy
  belongs_to :user
  validates :user_id, presence: true
  validates :category_name, presence: true

end
