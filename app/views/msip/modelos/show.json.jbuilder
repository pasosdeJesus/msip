# frozen_string_literal: true

l = []
atributos_show_json.each do |atr|
  if atr&.respond_to?(:to_sym)
    l << atr.to_sym
  end
end
json.extract!(@registro, *l)
