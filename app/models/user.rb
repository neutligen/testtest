class User < ActiveRecord::Base
  has_many :categories, dependent: :destroy
  # has_many_throughはuser.to_do_lists.include?(@category)みたいのが使えるかもと思って入れてみた。後々不要だったら削除しようと思う。_20150403
  has_many :to_do_lists, through: :categories
	has_many :to_do_lists, dependent: :destroy
	attr_accessor :remember_token, :activation_token, :reset_token
    before_save :downcase_email
    before_create :create_activation_digest
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, presence: true, length: {minimum: 6}

	# 与えられた文字列のハッシュを返す(テスト環境で使う)
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

  # ランダムなトークンを返す（リメンバーダイジェストにしてブラウザのキャッシュに保存）
	def User.new_token
		SecureRandom.urlsafe_base64
	end

  # 永続的セッションで使用するユーザーをデータベースに保存する。
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# ブラウザから渡されたトークンがダイジェストと一致したらtrueを返す
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# ユーザーログインを破棄する
	def forget
		update_attribute(:remember_digest, nil)
	end

  # アカウントを有効にする
	def activate
		update_attribute(:activated, true)
		update_attribute(:activated_at, Time.zone.now)
	end

  # 有効化用のメールを送信する
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	# パスワード再設定用のreset_digestを生成する
	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:remember_digest, User.digest(reset_token))
		update_attribute(:reset_set_at, Time.zone.now)
	end

  # パスワード再設定メールを送信する
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	# パスワード再設定の期限が切れている場合はtrueを返す。
	def password_reset_expiration
		reset_set_at < 2.hours.ago
	end

	private

	  # メールアドレスを小文字にする
	  def downcase_email
	  	self.email = email.downcase
	  end

	  # activation_tokenからactivation_digestを作成して、モデルに保存
	  def create_activation_digest
	  	self.activation_token = User.new_token
	  	self.activation_digest = User.digest(activation_token)
	  end
end
