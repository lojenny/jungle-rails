require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it('should be valid with all 4 categories ') do
      category = Category.new
      category.name = 'toy'

      product = Product.new
      product.name = 'Pooch'
      product.price = 10.00
      product.quantity = 2
      product.category = category
      expect(product).to be_valid
    end

    it('should be invalid without a name') do
      category = Category.new
      category.name = 'toy'

      product = Product.new
      product.price = 10.00
      product.quantity = 2
      product.category = category
      expect(product).to_not be_valid
      expect(product.errors.messages[:name]).to include('can\'t be blank')
    end

    it('should be invalid without a price') do
      category = Category.new
      category.name = 'toy'
      
      product = Product.new
      product.name = 'Pooch'
      product.quantity = 2
      product.category = category
      expect(product).to_not be_valid
      expect(product.errors.messages[:price]).to include('can\'t be blank')
    end

    it('should be invalid without a quantity') do
      category = Category.new
      category.name = 'toy'
      
      product = Product.new
      product.price = 10.00
      product.name = 'Pooch'
      product.category = category
      expect(product).to_not be_valid
      expect(product.errors.messages[:quantity]).to include('can\'t be blank')
    end

    it('should be invalid without a category') do
      product = Product.new
      product.price = 10.00
      product.quantity = 2
      product.name = 'Pooch'
      expect(product).to_not be_valid
      expect(product.errors.messages[:category]).to include('can\'t be blank')
    end
  end
end
