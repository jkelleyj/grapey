
class API < Grape::API
  version 'v1', using: :path, vendor: 'grapey'
  format :json

  helpers do
    def warden
      env['warden']
    end
    def current_user
      @current_user ||= warden.user
    end

    def authenticate!
      if warden.authenticated?
        return true
      else
        error!('401 Unauthorized', 401)
      end
    end
  end

  resource :comments do
    desc "Return a public timeline."
    get :public_timeline do
      Comment.limit(20)
    end

    desc "Return a user's comments"
    get :home_timeline do
      authenticate!
      current_user.comments.limit(20)
    end

    desc "Create a comment."
    params do
      requires :body, type: String, desc: "Your comment body."
    end
    post do
      authenticate!
      Comment.create!({
        user: current_user,
        text: params[:body]
      })
    end
  end
end
