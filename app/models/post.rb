# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  picture     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  person_id   :integer
#  draft       :boolean          default(FALSE), not null
#  slug        :string(255)
#

class Post < ActiveRecord::Base

  scope :published, -> { where(draft: false).order(published_on: :desc)}
  scope :draft, -> { where(draft: true).order(created_at: :desc) }

  validates :title, presence: true
  validates :description, presence: true

  belongs_to :person

  mount_uploader :picture, PictureUploader

  extend FriendlyId
  friendly_id :title, use: :slugged

  def set_published_on!
    update_attribute(:published_on, Date.today)
  end
end
