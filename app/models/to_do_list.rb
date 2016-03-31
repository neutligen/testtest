class ToDoList < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :category_id, presence: true
  validates :priority_flg, presence: true
  validate :picture_size

  private

    # アップロード画像のサイズを検証する
    def picture_size
    	if picture.size > 5.megabytes
    		error.add(:picture, "ファイルサイズの上限は5MBです。")
    	end
    end

end
