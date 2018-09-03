class SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)

    @sale.tax   = params[:sale][:tax_exempt] == 1 ? 19 : 0
    @sale.total = @sale.value
    @sale.discount = @sale.discount.to_i
    @sale.total = @sale.discount > 0 ?
                  @sale.total * ((@sale.discount/100)+1) : @sale.total
    @sale.total = @sale.tax > 0 ?
                  @sale.total * ((@sale.tax/100)+1)      : @sale.total

    @sale.save
    redirect_to sales_done_path
  end

  def done
    @sales = Sale.all
  end

  def sale_params
    params.require(:sale).permit(:cod, :detail, :category, :value,
                                 :discount, :tax, :total)
  end
end
