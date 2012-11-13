require 'libxml'

# === クラス概要
# このクラスは各形式にデータを変換する
class Data_Convert 

  # === Data_convert用クラスメソッド
  # このメソッドはXML形式のStringを出力する
  def self.to_xml(prime_subtotal, live_subtotal, cinema_subtotal, sum)
    doc = LibXML::XML::Document.new()
    doc.encoding=LibXML::XML::Encoding::UTF_8
    doc.root = LibXML::XML::Node.new('channel')
    root = doc.root

    root << prime = LibXML::XML::Node.new('prime')
    root << live = LibXML::XML::Node.new('live')
    root << cinema = LibXML::XML::Node.new('cinema')
    root << total = LibXML::XML::Node.new('total')
    prime << prime_subtotal
    live << live_subtotal
    cinema << cinema_subtotal
    total << sum
    doc.to_s
  end

  # === Data_Convert用クラスメソッド
  # このメソッドはCSV形式のStringを出力する
  def self.to_csv(prime_subtotal, live_subtotal, cinema_subtotal, total)
    doc = [prime_subtotal, live_subtotal, cinema_subtotal, total]
  end
end
