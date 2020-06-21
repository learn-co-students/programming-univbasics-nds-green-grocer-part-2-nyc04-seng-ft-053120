require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # REMEMBER: This method **should** update cart
  coupons.each do |element|
    cart.each do |cart_item|
      if cart_item[:count] >= element[:num] && cart_item[:item] == element[:item]
      updated_item = {}
      updated_item[:item] = cart_item[:item] + " W/COUPON"
      updated_item[:price] = element[:cost] / element[:num] 
      updated_item[:clearance] = cart_item[:clearance]
      updated_item[:count] = element[:num]
      cart << updated_item
      cart_item[:count] -= element[:num] 
    end
    end 
  end 
  cart
end
=begin
[
  {
    :item => "AVOCADO", 
    :price => 3.00, 
    :clearance => true, 
    :count => 3
  },
  {
    :item => "KALE",    
    :price => 3.00, 
    :clearance => false, 
    :count => 1
  }
]
and an Array with a single coupon:
[
  {:item => "AVOCADO", :num => 2, :cost => 5.00}
]
then `apply_coupons` should change the first Array to look like:
[
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 1},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 1},
  {:item => "AVOCADO W/COUPON", :price => 2.50, :clearance => true, :count => 2}
]
=end 

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
