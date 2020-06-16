require_relative './part_1_solution.rb'

require "pry"

def apply_coupons(cart, coupons)
  checkout_cart = cart

  cart.each { |item|
    index = 0
    while coupons.length > index
      if item[:item] == coupons[index][:item] && item[:count] >= coupons[index][:num]
        checkout_cart << {item: "#{coupons[index][:item]} W/COUPON", price: coupons[index][:cost]/coupons[index][:num], clearance: item[:clearance], count: coupons[index][:num]}

        if item[:count] - coupons[index][:num] <= 0
          item[:count] = 0
        else
          item[:count] = item[:count] - coupons[index][:num]
        end
      end
      index += 1
    end
  }
  
  checkout_cart
end

def apply_clearance(cart)
  checkout_cart = cart

  checkout_cart.each { |item|
    if item[:clearance] == true
      item[:price] = (item[:price] * 0.8).round(2)
    end
  }

  checkout_cart
end

def checkout(cart, coupons)
  checkout_cart_1 = consolidate_cart(cart)
  checkout_cart_2 = apply_coupons(checkout_cart_1, coupons)
  final_cart = apply_clearance(checkout_cart_2)

  price = 0

  final_cart.each { |item| 
    price = price + item[:price] * item[:count]
  }

  if price > 100
    price = price * 0.9
  end

  price
end