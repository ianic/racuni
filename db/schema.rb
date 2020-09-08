# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 30) do

  create_table "gotovinski_racun", :force => true do |t|
    t.integer  "partner_id",                                     :default => 0,      :null => false
    t.integer  "godina",                                         :default => 0,      :null => false
    t.integer  "broj",                                           :default => 0,      :null => false
    t.date     "datum",                                                              :null => false
    t.integer  "rok_placanja",                                   :default => 15,     :null => false
    t.string   "pdv_kategorija",                                 :default => "II.2", :null => false
    t.decimal  "osnovica",        :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.decimal  "popust_postotak", :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.decimal  "popust",          :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.decimal  "pdv_postotak",    :precision => 18, :scale => 4, :default => 25.0,   :null => false
    t.decimal  "pdv",             :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.decimal  "iznos",           :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.text     "napomena"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "izdatak", :force => true do |t|
    t.integer  "partner_id"
    t.integer  "godina",                                    :default => 0,   :null => false
    t.integer  "broj",                                      :default => 0,   :null => false
    t.date     "datum",                                                      :null => false
    t.string   "opis",                                      :default => "",  :null => false
    t.integer  "tip_uplate",                                :default => 0,   :null => false
    t.decimal  "iznos",      :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                                   :default => -1,  :null => false
  end

  add_index "izdatak", ["broj"], :name => "index_izdatak_on_broj"
  add_index "izdatak", ["godina"], :name => "index_izdatak_on_godina"
  add_index "izdatak", ["partner_id"], :name => "index_izdatak_on_partner_id"
  add_index "izdatak", ["user_id"], :name => "index_izdatak_on_user_id"

  create_table "kalkulacija", :force => true do |t|
    t.integer "partner_id", :null => false
    t.integer "user_id",    :null => false
    t.integer "godina",     :null => false
    t.integer "broj",       :null => false
    t.date    "datum",      :null => false
    t.string  "dokument"
  end

  create_table "kalkulacija_stavka", :force => true do |t|
    t.integer "stavka_id"
    t.decimal "kolicina",              :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "cijena",                :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "vrijednost",            :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "popust_postotak",       :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "popust",                :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "fakturna_cijena",       :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "fakturna_vrijednost",   :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "trosak",                :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "nabavna_cijena",        :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "nabavna_vrijednost",    :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "marza_postotak",        :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "marza",                 :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "cijena_bez_poreza",     :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "vrijednost_bez_poreza", :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "porez_postotak",        :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "porez",                 :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "cijena_s_porezom",      :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "vrijednost_s_porezom",  :precision => 18, :scale => 4, :default => 0.0, :null => false
  end

  create_table "partner", :force => true do |t|
    t.string   "naziv"
    t.string   "adresa"
    t.string   "mjesto"
    t.string   "tel"
    t.string   "fax"
    t.string   "porezni_broj"
    t.string   "ziro_racun"
    t.string   "kontakt"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",       :default => -1, :null => false
    t.string   "oib"
    t.string   "mjesto_troska"
    t.string   "gln"
  end

  add_index "partner", ["naziv"], :name => "index_partner_on_naziv"
  add_index "partner", ["user_id"], :name => "index_partner_on_user_id"

  create_table "partner_stavka", :id => false, :force => true do |t|
    t.integer "id",                                                         :default => 0,   :null => false
    t.integer "partner_id",                                                 :default => 0,   :null => false
    t.integer "stavka_id"
    t.string  "opis"
    t.string  "jedinica_mjere"
    t.decimal "cijena",                      :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.integer "broj_racuna",    :limit => 8,                                :default => 0,   :null => false
    t.integer "user_id",                                                    :default => -1,  :null => false
  end

  create_table "partner_stavka_ids", :id => false, :force => true do |t|
    t.integer "stavka_id"
    t.integer "broj_racuna",  :limit => 8, :default => 0, :null => false
    t.integer "zadnji_rs_id"
    t.integer "partner_id",                :default => 0, :null => false
  end

  create_table "ponuda", :force => true do |t|
    t.integer  "partner_id",                                     :default => 0,    :null => false
    t.integer  "godina",                                         :default => 0,    :null => false
    t.integer  "broj",                                           :default => 0,    :null => false
    t.date     "datum",                                                            :null => false
    t.integer  "rok_placanja",                                   :default => 3,    :null => false
    t.decimal  "osnovica",        :precision => 18, :scale => 4, :default => 0.0,  :null => false
    t.decimal  "popust_postotak", :precision => 18, :scale => 4, :default => 0.0,  :null => false
    t.decimal  "popust",          :precision => 18, :scale => 4, :default => 0.0,  :null => false
    t.decimal  "pdv_postotak",    :precision => 18, :scale => 4, :default => 25.0, :null => false
    t.decimal  "pdv",             :precision => 18, :scale => 4, :default => 0.0,  :null => false
    t.decimal  "iznos",           :precision => 18, :scale => 4, :default => 0.0,  :null => false
    t.text     "napomena"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                                        :default => -1,   :null => false
    t.string   "uuid"
  end

  add_index "ponuda", ["broj"], :name => "index_ponuda_on_broj"
  add_index "ponuda", ["godina"], :name => "index_ponuda_on_godina"
  add_index "ponuda", ["partner_id"], :name => "index_ponuda_on_partner_id"
  add_index "ponuda", ["user_id"], :name => "index_ponuda_on_user_id"

  create_table "primitak", :force => true do |t|
    t.integer  "partner_id"
    t.integer  "godina",                                                     :null => false
    t.integer  "broj",                                                       :null => false
    t.date     "datum",                                                      :null => false
    t.string   "opis",                                                       :null => false
    t.integer  "tip_uplate",                                :default => 0,   :null => false
    t.decimal  "iznos",      :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                                   :default => -1,  :null => false
  end

  add_index "primitak", ["broj"], :name => "index_primitak_on_broj"
  add_index "primitak", ["godina"], :name => "index_primitak_on_godina"
  add_index "primitak", ["partner_id"], :name => "index_primitak_on_partner_id"
  add_index "primitak", ["user_id"], :name => "index_primitak_on_user_id"

  create_table "racun", :force => true do |t|
    t.integer  "partner_id",                                     :default => 0,      :null => false
    t.integer  "godina",                                         :default => 0,      :null => false
    t.integer  "broj",                                           :default => 0,      :null => false
    t.date     "datum",                                                              :null => false
    t.integer  "rok_placanja",                                   :default => 15,     :null => false
    t.string   "pdv_kategorija",                                 :default => "II.2", :null => false
    t.decimal  "osnovica",        :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.decimal  "popust_postotak", :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.decimal  "popust",          :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.decimal  "pdv_postotak",    :precision => 18, :scale => 4, :default => 25.0,   :null => false
    t.decimal  "pdv",             :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.decimal  "iznos",           :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.decimal  "placeno",         :precision => 18, :scale => 4, :default => 0.0,    :null => false
    t.boolean  "placen",                                         :default => false,  :null => false
    t.text     "napomena"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tip_placanja",                                   :default => 0,      :null => false
    t.integer  "user_id",                                        :default => -1,     :null => false
    t.string   "uuid"
    t.string   "broj_narudzbe"
  end

  add_index "racun", ["broj"], :name => "index_racun_on_broj"
  add_index "racun", ["godina"], :name => "index_racun_on_godina"
  add_index "racun", ["partner_id"], :name => "index_racun_on_partner_id"
  add_index "racun", ["user_id"], :name => "index_racun_on_user_id"

  create_table "racun_placanje", :force => true do |t|
    t.integer  "racun_id",                                  :default => 0,   :null => false
    t.string   "dokument",                                  :default => "",  :null => false
    t.date     "datum",                                                      :null => false
    t.decimal  "iznos",      :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.integer  "tip_uplate",                                :default => 0,   :null => false
    t.datetime "created_at"
  end

  add_index "racun_placanje", ["racun_id"], :name => "index_racun_placanje_on_racun_id"

  create_table "racun_stavka", :force => true do |t|
    t.integer "racun_id",                                  :default => 0,   :null => false
    t.string  "racun_type",                                :default => "",  :null => false
    t.integer "stavka_id"
    t.decimal "cijena",     :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.decimal "kolicina",   :precision => 18, :scale => 4, :default => 0.0, :null => false
    t.string  "lot"
  end

  add_index "racun_stavka", ["racun_id"], :name => "index_racun_stavka_on_racun_id"
  add_index "racun_stavka", ["racun_type"], :name => "index_racun_stavka_on_racun_type"
  add_index "racun_stavka", ["stavka_id"], :name => "index_racun_stavka_on_stavka_id"

  create_table "stavka", :force => true do |t|
    t.string   "opis"
    t.string   "jedinica_mjere"
    t.decimal  "cijena",         :precision => 18, :scale => 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                                       :default => -1, :null => false
  end

  add_index "stavka", ["opis"], :name => "index_stavka_on_opis"
  add_index "stavka", ["user_id"], :name => "index_stavka_on_user_id"

  create_table "test", :id => false, :force => true do |t|
    t.float   "f"
    t.decimal "d", :precision => 10, :scale => 4
    t.decimal "n", :precision => 10, :scale => 4
  end

  create_table "ulazni_racun", :force => true do |t|
    t.integer  "partner_id",                                     :default => 0,       :null => false
    t.integer  "godina",                                         :default => 0,       :null => false
    t.integer  "broj",                                           :default => 0,       :null => false
    t.string   "partner_broj",                                   :default => "",      :null => false
    t.date     "datum",                                                               :null => false
    t.integer  "rok_placanja",                                   :default => 15,      :null => false
    t.decimal  "osnovica",        :precision => 18, :scale => 4, :default => 0.0,     :null => false
    t.decimal  "popust_postotak", :precision => 18, :scale => 4, :default => 0.0,     :null => false
    t.decimal  "popust",          :precision => 18, :scale => 4, :default => 0.0,     :null => false
    t.decimal  "pdv_postotak",    :precision => 18, :scale => 4, :default => 25.0,    :null => false
    t.decimal  "pdv",             :precision => 18, :scale => 4, :default => 0.0,     :null => false
    t.decimal  "ostali_troskovi", :precision => 18, :scale => 4, :default => 0.0,     :null => false
    t.decimal  "iznos",           :precision => 18, :scale => 4, :default => 0.0,     :null => false
    t.decimal  "placeno",         :precision => 18, :scale => 4, :default => 0.0,     :null => false
    t.boolean  "placen",                                         :default => false,   :null => false
    t.integer  "tip_predporeza",                                 :default => 0,       :null => false
    t.integer  "tip_placanja",                                   :default => 0,       :null => false
    t.integer  "tip_knjizenja",                                  :default => 0,       :null => false
    t.string   "pdv_kategorija",                                 :default => "III.2", :null => false
    t.text     "napomena"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                                        :default => -1,      :null => false
  end

  add_index "ulazni_racun", ["broj"], :name => "index_ulazni_racun_on_broj"
  add_index "ulazni_racun", ["godina"], :name => "index_ulazni_racun_on_godina"
  add_index "ulazni_racun", ["partner_id"], :name => "index_ulazni_racun_on_partner_id"
  add_index "ulazni_racun", ["user_id"], :name => "index_ulazni_racun_on_user_id"

  create_table "ulazni_racun_placanje", :force => true do |t|
    t.integer  "ulazni_racun_id",                                               :null => false
    t.string   "dokument",                                                      :null => false
    t.date     "datum",                                                         :null => false
    t.decimal  "iznos",           :precision => 18, :scale => 4,                :null => false
    t.integer  "tip_uplate",                                     :default => 0, :null => false
    t.datetime "created_at"
  end

  add_index "ulazni_racun_placanje", ["ulazni_racun_id"], :name => "index_ulazni_racun_placanje_on_ulazni_racun_id"

  create_table "user", :force => true do |t|
    t.string  "naziv",          :default => "",       :null => false
    t.string  "password",       :default => "",       :null => false
    t.string  "zadnji_izvod",   :default => "",       :null => false
    t.string  "username",       :default => ""
    t.string  "adresa",         :default => ""
    t.string  "mjesto",         :default => ""
    t.string  "porezni_broj",   :default => ""
    t.string  "mbo",            :default => ""
    t.string  "ziro_racun",     :default => ""
    t.integer "godina_od",      :default => 2006
    t.string  "racun_template", :default => "nektar"
    t.string  "tel"
    t.string  "fax"
    t.string  "gsm"
    t.string  "email"
    t.string  "www"
    t.text    "racun_header"
    t.text    "racun_footer"
  end

end
