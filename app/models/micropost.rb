class Micropost < ApplicationRecord
  MICROPOST_PARAMS = %i(content picture).freeze

  belongs_to :user

  delegate :name, to: :user, prefix: :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost_maximum}
  validate :picture_size

  scope :order_by_created_desc, ->{order(created_at: :desc)}
  scope :feed_by_following, ->(following_ids) {where(user_id: following_ids)}

  private

  def picture_size
    return unless (picture.size > Settings.img_maximum.megabytes)
    errors.add :picture, I18n.t("static_pages.micropost.requite_size_picture")
  end
end
