class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'
  
   def order_email(order, user)
     @order = order
     @user = user
     mail(to: @order.email, subject: "Your order #{@order.id}")
   end
end
