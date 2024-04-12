#!/usr/bin/env ruby

require "optparse"
require 'date'

#コマンドライン引数の処理
options = {}
OptionParser.new do |opts|
  opts.on("-y YEAR", Integer, "Specify the year") do |year|
    options[:year] = year
  end

  opts.on("-m MONTH", Integer, "Specify the month") do |month|
    options[:month] = month
  end
end.parse!

#デフォルト値の設定（オプションの指定がなかったときに使用＝表示するもの）
year = options[:year] || Date.today.year
month = options[:month] || Date.today.month


#ヘッダーの表示
header = "#{month}月 #{year}年"
puts header.center(20)

#カレンダーの表示
puts "日 月 火 水 木 金 土"



#指定月の初日を取得
first_day = Date.new(year, month, 1)

#指定月の最終日を取得
last_day = Date.new(year, month, -1)

#月の日数を取得
days_in_month = (first_day.next_month - first_day).to_i

#初日の曜日を取得
first_day_of_week = first_day.wday

#出力するdayのフォーマットを共通化
def format_day(day)
    day.day.to_s.rjust(2)
end

#　初日の曜日までスペースを表示
print "   " * first_day_of_week

(first_day..last_day).each do |day|
  if Date.today.year == year && Date.today.month == month && Date.today.day == day.day
     print "\e[30;42m#{format_day(day)}\e[0m" + " "
  else
     print format_day(day) + " " 
  end
  puts if (first_day_of_week + day.day) % 7 == 0
end

puts 
