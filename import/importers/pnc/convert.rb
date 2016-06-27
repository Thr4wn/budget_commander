#!/usr/bin/env ruby
require 'csv'

inputFile= ARGV[0]
outputFile= ARGV[1]
stopDate = ARGV[2]
stopDate = Date.parse(stopDate) if stopDate

CSV.open(outputFile, "wb") do |output|
  CSV.foreach(inputFile) do |input_row|
    unless input_row[0] == "Date"
      if Date.strptime(input_row[0], "%m/%d/%Y") == stopDate
        puts "convert.rb: stopping at stop date #{stopDate}"
        break
      end
      row = []
      row += input_row[0..1]
      debit = - input_row[2].delete('$').delete(',').to_f
      credit = input_row[3].delete('$').delete(',').to_f
      row << debit + credit
      row += ["", "$+PNC-C", "", "", "importing"] 
      output << row
    end
  end
end

