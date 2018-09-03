class SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)

    @sale.tax   = params[:sale][:tax_exempt].to_i.zero? ? 19 : 0
    @sale.total = @sale.value
    @sale.discount = @sale.discount.to_i
    @sale.total = apply_discount @sale.total, @sale.discount
    @sale.total = apply_discount @sale.total, @sale.tax, 1

    @sale.save
    redirect_to sales_done_path
  end

  def done
    @sales = Sale.all
  end

  private

  def apply_discount(value, discount, tax = 0)
    if discount.zero?
      value
    else
      if tax == 1
        value + (value * ((discount.to_f / 100)))
      else
        value - (value * ((discount.to_f / 100)))
      end
    end
  end

  def sale_params
    params.require(:sale).permit(:cod, :detail, :category, :value,
                                 :discount, :tax, :total)
  end
end
