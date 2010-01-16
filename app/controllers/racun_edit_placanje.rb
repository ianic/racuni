module RacunEditPlacanje
  
  def add_placanje
    saved = @racun.placanja << (@racun_placanje = @racun.placanja.new(params[:racun_placanje]))
    @racun.placanja(true) if !saved
    @racun_placanje = nil if saved
    nova_uplata if saved
    render :partial => "racun_placanje/update", :locals => {:update_racun_row => saved, :close_editor => saved}
  end
  
  def delete_placanje
    @racun.placanja.delete(@racun.placanja.find(params[:placanje_id]))
    nova_uplata
    render :partial => "racun_placanje/update", :locals => {:update_racun_row => true, :close_editor => false}
  end
  
  def edit_placanje
    @title = naziv_dokumenta(@racun)
    nova_uplata
    render :partial => "racun/placanje"
  end
  
  def nova_uplata
    return if @racun.placen
    @racun_placanje = @racun.placanja.new(
      :iznos => @racun.za_naplatu, 
      :datum => -1.days.from_now, 
      :dokument =>  @user.zadnji_izvod)
  end

end