class User < ApplicationRecord
  attr_accessor :login

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]

  mount_uploader :avatar, PictureUploader
  validates :phone_number, length: {maximum: 11, minimum: 10}, if: :email_present?
  has_many :providers, dependent: :destroy

  def login
    @login || self.phone_number || self.email
  end

  class << self
    def find_for_database_authentication warden_conditions
      conditions = warden_conditions.dup
      login = conditions.delete(:login)
      where(conditions).where(["lower(phone_number) = :value OR lower(email) = :value",
        {value: login.strip.downcase}]).first
    end

    def from_omniauth auth
      user_id = Provider.where(provider: auth["provider"], uid: auth["uid"]).pluck(:user_id).first
      user = User.find_by(id: user_id)
      user
    end
  end

  private

  def email_required?
    !phone_number.present?
  end

  def email_changed?
    !phone_number.present?
  end

  def email_present?
    !email.present?
  end
end
