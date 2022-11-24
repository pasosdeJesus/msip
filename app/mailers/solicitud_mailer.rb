# frozen_string_literal: true

class SolicitudMailer < ApplicationMailer
  def solicitud
    unless ENV["SMTP_MAQ"]
      Rails.logger.debug("No esta definida variable de ambiente SMTP_MAQ")
      exit(1)
    end
    Rails.logger.debug("OJO solicitud")
    @objeto = params[:objeto]
    Rails.logger.debug { "OJO objeto=#{@objeto}" }
    @id = params[:id]
    Rails.logger.debug { "OJO id=#{@id}" }
    @solicitante = params[:solicitante]
    Rails.logger.debug { "OJO solicitante=#{@solicitante}" }
    @cor_solicitante = params[:cor_solicitante]
    Rails.logger.debug { "OJO cor_solicitante=#{@cor_solicitante}" }
    @solicitado_a = params[:solicitado_a]
    Rails.logger.debug { "OJO solicitado_a=#{@solicitado_a}" }
    @cor_solicitado_a = params[:cor_solicitado_a]
    Rails.logger.debug { "OJO cor_solicitado_a=#{@cor_solicitado_a}" }
    @solicitud = params[:solicitud]
    Rails.logger.debug { "OJO solicitud=#{@solicitud}" }
    @para = @cor_solicitado_a.select { |c| !(c =~ /@localhost$/) }
    Rails.logger.debug { "enviando con tema #{@que} a #{@para.count} receptores" }
    mail(to: @para,
      cc: "vtamara@pasosdeJesus.org",
      subject: "[SI-JRSCOL] Solicitud del usuario #{@solicitante}")
  end
end
