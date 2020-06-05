require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  result_arr = []
  
  cart.each do |cur_item_hash|
    cur_item_hash = cur_item_hash.clone
    cur_item_name = cur_item_hash[:item]
    
    coupon_code_hash = find_item_by_name_in_collection(cur_item_name, coupons)
    
    if coupon_code_hash and (cur_item_hash[:count] >= coupon_code_hash[:num])
      coupon_num = coupon_code_hash[:num]
      coupon_cost = coupon_code_hash[:cost]
      
      coupon_item_hash = cur_item_hash.clone
      coupon_item_hash[:item] += " W/COUPON"
      coupon_item_hash[:count] = coupon_num
      coupon_item_hash[:price] = (coupon_cost / coupon_num).round(2)
      
      
      cur_item_hash[:count] -= coupon_code_hash[:num]
      
      result_arr << cur_item_hash
      result_arr << coupon_item_hash
    else
      result_arr << cur_item_hash
    end
    
  end
  
  return result_arr
end

def apply_clearance(cart)
  result_arr = []
  
  cart.each do |cur_item_hash|
    cur_item_hash = cur_item_hash.clone
    
    if cur_item_hash[:clearance]
      cur_item_hash[:price] = (cur_item_hash[:price] * 0.80).round(2)
      result_arr << cur_item_hash
    else
      result_arr << cur_item_hash
    end
  end
  
  return result_arr
end

def checkout(cart, coupons)
  total = 0 
  
  # consolidated_cart = consolidate_cart(cart)
  # consolidated_cart = apply_coupons(consolidated_cart, coupons)
  # consolidated_cart = apply_clearance(consolidated_cart)
  
  consolidated_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  
  consolidated_cart.each do |item_hash|
    total += item_hash[:price] * item_hash[:count]
  end
  
  if total > 100
    total = (total * 0.90).round(2)
  end
  
  return total
end
