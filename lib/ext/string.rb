class String
  # Basado en soluciones de
  # http://stackoverflow.com/questions/6541209/decimals-and-commas-when-entering-a-number-into-a-ruby-on-rails-form
  def a_decimal_nolocalizado
    delimiter = I18n.t("number.format.delimiter")
    separator = I18n.t("number.format.separator")
    gsub(/[#{delimiter}#{separator}]/, delimiter => "", separator => ".")
  end

  def a_decimal_localizado
    if !self || self == ""
      return ""
    end

    delimiter = I18n.t("number.format.delimiter")
    # puts "delimiter=#{delimiter}"
    separator = I18n.t("number.format.separator")
    # puts "separator=#{separator}"
    neg = split("-").first
    if neg == ""
      num = split("-")[1]
      neg = "-"
    else
      num = self
      neg = ""
    end
    # puts "neg=#{neg}"
    pent = num.split(".").first
    # puts "pent=#{pent}"
    pdec = num.split(".")[1]
    # puts "pdec=#{pdec}"
    pent = pent.reverse.gsub(/\d{3}/, "\\&#{delimiter}")
    # puts "pent=#{pent}"
    pent = pent.reverse.sub(/^[#{delimiter}]/, "")
    # puts "pent=#{pent}"
    if pdec
      "#{neg}#{pent}#{separator}#{pdec}"
    else
      "#{neg}#{pent}"
    end
  end

  # Convierte una cadena a altas y bajas es decir primera letra de
  # cada palabra mayúscula y las demás de la palabra en minúsculas.
  def altas_bajas
    inip = true
    r = ""
    each_char do |c|
      r << if inip
        c.upcase
      else
        c.downcase
      end
      inip = !c.match(/^[[:alpha:]]$/)
    end
    r
  end
end
