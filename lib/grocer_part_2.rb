require_relative './part_1_solution.rb'
require "pry"
def apply_coupons(cart, coupons)

  coupons.each do |coupon|
    cart.each do |item|
      if(item[:count]>=coupon[:num] && coupon[:item]==item[:item])
        item_with_coupon={}
        item_with_coupon[:item]=item[:item]+" W/COUPON"
        item_with_coupon[:price]= coupon[:cost] / coupon[:num]
        item_with_coupon[:clearance] = item[:clearance]
        item_with_coupon[:count]=coupon[:num]

        cart.push(item_with_coupon)
        item[:count] -= coupon[:num]
        
        end
      end
  end
    cart
  end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item|
    if item[:clearance]==true
      item[:price]=item[:price] - item[:price] * 0.20
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
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidated= consolidate_cart(cart)
  couponized =apply_coupons(consolidated,coupons)
  finalized =apply_clearance(couponized)
  sum=0
  finalized.each do |item|
    sum+=(item[:price]*item[:count])
  end
  if(sum>100)
    sum=sum-sum*0.10
  end
  sum
end
