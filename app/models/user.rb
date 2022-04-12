# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         def admin?
           is_admin
         end
         # 判別是否收藏

        def is_member_of?(job)
          favorite_jobs.include?(job)
        end

          # 加入收藏 #
          def add_favorite!(job)
            favorite_jobs << job
          end

          # 移除收藏 #
          def remove_favorite!(job)
            favorite_jobs.delete(job)
          end

  has_many :resumes
  has_many :favorites
  has_many :favorite_jobs, through: :favorites, source: :job
end
