class CategoriesController < ApplicationController
    acts_as_token_authentication_handler_for User, only: [:create, :update, :delete]
    before_action :is_admin_authentication, only: [:create, :update, :delete]
    def index
        render json: array_serializer(Category.all), status: :ok
    end
    
    def show
        render json: serializer(Category.find(params[:id])), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    end
    
    def create
        category = Category.new(category_params)
        category.save!
        render json: serializer(category), status: :created
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    def update
        category = Category.find(params[:id])
        category.update!(category_params)
        render json: serializer(category), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    def delete
        category = Category.find(params[:id])
        category.destroy!
        render json: serializer(category), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
    
    private
    
    def category_params
        params.require(:category).permit(:title, :description, :id
            
        )
    end

    def array_serializer(categories)
        Panko::ArraySerializer.new(categories, each_serializer: CategorySerializer).to_json
    end

    def serializer(category)
        CategorySerializer.new.serialize_to_json(category)
    end
end
