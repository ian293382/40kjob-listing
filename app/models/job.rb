# == Schema Information
#
# Table name: jobs
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  wage_upper_bound :integer
#  wage_lower_bound :integer
#  contact_email    :string
#  is_hidden        :boolean          default(TRUE)
#
class Job < ApplicationRecord
  validates :title, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0}
  # validates :company, presence: {message: "請輸入公司名稱"}
  validates :location, presence: {message: "請選擇工作地點"}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

   scope :published, -> { where(is_hidden: false) }
   scope :recent, -> { order('created_at DESC')}

   belongs_to :location
   belongs_to :category
   has_many :resumes
   has_many :favorites
   has_many :members, through: :favorites, source: :user

   # converting address

   geocoded_by :address
   after_validation :geocode



end
