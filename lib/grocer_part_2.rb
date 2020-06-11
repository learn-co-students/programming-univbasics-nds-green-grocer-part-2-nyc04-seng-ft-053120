require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  # Loop through each coupon in coupons array
  coupons.each do |coupon|
    
    # Create a variable to store the coupon item
    coupon_item = find_item_by_name_in_collection(coupon[:item], cart)
    
    # Create a variable that tells us if the coupon item exists in the cart, set to boolean value of coupon_item (if find_item_in_cart function results to nil, then coupon_item_is_in_cart will be false)
    coupon_item_is_in_cart = !!coupon_item
    
    # If the coupon item is in the cart and we have enough of the items to use the coupon, then push the new hash into cart
    if coupon_item_is_in_cart && coupon_item[:count] >= coupon[:num]
      
      discounted_item_hash = {}
      discounted_item_hash[:item] = coupon_item[:item] + " W/COUPON"
      discounted_item_hash[:price] = coupon[:cost] / coupon[:num]
      discounted_item_hash[:clearance] = coupon_item[:clearance]
      discounted_item_hash[:count] = coupon[:num]
      
      cart << discounted_item_hash
      
      # Update the cart's item
      coupon_item[:count] -= coupon[:num]
    end
  end
  
  # Return cart
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  # Loop through each item in cart, if the item is on clearance, set the price of the item to a discount price of 20% less
  cart.each do |item|
    if item[:clearance] 
      item[:price] = (item[:price] - (item[:price] * 0.20)).round(2)
    end
  end
  
  # Return cart
  cart
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
  
  # First consolidate the cart
  consolidated_cart = consolidate_cart(cart)
  
  # Then apply the coupons
  applied_coupon_cart = apply_coupons(consolidated_cart, coupons)

  # Then send it to apply_clearance
  applied_clearance_cart = apply_clearance(applied_coupon_cart)

  # Add up prices in cart
  total_price = 0
  applied_clearance_cart.each { |item| total_price += item[:price] * item[:count] }
  
  # If price is over 100 dollars, apply a 10% discount
  if total_price > 100.00
    total_price = total_price - (total_price * 0.10)
  end

  total_price.round(2)

end
