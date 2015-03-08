require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'awesome_print'

response = open 'http://hackny.org/a/2010/06/announcing-the-2010-hackny-fellows/'

class2010_document = Nokogiri::HTML response 

fellow_rows = class2010_document.css 'tr'

poke_number = 0 

fellow_hashes = fellow_rows.map do |fellow_row|


	row_data = fellow_row.children.select do |child|
		child.text != "\n" 
	end 

	logo_img, company_td, student_td, university_td = row_data 

	# parse from the row
	student_name = defined?(student_td.children.name) ? student_td.children.children.text : student_td.children.text
	company_name = company_td.children.children.text
	university_name = university_td.children.text

	poke_number += 1 

	{
		company: company_name,
		name: student_name,
		university: university_name
	}
end 

binding.pry 