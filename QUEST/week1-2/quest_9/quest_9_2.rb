def convert_currency(amount, source_currency, target_currency, conversion_rates)
    result = conversion_rates[target_currency] * (amount / conversion_rates[source_currency])
    puts result.round
end

conversion_rates = {
    usd: 1.0,
    jpy: 110.0,
    eur: 0.8
}

convert_currency(100, :usd, :jpy, conversion_rates)
convert_currency(300, :usd, :eur, conversion_rates)
convert_currency(16, :eur, :jpy, conversion_rates)
