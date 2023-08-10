class ApplicationController < ActionController::API

    private

    def is_admin_authentication
        unless current_user.is_admin == true
            render json: {message:"Permissão negada"}, status: :unauthorized
        end      
    end

end
