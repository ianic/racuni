class PartnerController < ApplicationController
  #auto_complete_for :partner, :naziv

  #address bok display
  def book
    @title = "Adresar"
    @slova = (@user.partneri.find(:all).collect{|p| p.slovo if (p.naziv && p.slovo != "") }).compact.uniq.sort
  end

  def page
    @partneri = (@user.partneri.find(:all, :order=>"naziv, mjesto_troska", :conditions=>"naziv is not null").collect{|p| p if (p.slovo == params[:page])}).compact
    render :partial => "card_view", :collection => @partneri
  end

  def list
    @partneri = Partner.find_by_sql(
                                    "select p.* , b.broj_dokumenata
      from partner p
      left outer join
      (
      	select partner_id, sum(broj) broj_dokumenata
      	from
      	(
      		select partner_id, count(*) broj from racun group by partner_id
      		union
      		select partner_id, count(*) broj from ulazni_racun group by partner_id
      		union
      		select partner_id, count(*) broj from ponuda group by partner_id
      		union
      		select partner_id, count(*) broj from izdatak group by partner_id
      		union
      		select partner_id, count(*) broj from primitak group by partner_id
      	) p
      	group by partner_id
      ) b on b.partner_id = p.id
      order by p.naziv p.mjesto_troska")
  end

  def zamjena
    stari = Partner.find(params['stari'])
    novi = Partner.find(params['novi'])

    stari.dokumenti.each do |d|
      d.zamjeni_partnera(novi)
    end

    stari = Partner.find(params['stari'])
    logger.info("brisanje partnera: #{stari.to_yaml}")
    stari.destroy

    render :text => 'ok'
  end
  #####################

  #CRUD
  def new
    @partner = @user.partneri.build
    render :partial => 'edit'
  end

  def edit
    @partner = @user.partneri.find(params[:id])
    render :partial=>'edit'
  end

  def update
    @partner = @user.partneri.find(params[:id])
    if @partner.update_attributes(params[:partner])
      render :layout => "nil", :update => true do |page|
        page.replace "partner_#{@partner.id}", :partial => 'card_view', :object => @partner
        page.visual_effect :highlight, "partner_#{@partner.id}"
        page << "editor_window.destroy();"
      end
    else
      render(:partial => 'edit')
    end
  end

  def create
    @partner = @user.partneri.build(params[:partner])
    if @partner.save
      render :layout => "nil", :update => true do |page|
        #render :update do |page|
        page << "ShowAdresarStranica('#{@partner.slovo}');"
        page << "editor_window.destroy();"
      end
    else
      render(:partial => 'edit')
    end
  end
  ######################

  def auto_complete
    limit = 50
    like = params[:partner_search].strip + '%'
    @partneri = @user.partneri.find(:all,
                                    :conditions => [ 'naziv LIKE ?', like ],
                                    :order => 'naziv  ASC, mjesto_troska',
                                    :limit => limit)
    @partneri += @user.partneri.find(:all,
                                     :conditions => [ 'naziv not like ? and naziv LIKE ?', like, '%' + like ],
                                     :order => 'naziv  ASC, mjesto_troska',
                                     :limit => limit - @partneri.size) if @partneri.size < limit
    render :partial => 'auto_complete'
  end

  def view
    render :partial => "view", :object => @user.partneri.find(params[:id])
  end

end
