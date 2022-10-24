
Rails.application.reloader.to_prepare do
  Msip::Mundep.refresca()
end

