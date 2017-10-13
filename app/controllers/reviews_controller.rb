class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    @product = Product.find(params[:product_id])    
    @review = @product.reviews.create(review_params)

    if @review.save!
      redirect_to @product, notice: 'Review was successfully created.'
    else
      render template: 'products/show'
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to "/products/#{@review.product_id}", notice: 'Review deleted!'
  end

  private

    def review_params
      params.require(:review).permit(:description, :rating).merge(user: current_user)
    end


end
