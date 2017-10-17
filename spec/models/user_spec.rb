require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context "on a new user" do

      it "should not be valid without a first name" do
        user = User.new(last_name: 'last', email: 'email@email.com', password: 'password')
        expect(user).to_not be_valid
        expect(user.errors.messages[:first_name]).to include('can\'t be blank')        
      end

      it "should not be valid without a last name" do
        user = User.new(first_name: 'first', email: 'email@email.com', password: 'password')
        expect(user).to_not be_valid
        expect(user.errors.messages[:last_name]).to include('can\'t be blank')           
      end

      it "should not be valid without an email" do
        user = User.new(first_name: 'first', last_name: 'last', password: 'password')
        expect(user).to_not be_valid
        expect(user.errors.messages[:email]).to include('can\'t be blank')                  
      end

      it "should not be valid without a password" do
        user = User.new(first_name: 'first', last_name: 'last', email: 'email@email.com')        
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to include('can\'t be blank')                  
      end

      it "should not be valid with a short password" do
        user = User.new(first_name: 'first', last_name: 'last', email: 'email@email.com', password: 'short', password_confirmation: 'short')
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to include('is too short (minimum is 8 characters)')                  
        
      end

      it "should not be valid with a confirmation mismatch" do
        user = User.new(first_name: 'first', last_name: 'last', email: 'email@email.com', password: 'shortpassword', password_confirmation: 'short')
        expect(user).to_not be_valid
        # expect(user.errors.messages[:password]).to include('can\'t be blank')     
      end

      it "should not be valid with a non-uniqe email and case insensitive" do
        user = User.create!(first_name: 'first', last_name: 'last', password: 'password', password_confirmation: 'password', email: 'long@long.com')
        user = User.create(first_name: 'first', last_name: 'last', password: 'password', password_confirmation: 'password', email: 'LONG@LONG.com')
        expect(user).to_not be_valid
        expect(user.errors.messages[:email]).to include('has already been taken')      
      end 

    end
  end

  describe '.authenticate_with_credentials' do
    context 'on a new login' do
      it "should be valid for a valid email and password" do
        user = User.create(first_name: 'first', last_name: 'last', password: 'password', email: 'long@long.com')
        user2 = User.authenticate_with_credentials(user.email, user.password)
        expect(user.id).to be(user2.id)
      end

      it "should not be valid for an invalid email and password" do
        user = User.create(first_name: 'first', last_name: 'last', password: 'password', email: 'long@long.com')
        user2 = User.authenticate_with_credentials('short@short.com', user.password)
        expect(user2).to be(nil)
      end

      it "should be valid for a valid email and invalid password" do
        user = User.create(first_name: 'first', last_name: 'last', password: 'password', email: 'long@long.com')
        user2 = User.authenticate_with_credentials(user.email, 'passwordddd')
        expect(user2).to be(nil)
        end

      it "should be valid for a valid email with spaces" do
        user = User.create(first_name: 'first', last_name: 'last', password: 'password', email: 'long@long.com')
        user2 = User.authenticate_with_credentials('  long@long.com  ', user.password)
        expect(user.id).to be(user2.id)
      end

      it "should be valid for a valid email with capital letters" do
        user = User.create(first_name: 'first', last_name: 'last', password: 'password', email: 'long@long.com')
        user2 = User.authenticate_with_credentials('LONG@long.com', user.password)
        expect(user.id).to be(user2.id)
      end

    end
  end
end
