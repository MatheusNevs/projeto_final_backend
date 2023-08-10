class UsersController < ApplicationController
    acts_as_token_authentication_handler_for User, except: [:login, :create]
    before_action :is_admin_authentication, only: [:index]

    def login
        user = User.find_by(email: params[:email])
        if user and user.valid_password?(params[:password])
            render json: serializer(user), status: :ok
        else
            render json:'Email ou Senha Inválidos', status: :unauthorized
        end
    rescue StandardError => e
        render json: e, stautus: :unauthorized
    end

    def index
        render json: array_serializer(User.all), status: :ok
    rescue StandardError => e
        render json: {error:e.message}, status: :bad_request
    end
    
    def show
        user = User.find_by(email: user_params[:email])
        render json: serializer(user), status: :ok
    rescue => e
        render json: {error: e.message}, status: :not_found
    end


    def create
        user = User.new(user_params)
        user.save!
        render json: serializer(user), status: :created
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    def update
        user = current_user
        user.update!(user_params)
        render json: serializer(user), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    def add_picture
        if current_user.profile_picture.attached?
            current_user.profile_picture.purge
        end
        params[:profile_picture].each do |profile_picture|
            current_user.profile_picture.attach(profile_picture)
        end
        render json: serializer(current_user), status: :ok 
    rescue StandardError => e
        render json: {error: e.message}, status: :ok
    end

    def delete
        user = current_user
        user.destroy!
        render json: serializer(user), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :last_name, :email, :is_admin, :password,:id, :description
        )
    end

    def array_serializer(users)
        Panko::ArraySerializer.new(users, each_serializer: UserSerializer).to_json
    end

    def serializer(user)
        UserSerializer.new.serialize_to_json(user)
    end
end


