# tegon-money
Currency conversion library

[![Build Status](https://travis-ci.org/tegon/money.svg?branch=master)](https://travis-ci.org/tegon/money)

# Usage
---

### Configuration

First you have to configure the base currency and conversion rates.

```ruby
Tegon::Money.conversion_rates(String, Hash)
```

#### Example

```ruby
Tegon::Money.conversion_rates('BRL', 'USD' => 3.12, 'EUR' => 3.34)
```

### Constructor

The constructor accepts two arguments, the amount and the currency:

```ruby
money = Tegon::Money.new(Numeric, String)
```

#### Example

```ruby
money = Tegon::Money.new(50, 'BRL')
money = Tegon::Money.new(55.50, 'BRL')
```

# Methods
---

### #convert_to

This method returns a new `Tegon::Money` instance with the currency passed as argument.

```ruby
new_money = money.convert_to(String)
```

#### Example

```ruby
new_money = money.convert_to('USD')
=> "156.00 USD"
```

If you pass an unknown currency, you'll get a error:

```ruby
new_money = money.convert_to('CAD')
=> "Tegon::Money::ConversionRateMissingError: Missing conversion rate for currency: CAD. Please set it using Tegon::Money.conversion_rates"
```

The following arithmetic operations are supported:

### Sum

```ruby
sum = money + other_money
```

#### Example

```ruby
sum = Tegon::Money.new(10, 'BRL') + Tegon::Money.new(50, 'BRL')
=> "60.00 BRL"
sum = Tegon::Money.new(10, 'BRL') + Tegon::Money.new(50, 'USD')
=> "166.00 BRL"
```

### Subtraction

```ruby
subtraction = money - other_money
```

#### Example

```ruby
subtraction = Tegon::Money.new(50, 'BRL') - Tegon::Money.new(10, 'BRL')
=> "40.00 BRL"
subtraction = Tegon::Money.new(200, 'BRL') - Tegon::Money.new(50, 'USD')
=> "44.00 BRL"
```

### Division

```ruby
division = money / Numeric
```

#### Example

```ruby
division = Tegon::Money.new(50, 'BRL') / 2
=> "25.00 BRL"
```

### Multiplication

```ruby
multiplication = money * Numeric
```

#### Example

```ruby
multiplication = Tegon::Money.new(50, 'BRL') * 2
=> "100.00 BRL"
```

### Comparisons

The comparisons are based on the money result. If a different currencies are used, the one on the right will be converted.


#### Example

```ruby
Tegon::Money.new(156, 'BRL') == Tegon::Money.new(156, 'BRL') # same amount, same currency, returns true
=> true
Tegon::Money.new(156, 'BRL') == Tegon::Money.new(50, 'USD') # different amount and currency, but 50 USD converted to BRL is 156, the result is true
=> true
Tegon::Money.new(50, 'BRL') == Tegon::Money.new(156, 'BRL') # same currency, different amount, returns false
=> false
Tegon::Money.new(50, 'BRL') == Tegon::Money.new(50, 'USD') # same currency, same amount, returns false (1 USD is 3.12 BRL)
=> false
Tegon::Money.new(50, 'USD') > Tegon::Money.new(50, 'BRL') # 50 USD is 156 BRL
=> true
Tegon::Money.new(50, 'USD') < Tegon::Money.new(50, 'BRL') # 50 USD is 156 BRL
=> false
```

# Development
---

You need ruby version 1.9.3 or newer installed. After you've installed it, clone the repository with:

```bash
git clone https://github.com/tegon/money
```

Then run the test suite to make sure everything is working correctly:

```bash
cd money
rake test
```
