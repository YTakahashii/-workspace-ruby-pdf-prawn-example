require 'prawn'

class ReportPdf < Prawn::Document
  def initialize
    super(page_size: 'A4', margin: [40, 40, 40, 40])
    setup_font
    title
    body
  end

  private

  def setup_font
    font_families.update('NotoSansJP' => {
                           normal: './Noto_Sans_JP/static/NotoSansJP-Regular.ttf',
                           italic: './Noto_Sans_JP/static/NotoSansJP-Regular.ttf',
                           bold: './Noto_Sans_JP/static/NotoSansJP-Bold.ttf',
                           bold_italic: './Noto_Sans_JP/static/NotoSansJP-Bold.ttf'
                         })
    font 'NotoSansJP'
  end

  def title
    text 'バックエンドの検証', size: 30, style: :bold
    move_down 20
  end

  def body
    text '色を変更できます。', color: 'FF0000'
    move_down 20
    text "インラインで <color rgb='ff0000'>色を変更</color>できます。", inline_format: true
    move_down 20
    text "<color rgb='ff0000'><u>色と下線の組み合わせ</u></color>", inline_format: true
    move_down 20
    text "<u><color rgb='ff0000'>色と下線の組み合わせ</color></u>", inline_format: true
    move_down 20
    bullet_item "リストはサポートされていないので、自前で実装している #1 "
    bullet_item "An ecommerce application for online shopping may have several microservices involving order collection, account access, inventory management and shipping."
    move_down 20
    text "An ecommerce application for online shopping may have several microservices involving order collection, account access, inventory management and shipping."
  end


  # prawnでリストは標準サポートされていないので、自前で実装する必要がある
  def bullet_item(string)
    if string.length > 110
      sub_str = string[85..string.length - 1]
      space_index = sub_str.index(' ')
      str1 = string[0..85 + space_index]
      str2 = string[86 + space_index..string.length - 1]
      indent 10, 0 do
        text '* ' + str1, align: :justify
        indent(9) { text str2 }
      end
    else
      indent 10, 0 do
        text '* ' + string, align: :justify
      end
    end
  end
end

pdf = ReportPdf.new
pdf.render_file('exxample.pdf')
