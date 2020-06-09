require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  index = 0

  coupons.each do |product|
    discount = find_item_by_name_in_collection(product[:item], cart)
    if discount && (discount[:count] >= product[:num])
      cart << { 
              item: "#{discount[:item]} W/COUPON",
              price: product[:cost] / product[:num],
              clearance: discount[:clearance],
              count: product[:num]
              }
      discount[:count] -= product[:num]
    end
    index += 1
  end

  cart
end

def apply_clearance(cart)
  cart.map do |product|
    if product[:clearance]
      product[:price] *= 0.8
    end
    product
  end
end

def checkout(cart, coupons)
  shopping_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  
  total = 0
  
  shopping_cart.map do |calculate|
    total += calculate[:price] * calculate[:count]
  end

  if total > 100 
    total *= 0.9
  end

  total.round(2)
end
