class ToDoList < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :category_id, presence: true
  validates :priority_flg, presence: true
  validates :schedule_sta, presence: true, if: :need_reminder?
  validate :picture_size

  # 24時間以内のToDoならtrueを返す。
  def todays_todo?
    if !schedule_sta.nil?
      schedule_sta < Time.now.since(24.hours) && schedule_sta >= Time.zone.now
    end
  end

  private

    # アップロード画像のサイズを検証する
    def picture_size
      if picture.size > 5.megabytes
        error.add(:picture, "ファイルサイズの上限は5MBです。")
      end
    end

    # リマインダがtrueの時はschedule_staを必須とする
    def need_reminder?
      reminder_mail == true
    end

end
