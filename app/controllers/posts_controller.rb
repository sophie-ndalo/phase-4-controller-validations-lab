class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def update
    post = Post.find(params[:id])
    post.update!(post_params)

    render json: post
  end

  private

  def post_params
    params.permit(:title, :content, :category, :author_id)
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.as_json }, status: :unprocessable_entity
  end
  
end
