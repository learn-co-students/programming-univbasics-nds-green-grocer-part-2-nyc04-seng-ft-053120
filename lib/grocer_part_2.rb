require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons) #This method **should** update cart
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

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance] == true
      item[:price] = item[:price].round(2)  - (item[:price] * 0.20) 
    end 
  end 
  cart 
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  total = []
  grand_total = []
  new_cart.each do |item|
    total = item[:price] * item[:count]
    grand_total << total 
  end
  grand_total = grand_total.sum
  if grand_total >= 100
    grand_total = grand_total - (grand_total * 0.10)
  end
  grand_total
end