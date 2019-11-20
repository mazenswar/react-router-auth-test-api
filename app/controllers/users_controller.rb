class UsersController < ApplicationController

    def index 
        render json: User.all
    end

    def create
        user = User.create(user_params)
        if user.valid?
            payload = {user_id: user.id}
            token = JWT.encode(payload, secret, "HS256")
            render json: {user: user, token: token}
        else
            render json: {error: 'failed to create user'}
        end
    end


    private

    def user_params
        params.permit(:username, :password)
    end
end
