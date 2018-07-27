# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :login

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable,
         omniauth_providers: %i[facebook google_oauth2 twitter]

  mount_uploader :avatar, PictureUploader
  validates :phone_number, length: { maximum: 11, minimum: 10 },
                           if: :email_present?
  has_many :providers, dependent: :destroy

  class << self
    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      login = conditions.delete(:login)
      where(conditions).where(['phone_number = :value OR lower(email) = :value',
                               { value: login.strip.downcase }]).first
    end

    def from_omniauth(auth)
      provider = Provider.where(provider: auth[:provider], uid: auth[:uid])
      user = provider.first.user if provider.present?
      user
    end
  end

  private

  def email_required?
    phone_number.blank?
  end

  def email_changed?
    phone_number.bacnk?
  end

  def email_present?
    email.blank?
  end
end
