class UsersController < ApplicationController
    ##the render method is used to render a response back to the client-side after an action is completed.
    ##the render method is used in Rails to generate an HTTP response with a specified format (e.g. JSON), HTTP status code, and other optional parameters like headers and cookies.
    # GET /users
    def index
      # Return all users in the database
      render json: User.all, status: :ok
    end
    # GET /users/:id
    def show
      # Find the user with the given ID
      user = User.find_by(id: params[:id])
      if user
        # If the user exists, return their information
        render json: user, status: :ok
      else
        # If the user doesn't exist, return an error
        render json: {error: 'User not found'}, status: :not_found
      end
    end
    # POST /users
    def create
      # Create a new user with the given parameters
      user = User.create(user_params)
      if user.valid?
        # If the user is valid, return their information
        render json: user, status: :created
      else
        # If the user is not valid, return an error
        render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
      end
    end
    # PUT/PATCH /users/:id
    def update
      # Find the user with the given ID
      user = User.find_by(id: params[:id])
      if user
        # If the user exists, update their information with the given parameters
        user.update(user_params)
        render json: user, status: :ok
      else
        # If the user doesn't exist, return an error
        render json: {error: 'User not found'}, status: :not_found
      end
    end
    # DELETE /users/:id
    def destroy
      # Find the user with the given ID
      user = User.find_by(id: params[:id])
      if user
        # If the user exists, delete them and return a success response
        user.destroy
        head :no_content
      else
        # If the user doesn't exist, return an error
        render json: {error: 'User not found'}, status: :not_found
      end
    end
    private
    def user_params
      # Define the permitted user parameters
      params.permit(:user_name, :email, :password, :gender, presence: true)
    end
  end
#assignment=>how to add query parameters to an endpoint
#/users?stauts ="incomplete"$created_at="20/01/2023"
#create a frontend todo application
#authentication/authroization
#how to handle state manangement redux/context