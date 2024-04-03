class ExercisesController < ApplicationController
  def exercise1
    # 【要件】注文されていないすべての料理を返すこと
    #   * left_outer_joinsを使うこと
        @foods = Food.left_outer_joins(:orders).where(orders: { id: nil })
        
  end

  def exercise2
    # 【要件】注文されていない料理を提供しているすべてのお店を返すこと
    #   * left_outer_joinsを使うこと
     @shops = Shop.eager_load(foods: :order_foods).where(order_foods: { food_id: nil }).distinct
  end

  def exercise3 
    # 【要件】配達先の一番多い住所を返すこと
    #   * joinsを使うこと
    #   * 取得したAddressのインスタンスにorders_countと呼びかけると注文の数を返すこと
  @address = Address.joins(:orders)
                    .group('addresses.id')
                    .order('COUNT(orders.id) DESC')
                    .select('addresses.*, COUNT(orders.id) AS orders_count')
                    .first
  end

  def exercise4 
    # 【要件】一番お金を使っている顧客を返すこと
    #   * joinsを使うこと
    #   * 取得したCustomerのインスタンスにfoods_price_sumと呼びかけると合計金額を返すこと
    @customer = Customer.joins(orders: { order_foods: :food })
                        .group('customers.id')
                        .order('SUM(foods.price) DESC')
                        .select('customers.*, SUM(foods.price) AS foods_price_sum')
                        .first
  end
end

