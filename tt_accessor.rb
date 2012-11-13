# -*- coding: utf-8 -*-

require 'tokyotyrant'
include TokyoTyrant
require File.expand_path(File.dirname(__FILE__)) +'/const.rb'

@@connection = nil
# === クラス概要
# TokyoTyrantアクセサ
# TokyoTyrantに関する操作をする
class TT_Accessor

  HOST = Const::Settings::HOST
  PORT = Const::Settings::PORT

  # === TT_Accessor用クラスメソッド
  # 本メソッドはTokyoTyrantへ接続するためのクラスである。
  def self.connect
   if @@connection.nil?
      # generate connection and connect
      @@connection = TokyoTyrant::RDB::new
      connected = @@connection.open(HOST, PORT)
      @@connection = nil unless connected
    end

  end

  # ===TT_Accessor用クラスメソッド
  # 本メソッドはTokyoTyrantへキーと値を格納するためのメソッドである。
  def self.put(key, value)
    unless @@connection
      @@connection = connect
    end

    value = value.to_i
    value = Array.new(1,value)
    value = value.pack('i')
    @@connection.put(key, value)
  end

  # === TT_Accessor用クラスメソッド
  # 本メソッドはTokyoTyrantからキーを元に値を取得するためのメソッドである
  @public
  def self.get(key)
    unless @@connection
      @@connection = connect
    end
    
    value = @@connection.get(key)
    if value == nil
      return value = Array.new(1, 0).pack('i')
    else
      return value
    end
  end

  # === TT_Accessor用クラスメソッド
  # 本メソッドはTokyoTyrantの任意の値をインクリメントするためのメソッドである
  def self.increment_vote(channel, sitecode)
    if Const::Settings::VOTE_STATUS
      unless @@connection
        connect
      end
      key_site = generate_key(channel, sitecode)
      key_total = generate_key(channel, "total")
      @@connection.addint(key_site, 1)
      @@connection.addint(key_total, 1)
    end
  end

  # === TT_Accessor用クラスメソッド
  # 本メソッドはTokyoTyrantに格納用のIDをchannelとsitecodeから作るためのメソッドである
  def self.generate_key(channel, sitecode)
    "#{channel}_#{sitecode}"
  end
    
end
