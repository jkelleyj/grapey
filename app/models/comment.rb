class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id

  belongs_to :user

  def username
    user.try(:email)
  end

end
