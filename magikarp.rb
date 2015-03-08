require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'awesome_print'
# require 'sinatra'

response_2010 = open 'http://hackny.org/a/2010/06/announcing-the-2010-hackny-fellows/'
response_2011 = open 'http://hackny.org/a/2011/06/class-of-2011-hackny-fellows/'
response_2012 = open 'http://hackny.org/a/2012/06/class-of-2012-hackny-fellows/'

class2010_document = Nokogiri::HTML response_2010 
class2011_document = Nokogiri::HTML response_2011
class2012_document = Nokogiri::HTML response_2012

fellow_rows_2010 = class2010_document.css 'tr'
fellow_rows_2011 = class2011_document.css 'tr'
fellow_rows_2012 = class2012_document.css 'tr'

poke_number = 0 

# 2010!!
fellow_hashes_2010 = fellow_rows_2010.map do |fellow_row|
	row_data = fellow_row.children.select do |child|
		child.text != "\n" 
	end 

	logo_img, company_td, student_td, university_td = row_data 

	# parse from the row
	student_name = defined?(student_td.children.name) ? student_td.children.children.text : student_td.children.text
	# company_name = company_td.children.children.text
	university_name = university_td.children.text

	poke_number += 1 

	{
		# company: company_name,
		name: student_name,
		university: university_name
	}
end

# 2011!!
fellow_hashes_2011 = fellow_rows_2011.map do |fellow_row|
	row_data = fellow_row.children.select do |child|
		child.text != "\n" 
	end 

	student_td, university_td, company_td= row_data 

	student_name = student_td.children.text
	university_name = university_td.children.text
	# company_name = company_td.children.children[1].attributes["alt"].value

	poke_number += 1 

	{
		# company: company_name,
		name: student_name,
		university: university_name
	}
end

# 2012!!
fellow_hashes_2012 = fellow_rows_2012.map do |fellow_row|
	row_data = fellow_row.children.select do |child|
		child.text != "\n" 
	end

	student_td, university_td = row_data

	student_name = student_td.children.children.children.text
	university_name = university_td.children.children.children.text

	{
		# company: company_name,
		name: student_name,
		university: university_name
	}
end




fellow_2010 = fellow_hashes_2010.sort_by do |fellow|
	fellow[:name]
end
fellow_2011 = fellow_hashes_2011.sort_by do |fellow|
	fellow[:name]
end
fellow_2012 = fellow_hashes_2012.sort_by do |fellow|
	fellow[:name]
end

# get '/2010.json' do
#	fellow_hashes.to_json
# end

binding.pry 