module ApplicationHelper
  def valid(val)
    val.valid?
    expect(val.errors).to include 'を入力してください'
  end

  def number(num)
    num.valid?
    expect(num.errors).to include 'は数値で入力してください'
  end
end
