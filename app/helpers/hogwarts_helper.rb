module HogwartsHelper
  HOG_GAL = 493   # number of Knuts in 1 Galleon
  HOG_SIC = 29    # number of Knuts in 1 Sickle
  HOG_KNU = 1

  def hogwartize(amount)
    if amount < 0
      amount *= -1
      sgn = '-'
    end
    gal = amount/HOG_GAL
    amount -= gal*HOG_GAL
    sic = amount/HOG_SIC
    amount -= sic*HOG_SIC
    knu = amount/HOG_KNU
    return "#{sgn} #{gal}-#{sic}-#{knu}"
  end

  def dehogwartize(money)
    i = 0
    gal = ''
    sic = ''
    knu = ''

    for c in money.split(//) do
      if c == '-' then
        i += 1
      else
        case i
        when 0 then gal.insert(-1, c)
        when 1 then sic.insert(-1, c)
        when 2 then knu.insert(-1, c)
        end
      end
    end
    return (gal.to_i * HOG_GAL) + (sic.to_i * HOG_SIC) + (knu.to_i * HOG_KNU)
  end
  
end