require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  cart.each do |grocery_item|
    coupons.each do |coupon|
      if grocery_item[:item] == coupon[:item] && coupon[:num] <= grocery_item[:count]
        grocery_item[:count] -= coupon[:num]
        discounted_grocery_item = {}
        discounted_grocery_item[:item] = "#{grocery_item[:item]} W/COUPON"
        discounted_grocery_item[:price] = (coupon[:cost]/coupon[:num])
        discounted_grocery_item[:clearance] = grocery_item[:clearance]
        discounted_grocery_item[:count] = coupon[:num]
        cart << discounted_grocery_item
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |grocery_item|
    if grocery_item[:clearance]
      grocery_item[:price] = (grocery_item[:price]*0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  total_price = 0
  apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).each do |grocery_item|
    if grocery_item[:count] >= 1
      total_price += grocery_item[:price]*grocery_item[:count]
    end
  end
  if total_price >= 100
    total_price = total_price*0.9
  end
  total_price
end