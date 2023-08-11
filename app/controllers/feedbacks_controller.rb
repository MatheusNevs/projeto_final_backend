class FeedbacksController < ApplicationController
    acts_as_token_authentication_handler_for User

    
    def create
        feedback = Feedback.new({like: params[:like], comment: params[:comment], user_id: params[:user_id], post_id: params[:post_id]})
        feedback.save!
        render json: serializer(feedback), status: :created
    rescue StandardError => e
        render json: { error: e}, status: :bad_request
    rescue => e
        render json: { error: e}, status: :unauthorized
    end
    
    
    def update
        feedback = Feedback.find(params[:id])
        feedback.update!(feedback_params)
        render json: serializer(feedback), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    rescue => e
        render json: { error: e}, status: :unauthorized
    end
    
    def delete
        feedback = Feedback.find(params[:id])
        feedback.destroy!
        render json: serializer(feedback), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    rescue => e
        render json: { error: e}, status: :unauthorized
    end
    
    private
    
    def feedback_params
        params.require(:feedback).permit(:like, :comment, :user_id, :post_id
        )
    end

    def array_serializer(posts)
        Panko::ArraySerializer.new(posts, each_serializer: FeedbackSerializer).to_json
    end

    def serializer(post)
        FeedbackSerializer.new.serialize_to_json(post)
    end

end