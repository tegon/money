require 'bigdecimal'

class Money
  class ConversionRateMissingError < RuntimeError
  end

  @base_currency = 'USD'
  @rates = {}

  class << self
    attr_accessor :base_currency, :rates

    def conversion_rates(base_currency, rates)
      self.base_currency = base_currency
      self.rates = rates
    end

    def amount_from_cents(cents)
      cents / 100.0
    end

    def cents_from_amount(amount)
      BigDecimal.new(amount.to_s) * 100
    end

    def conversion_rate_for(currency)
      if rates.has_key?(currency)
        rates[currency]
      else
        message = "Missing conversion rate for currency: #{currency}. Please set it using Tegon::Money.conversion_rates"
        raise ConversionRateMissingError.new(message)
      end
    end
  end

  attr_accessor :amount, :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def inspect
    "%.2f" % Money.amount_from_cents(cents) + " #{currency}"
  end

  def cents
    @cents ||= Money.cents_from_amount(amount)
  end

  def convert_to(new_currency)
    new_cents = if new_currency == Money.base_currency
      cents / Money.conversion_rate_for(currency)
    else
      Money.conversion_rate_for(new_currency) * cents
    end

    Money.new(Money.amount_from_cents(new_cents), new_currency)
  end

  def ==(money)
    cents == money.cents
  end

  def +(money)
    new_cents = cents + money.convert_to(currency).cents
    Money.new(Money.amount_from_cents(new_cents), currency)
  end

  def -(money)
    new_cents = cents - money.convert_to(currency).cents
    Money.new(Money.amount_from_cents(new_cents), currency)
  end

  def /(value)
    new_cents = cents / value
    Money.new(Money.amount_from_cents(new_cents), currency)
  end

  def *(value)
    new_cents = cents * value
    Money.new(Money.amount_from_cents(new_cents), currency)
  end

  def >(money)
    cents > money.cents
  end

  def >=(money)
    cents >= money.cents
  end

  def <(money)
    cents < money.cents
  end

  def <=(money)
    cents <= money.cents
  end
end
