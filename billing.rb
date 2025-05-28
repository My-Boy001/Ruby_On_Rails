class BillingCalculator
  attr_accessor :subtotal, :tax_rate, :discount_rate, :shipping_cost, :currency

  def initialize(subtotal: 0.0, tax_rate: 0.08, currency: 'USD')
    @subtotal = subtotal.to_f
    @tax_rate = tax_rate.to_f
    @discount_rate = 0.0
    @shipping_cost = 0.0
    @currency = currency
    @line_items = []
  rescue StandardError => e
    puts "Error during initialization: #{e.message}"
    @subtotal = 0.0
    @tax_rate = 0.08
    @discount_rate = 0.0
    @shipping_cost = 0.0
    @currency = 'USD'
    @line_items = []
  end

  def add_item(name, price, quantity: 1, tax_exempt: false, category: 'general')
    item = {
      name: name,
      price: price.to_f,
      quantity: quantity.to_i,
      tax_exempt: tax_exempt,
      category: category,
      total: price.to_f * quantity.to_i
    }

    @line_items << item
    @subtotal += item[:total]
    self
  rescue StandardError => e
    puts "Error adding item: #{e.message}"
    self
  end

  def apply_discount(rate: 0.0, amount: nil, code: nil)
    if amount
      @discount_amount = amount.to_f
      @discount_rate = @discount_amount / @subtotal if @subtotal > 0
    else
      @discount_rate = rate.to_f
      @discount_amount = @subtotal * @discount_rate
    end

    puts "Applied discount: #{code || 'Generic'} - #{format_currency(@discount_amount)}"
    self
  rescue StandardError => e
    puts "Error applying discount: #{e.message}"
    @discount_rate = 0.0
    @discount_amount = 0.0
    self
  end

  def add_shipping(cost: 0.0, method: 'standard', expedited: false, free_threshold: 100.0)
    if expedited
      @shipping_cost = cost * 1.5
      @shipping_method = "#{method} (expedited)"
    elsif @subtotal >= free_threshold
      @shipping_cost = 0.0
      @shipping_method = "#{method} (free shipping)"
    else
      @shipping_cost = cost.to_f
      @shipping_method = method
    end

    puts "Shipping: #{@shipping_method} - #{format_currency(@shipping_cost)}"
    self
  rescue StandardError => e
    puts "Error adding shipping: #{e.message}"
    @shipping_cost = 0.0
    @shipping_method = 'standard'
    self
  end

  def calculate_tax(rate: nil, exempt_categories: [], include_shipping: true)
    effective_rate = rate || @tax_rate
    taxable_amount = 0.0

    @line_items.each do |item|
      unless item[:tax_exempt] || exempt_categories.include?(item[:category])
        taxable_amount += item[:total]
      end
    end

    taxable_amount -= @discount_amount || 0.0
    taxable_amount = [taxable_amount, 0.0].max
    taxable_amount += @shipping_cost if include_shipping

    @tax_amount = taxable_amount * effective_rate
    self
  rescue StandardError => e
    puts "Error calculating tax: #{e.message}"
    @tax_amount = 0.0
    self
  end

  def process_payment(method: 'credit_card', installments: 1, fee_rate: 0.029)
    @payment_method = method
    @installments = installments
    total = calculate_total

    @processing_fee =
      case method
      when 'credit_card'
        total * fee_rate
      when 'bank_transfer'
        [total * 0.01, 5.0].min
      when 'cash'
        0.0
      else
        total * 0.02
      end

    @final_total = total + @processing_fee

    if installments > 1
      @installment_amount = @final_total / installments
      puts "Payment: #{installments} installments of #{format_currency(@installment_amount)}"
    end

    self
  rescue StandardError => e
    puts "Error processing payment: #{e.message}"
    @processing_fee = 0.0
    @final_total = calculate_total rescue 0.0
    self
  end

  def generate_report(format: 'detailed', include_items: true, show_calculations: false)
    report = []
    report << "=" * 50
    report << "BILLING REPORT (#{@currency})"
    report << "=" * 50

    if include_items && format == 'detailed'
      report << "\nLINE ITEMS:"
      @line_items.each_with_index do |item, index|
        tax_status = item[:tax_exempt] ? " (tax exempt)" : ""
        report << "#{index + 1}. #{item[:name]} - #{format_currency(item[:price])} x #{item[:quantity]}#{tax_status}"
        report << "   Category: #{item[:category]} | Total: #{format_currency(item[:total])}"
      end
    end

    report << "\nSUMMARY:"
    report << "Subtotal: #{format_currency(@subtotal)}"

    if @discount_amount && @discount_amount > 0
      report << "Discount: -#{format_currency(@discount_amount)} (#{(@discount_rate * 100).round(2)}%)"
    end

    if @shipping_cost > 0
      report << "Shipping (#{@shipping_method}): #{format_currency(@shipping_cost)}"
    end

    if @tax_amount
      report << "Tax (#{(@tax_rate * 100).round(2)}%): #{format_currency(@tax_amount)}"
    end

    if show_calculations
      report << "\nCALCULATIONS:"
      report << "Pre-tax total: #{format_currency((@subtotal - (@discount_amount || 0) + @shipping_cost))}"
      report << "Tax calculation: #{format_currency(@tax_amount || 0)}"
    end

    if @processing_fee && @processing_fee > 0
      report << "Processing fee (#{@payment_method}): #{format_currency(@processing_fee)}"
    end

    report << "-" * 30
    report << "TOTAL: #{format_currency(@final_total || calculate_total)}"

    if @installments && @installments > 1
      report << "Installments: #{@installments} x #{format_currency(@installment_amount)}"
    end

    puts report.join("\n")
    self
  rescue StandardError => e
    puts "Error generating report: #{e.message}"
    puts "BILLING REPORT - ERROR"
    puts "Total: #{format_currency(@final_total || 0)}"
    self
  end

  private

  def calculate_total
    base_total = @subtotal - (@discount_amount || 0.0) + @shipping_cost + (@tax_amount || 0.0)
    [base_total, 0.0].max
  rescue StandardError => e
    puts "Error calculating total: #{e.message}"
    0.0
  end

  def format_currency(amount)
    case @currency
    when 'USD'
      "$#{'%.2f' % amount}"
    when 'EUR'
      "€#{'%.2f' % amount}"
    when 'GBP'
      "£#{'%.2f' % amount}"
    else
      "#{@currency} #{'%.2f' % amount}"
    end
  rescue StandardError => e
    puts "Error formatting currency: #{e.message}"
    "#{@currency} 0.00"
  end
end

puts "=== EXAMPLE 1: Bulk Order with Custom Settings ==="
BillingCalculator.new(subtotal: 0, tax_rate: 0.075)
  .add_item('Widget A', 12.50, quantity: 100, category: 'wholesale')
  .add_item('Widget B', 8.99, quantity: 50, tax_exempt: false)
  .add_item('Shipping Materials', 25.00, tax_exempt: true, category: 'materials')
  .apply_discount(rate: 0.15, code: 'BULK15')
  .add_shipping(cost: 50.0, free_threshold: 1000.0)
  .calculate_tax(exempt_categories: ['materials'])
  .process_payment(method: 'cash')
  .generate_report

puts "\n=== METHOD SIGNATURE EXAMPLES ==="
calc1 = BillingCalculator.new
puts "Default init: #{calc1.currency}, tax rate: #{calc1.tax_rate}"

calc2 = BillingCalculator.new(currency: 'GBP', tax_rate: 0.20)
puts "Custom init: #{calc2.currency}, tax rate: #{calc2.tax_rate}"

calc3 = BillingCalculator.new
calc3.add_item('Test Item', 100.0)
calc3.add_item('Premium Item', 200.0, quantity: 2)
calc3.add_item('Tax-free Item', 50.0, tax_exempt: true, category: 'exempt')
puts "Final subtotal: #{calc3.subtotal}"