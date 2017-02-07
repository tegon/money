require 'minitest/autorun'
require 'tegon/money'

class Tegon::MoneyTest < Minitest::Test
  def setup
    Tegon::Money.conversion_rates('EUR', 'USD' => 1.11, 'Bitcoin' => 0.0047)
    @fifty_eur = Tegon::Money.new(50, 'EUR')
    @twenty_dollars = Tegon::Money.new(20, 'USD')
  end

  def test_that_base_currency_is_set
    assert_equal 'EUR', Tegon::Money.base_currency
  end

  def test_that_rates_is_set
    rates = { 'USD' => 1.11, 'Bitcoin' => 0.0047 }
    assert_equal rates, Tegon::Money.rates
  end

  def test_that_amount_is_set
    assert_equal 50, @fifty_eur.amount
  end

  def test_that_currency_is_set
    assert_equal 'EUR', @fifty_eur.currency
  end

  def test_inspect
    assert_equal '50.00 EUR', @fifty_eur.inspect
  end

  def test_currency_conversion
    conversion = @fifty_eur.convert_to('USD')
    assert_equal '55.50 USD', conversion.inspect
  end

  def test_conversion_to_base_currency
    conversion = @twenty_dollars.convert_to('EUR')
    assert_equal '18.02 EUR', conversion.inspect
  end

  def test_conversion_throws_an_error_with_unknown_currency
    assert_raises Tegon::Money::ConversionRateMissingError do
      @fifty_eur.convert_to('BRL')
    end
  end

  def test_sum
    sum = @fifty_eur + @twenty_dollars
    assert_equal '68.02 EUR', sum.inspect
  end

  def test_subtraction
    subtraction = @fifty_eur - @twenty_dollars
    assert_equal '31.98 EUR', subtraction.inspect
  end

  def test_division
    division = @fifty_eur / 2
    assert_equal '25.00 EUR', division.inspect
  end

  def test_multiplication
    multiplication = @twenty_dollars * 3
    assert_equal '60.00 USD', multiplication.inspect
  end

  def test_that_is_equal_with_same_currency_and_amount
    assert_equal @twenty_dollars, Tegon::Money.new(20, 'USD')
  end

  def test_that_is_not_equal_with_same_currency_and_different_amount
    refute_equal @twenty_dollars, Tegon::Money.new(30, 'USD')
  end

  def test_that_is_equal_after_converted
    assert_equal @fifty_eur.convert_to('USD'), Tegon::Money.new(55.50, 'USD')
  end

  def test_greater_than
    assert @twenty_dollars > Tegon::Money.new(5, 'USD')
  end

  def test_greater_than_or_equal_when_greater
    assert @twenty_dollars >= Tegon::Money.new(5, 'USD')
  end

  def test_greater_than_or_equal_when_equal
    assert @twenty_dollars >= Tegon::Money.new(20, 'USD')
  end

  def test_lower_than
    assert @twenty_dollars < @fifty_eur
  end

  def test_lower_than_or_equal_when_lower
    assert @twenty_dollars <= @fifty_eur
  end

  def test_lower_than_or_equal_when_equal
    assert @twenty_dollars <= Tegon::Money.new(20, 'USD')
  end
end
