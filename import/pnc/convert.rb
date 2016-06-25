#!/usr/bin/env ruby
require 'csv'

privateDir = File.dirname(__FILE__) + '/../../private'
stopDate = ARGV[0]
stopDate = Date.parse(stopDate) if stopDate

CSV.open("#{privateDir}/imported.csv", "wb") do |output|
  CSV.foreach("#{privateDir}/activity.csv") do |input_row|
    unless input_row[0] == "Date"
      break if Date.strptime(input_row[0], "%m/%d/%Y") == stopDate
      row = []
      row += input_row[0..1]
      debit = - input_row[2].delete('$').delete(',').to_f
      credit = input_row[3].delete('$').delete(',').to_f
      row << debit + credit
      row += ["$+PNC-C", "", "", ""] 
      output << row
    end
  end
end

